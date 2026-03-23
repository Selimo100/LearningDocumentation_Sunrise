
> Kategorie: Debugging / Dev Environment  
> Kontext: Company Laptop Proxy Issue

---

# Problem

Ich hatte auf meinem Company Laptop einen Proxy gesetzt, um auf interne Ressourcen zugreifen zu können.
Dabei habe ich den Proxy **global in VS Code konfiguriert**, was dazu geführt hat, dass:
- externe Requests nicht mehr funktioniert haben
- Extensions / Marketplace nicht geladen wurden
- Fehler wie `ERR_PROXY_CONNECTION_FAILED` aufgetreten sind

Das Problem war, dass der Proxy **auch ausserhalb des Company-Kontexts aktiv war**.

---
# Ursache

Der Proxy war in den **globalen VS Code Settings** gesetzt:
```
"http.proxy": "http://..."
```
Dadurch wurde jeder Request über diesen Proxy geleitet, auch wenn er gar nicht erreichbar war.

---
# Lösung: Proxy nur projektbezogen setzen

Anstatt den Proxy global zu definieren, kann man ihn **nur für ein spezifisches Projekt (Workspace)** setzen.

---
# Umsetzung
## 1. Projekt öffnen
Projekt normal in VS Code öffnen.

---
## 2. Workspace Settings öffnen

Cmd + Shift + P  
→ Preferences: Open Workspace Settings (JSON)

---
## 3. Proxy konfigurieren

Datei: `.vscode/settings.json`
```json
{  
  "http.proxy": "http://p-proxy-inf.swi.srse.net:8080",  
  "http.proxySupport": "on"  
}
```
---

## 4. Datei-Struktur
```
project/  
├── .vscode/  
│   └── settings.json  
├── src/  
└── ...
```

---

# Optional: Git Ignore

Da der Proxy oft **persönlich oder firmenintern** ist:
.vscode/*  
!.vscode/extensions.json

---

# Globalen Proxy entfernen

In den **User Settings**:
```json
{  
  "http.proxy": "",  
  "http.proxySupport": "off"  
}
```
---

# Wichtige Erkenntnisse

- Workspace Settings überschreiben globale Settings
- Global gesetzte Proxies können unerwartete Fehler verursachen
- VS Code Proxy gilt **nur für VS Code selbst**, nicht für Terminal

Für Terminal benötigt man ggf.:

HTTP_PROXY  
HTTPS_PROXY

---

# Was ich daraus gelernt habe

- Environment-Konfiguration sollte möglichst **lokal und scoped** sein
- Globale Settings können schnell zu schwer nachvollziehbaren Fehlern führen
- Debugging beginnt oft bei der Umgebung, nicht beim Code
- Kleine Konfigurationsfehler können grosse Auswirkungen haben

---
# 📌 Fazit

Der Proxy sollte nur dort gesetzt werden, wo er wirklich gebraucht wird:
- nicht global
- sondern projektbezogen

So bleibt die Entwicklungsumgebung stabil und flexibel.