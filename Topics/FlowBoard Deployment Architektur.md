>Kategorie: Deployment / DevOps / Cloud  
>Start: Februar 2026  
>Ziel: Vollständiges, automatisiertes Cloud-Deployment mit Docker, MongoDB Atlas und CI-Mirroring
## Ziel

FlowBoard wird:
- als Docker-Container gebaut
- auf Render als Web Service betrieben
- mit MongoDB Atlas als externer Cloud-Datenbank verbunden
- automatisch bei Push auf `main` deployed (über GitLab → GitHub Mirror)

---

# 1. Architektur

## Lokal (Development)

Docker Compose Setup:

- flowboard-app
- flowboard-mongo

Die App verbindet sich lokal mit dem Mongo-Container über das interne Docker-Netzwerk (`mongo` als Host).

## Produktion (Render)

- Render Web Service (Docker Container)
- MongoDB Atlas (externe Cloud-Datenbank)

Die Datenbank läuft nicht im selben Container wie die App.  
Die Verbindung erfolgt über `MONGODB_URI`.

---

# 2. Docker Setup

## Multi-Stage Dockerfile

Der Container wird in zwei Stufen gebaut:
### Build Stage

- Base Image: `node:20-alpine`
- `npm ci`
- `npm run build`
- Build-Output liegt im Ordner: `build/`
    

### Runtime Stage

- Base Image: `node:20-alpine`
- Nur Production Dependencies (`npm ci --omit=dev`)
- `build/` wird aus der Build-Stage kopiert
- Server-Start:

`node ./build/server/entry.mjs`

### Wichtige Runtime-Konfiguration

Der Server bindet auf:
`HOST=0.0.0.0 PORT=10000`
Render erwartet, dass der Container auf `0.0.0.0` und einem definierten Port lauscht.

---

# 3. MongoDB Atlas Setup

## 3.1 Cluster

- Free Tier (M0)
- Cloud Provider: AWS
- Region: nahe bei Render
- Cluster Name: `flowboard-cluster`

## 3.2 Database User

- Username z.B. `flowboard_usr`
- Authentifizierung per Passwort
- Rechte: Read and write to any database (für MVP)

## 3.3 Network Access

- IP Access List enthält:
    `0.0.0.0/0`
    Damit Render verbinden kann.

## 3.4 Connection String

Beispiel:

`mongodb+srv://USER:PASS@flowboard-cluster.xxxxx.mongodb.net/flowboard?retryWrites=true&w=majority`

Dieser String wird nicht im Code gespeichert, sondern als Environment Variable gesetzt.

---

# 4. Environment Configuration

Die App liest die Datenbank-Verbindung ausschließlich aus Umgebungsvariablen:
`MONGODB_URI MONGODB_DB (optional)`
Wenn `MONGODB_URI` fehlt, bricht die App beim Start mit einem klaren Fehler ab.
Lokal kann optional eine `.env` Datei verwendet werden (nicht commiten).

---

# 5. GitLab → GitHub Auto Mirror

Da das Hauptrepository auf einer self-hosted GitLab-Instanz liegt, wurde ein automatisches Mirror-Setup implementiert.

## 5.1 GitHub Token

- Personal Access Token (classic)
- Scope: `repo`

Token wurde in GitLab gespeichert als:
`GITHUB_TOKEN`
Masked und Protected.

## 5.2 GitLab CI Konfiguration

`.gitlab-ci.yml`:

``` yml
stages:
  - mirror

mirror_to_github:
  stage: mirror
  rules:
    - if: '$CI_COMMIT_BRANCH == "main"'
  before_script:
    - git config --global user.email "ci-mirror@flowboard.local"
    - git config --global user.name "GitLab Mirror Bot"
  script:
    - git remote remove github 2>/dev/null || true
    - git remote add github https://Selimo100:${GITHUB_TOKEN}@github.com/Selimo100/FlowBoard.git
    - git push github HEAD:refs/heads/main

```

Ergebnis:

Push auf `main` in GitLab →  
CI läuft →  
Repo wird automatisch nach GitHub gespiegelt.

---

# 6. Render Deployment

## 6.1 Web Service erstellen

In Render:

- New → Web Service
- GitHub Repository auswählen
- Runtime: Docker
- Branch: `main`
- Root Directory: leer (Dockerfile im Root)
    

## 6.2 Environment Variables in Render

Mindestens:
`MONGODB_URI = <Atlas Connection String>`
Optional:
`MONGODB_DB = flowboard PORT = 10000 HOST = 0.0.0.0`

## 6.3 Deployment

- Render baut das Dockerfile
- Container startet mit:
    `node ./build/server/entry.mjs`
    

## 6.4 Health Check

Route:
`GET /health`
Antwort:
`{"status":"ok"}`
Diese Route dient ausschließlich zur Container-Verifikation und hängt nicht von der Datenbank ab.

---

# 7. Deployment Flow (Automatisiert)

1. Developer pusht auf GitLab `main`
2. GitLab CI spiegelt nach GitHub
3. Render erkennt neuen Commit auf GitHub `main`
4. Render baut Docker Image
5. Render startet neuen Container
6. App verbindet sich mit MongoDB Atlas

---

# 8. Produktions-Setup Eigenschaften

- App und Datenbank getrennt
- Keine Hardcoded Credentials
- Environment-basierte Konfiguration
- Multi-Stage Docker Build
- Automatisches Deployment
- Cloud-basierte Datenbank
- Skalierbares SaaS-fähiges Setup



![[Pasted image 20260217112734.png]]
![[Pasted image 20260217114830.png]]
