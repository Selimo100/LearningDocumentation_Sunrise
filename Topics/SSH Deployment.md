
### Logs anzeigen

`less [projectname].log
# General
## 1. Mit dem Server verbinden

Öffne dein Terminal und verbinde dich mit dem gewünschten Server:

### 🌐 Webserver:

`ssh user@www`

### 🟩 Node.js-Server:

`ssh user@nodejs`

> Nach der Eingabe deines Passworts wirst du eingeloggt.

---

## 2. Als Admin (root) anmelden

Wechsle in den Administrator-Modus, falls sudo rechte vorhanden:

`sudo -i`

--- 
## 3. Ins directory wechseln

`cd /var/www/<Projektname>`

---
## 4. Projekt pullen vom GitRepo

`git pull`

---

## 5. Service neu starten

`sudo systemctl restart <projekname>.service`

---
# Score & More
## 1. Connect to the server

Öffne dein Terminal und verbinde dich mit dem gewünschten Server:

`ssh p-itlw-01`

> Verbindet mit dem **Production Server**

oder

`ssh t-itlw-01`

> Verbindet mit dem **Test Server**

Du wirst nach deinem **Sunrise Passwort** gefragt. Nach korrekter Eingabe solltest du im Server eingeloggt sein.

---

## 2. Switch to admin (root) user

Sobald du eingeloggt bist, wechsle in den Administrator-Modus:

`sudo -i`

Wenn erfolgreich, sollte dein Prompt so aussehen:

`[root@p-itlw-01 ~]#`

oder

`[root@t-itlw-01 ~]#`

---

## 3. Navigate to the project

Wechsle ins Hauptprojektverzeichnis:

`cd /var/www`

Wähle dann das gewünschte Projekt:

`cd saleschamp-frontend`

oder

`cd saleschamp-backend`

---

## 4. Pull the latest changes from Git

Ziehe den neuesten Code vom Repository:

`git pull`

---

## 5. Restart the service

Starte den entsprechenden Service neu – je nach Projekt:

`systemctl restart saleschamp-frontend`

oder

`systemctl restart saleschamp-backend`

---

## 6. Verify the status

Überprüfe, ob der Service korrekt läuft und keine Fehler anzeigt:

`systemctl status saleschamp-backend`

oder

`systemctl status saleschamp-frontend`