Ins richtige Verzeichnis navigieren :
```bash
cd /usr/local/sbin
```

File erstellen:
```bash
sudo touch loadtest.sh
```

Template ins File schreiben:
``` bash
#!/usr/bin/env bash
# Einfacher Lasttest: startet N gleichzeitige Sessions gegen eine URL
# Schreibt danach einen kleinen Report mit den wichtigsten Kennzahlen.
# Nutzung: ./loadtest.sh https://deine-url.tld 1700

set -euo pipefail
URL="${1:-}"
CONCURRENCY="${2:-1700}"
if [[ -z "$URL" ]]; then
echo "Usage: $0 <URL> [concurrency]"

exit 1

fi

REPORT_DIR="/var/log/loadtest"
REPORT_FILE="${REPORT_DIR}/loadtest_$(date +%Y%m%d_%H%M%S).log"
mkdir -p "$REPORT_DIR"
echo "Starte Lasttest:" | tee -a "$REPORT_FILE"
echo " URL: $URL" | tee -a "$REPORT_FILE"
echo " Sessions: $CONCURRENCY" | tee -a "$REPORT_FILE"
echo | tee -a "$REPORT_FILE"

# Check: curl vorhanden?
if ! command -v curl >/dev/null 2>&1; then

echo "Fehler: curl ist nicht installiert. Installiere z.B. mit:" | tee -a "$REPORT_FILE"
echo " sudo dnf install -y curl" | tee -a "$REPORT_FILE"

exit 1

fi

# Optional: ulimit anzeigen (offene Dateien/Prozesse)
echo "Aktuelles Limit für offene Dateien:" | tee -a "$REPORT_FILE"
ulimit -n 2>&1 | tee -a "$REPORT_FILE"
echo | tee -a "$REPORT_FILE"
START_TIME=$(date +%s)

# temporäre Datei für Statuscodes
TMP_CODES=$(mktemp)
session_request() {
local id="$1"

HTTP_CODE=$(curl -s -S -o /dev/null -w "%{http_code}" "$URL" || echo "000")
echo "$HTTP_CODE" >> "$TMP_CODES"
echo "Session #$id -> HTTP $HTTP_CODE"
}

export -f session_request
export URL TMP_CODES

# Starte N Sessions parallel
seq 1 "$CONCURRENCY" | xargs -P "$CONCURRENCY" -n1 bash -c 'session_request "$@"' _ | tee -a "$REPORT_FILE"
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

# Auswertung der Ergebnisse
total_requests=$(wc -l < "$TMP_CODES")
success_200=$(grep -c '^200$' "$TMP_CODES" || true)
errors_4xx=$(grep -E '^4[0-9][0-9]$' "$TMP_CODES" | wc -l || true)
errors_5xx=$(grep -E '^5[0-9][0-9]$' "$TMP_CODES" | wc -l || true)
errors_other=$(grep -Ev '^(200|4[0-9][0-9]|5[0-9][0-9])$' "$TMP_CODES" | wc -l || true)

rm -f "$TMP_CODES"

echo | tee -a "$REPORT_FILE"
echo "===== Lasttest-Report =====" | tee -a "$REPORT_FILE"
echo "Dauer: ${DURATION} Sekunden" | tee -a "$REPORT_FILE"
echo "Gesamt Requests: ${total_requests}" | tee -a "$REPORT_FILE"
echo "HTTP 200 (OK): ${success_200}" | tee -a "$REPORT_FILE"
echo "HTTP 4xx (Client-Fehler): ${errors_4xx}" | tee -a "$REPORT_FILE"
echo "HTTP 5xx (Server-Fehler): ${errors_5xx}" | tee -a "$REPORT_FILE"
echo "Sonstige/Fehler: ${errors_other}" | tee -a "$REPORT_FILE"
echo "Report gespeichert unter: $REPORT_FILE" | tee -a "$REPORT_FILE"

exit 0
```

Ausführen:
```bash
# Url angeben und Anzahl Sessions, die geöffnet werden sollen
/usr/local/sbin/loadtest.sh "http://localhost:8080" 10000
```