> Kategorie: Schnittstellen / Azure / Automatisierung  
> Erstellt: 03.12.2025  
> Ziel: Verstehen, wie Graph API funktioniert und wie ich sie im Projekt anwenden kann.

---

## 🔍 Was ist die Microsoft Graph API?

Die **Microsoft Graph API** ist die zentrale Schnittstelle von Microsoft 365.  
Über sie kann man **auf fast alle Microsoft-Dienste zugreifen**, z. B.:

- Outlook (E-Mails)
- OneDrive
- Teams
- Azure Active Directory (Benutzer & Gruppen)
- Kalender
- Kontakte
- SharePoint
- Tasks / Planner

Sie fasst die verschiedenen Microsoft-Dienste in **eine einzige REST-API** zusammen statt mehrere einzelne Schnittstellen zu haben.

Kurz gesagt:  
**Eine API, um (fast) alles im Microsoft-Universum anzusprechen.**

---

##  Wie funktioniert die Graph API?

Die Graph API basiert auf **HTTP-Requests**, meistens GET, POST, PATCH, DELETE.

### Beispiel:

`GET https://graph.microsoft.com/v1.0/me`

Dieser Request holt alle Informationen zum aktuell angemeldeten Benutzer.

### Authentifizierung

Die Authentifizierung läuft über **Azure AD** mittels:

- OAuth 2.0
- Access Token
- Rollen und Berechtigungen (Scopes)

Ohne Token kein Zugriff.  
Der Ablauf ist:

1. App registrieren (Azure Portal)
2. Berechtigungen setzen (z. B. "Mail.Read")
3. Token holen
4. API-Call damit ausführen

---

## Berechtigungen (Scopes)

Es gibt zwei Arten von Berechtigungen:

### **Delegierte Berechtigungen**

– Benutzer ist eingeloggt  
– App handelt im Namen des Users  
Beispiel: E-Mail des Users lesen

### **Application Permissions**

– Keiner ist eingeloggt  
– App arbeitet allein als "Service"  
Beispiel: Alle Benutzer eines Unternehmens auslesen

---

## Typische Anwendungsfälle

### E-Mails lesen oder senden:

`POST https://graph.microsoft.com/v1.0/me/sendMail`

### Termine aus dem Kalender holen:

`GET https://graph.microsoft.com/v1.0/me/events`

### Benutzer aus Azure AD holen:

`GET https://graph.microsoft.com/v1.0/users`

### Dateien aus OneDrive:

`GET https://graph.microsoft.com/v1.0/me/drive/root/children`

---

## Warum ist Graph API so praktisch?

- **Einheitliche Struktur:** gleiche URL-Logik über alle Dienste hinweg
- **Gut dokumentiert:** Microsoft hat extrem viele Beispiele
- **Sicher:** Token-basiert mit klaren Berechtigungen
- **Skalierbar:** perfekt für grosse Firmen (wie Sunrise)
- **Automatisierbar:** ideal für Hintergrundjobs

---

## Aha-Momente

- Ich brauche **kein Exchange- oder Outlook-spezifisches API** → alles geht über Graph.
- Permissions sind das schwierigste Thema – wenn etwas nicht geht, liegt es zu 90% an falschen Scopes.
- Microsoft stellt eine **Explorer-Oberfläche** bereit, wo man Calls testen kann:  
    [https://developer.microsoft.com/en-us/graph/graph-explorer](https://developer.microsoft.com/en-us/graph/graph-explorer)
- Graph API eignet sich sehr gut für Automatisierung, z. B.:
    - automatische Reminder
    - E-Mail-Benachrichtigungen
    - Kalender-Einträge erstellen
    - Userdaten abfragen
- Fast jede Funktion in Office 365 lässt sich damit programmgestürt ausführen.

---

## Beispiel: E-Mail automatisch senden

So könnte ein POST-Request aussehen:

`{   "message":{     "subject": "Score&More Benachrichtigung",     "body": {       "contentType": "Text",       "content": "Hallo, es gibt neue Informationen."     },     "toRecipients": [       {         "emailAddress": {           "address": "beispiel@sunrise.ch"         }       }     ]   },   "saveToSentItems": "true" }`

---

## 🧪 Was muss ich für die Verwendung vorbereiten?

1. **App Registration** in Azure
2. Redirect-URL setzen
3. Rechte vergeben (Mail.Send, User.Read, etc.)
4. Admin Consent einholen
5. Token-Flow implementieren
6. Request an Graph senden

Wenn das einmal steht, ist der Rest nur noch "API-Call" und läuft stabil.

---

## 📎 Weiterführende Links

- Microsoft Graph Explorer  
    [https://developer.microsoft.com/en-us/graph/graph-explorer](https://developer.microsoft.com/en-us/graph/graph-explorer)
- Quickstart (super verständlich)  
    https://learn.microsoft.com/en-us/graph/quick-start
- Berechtigungen erklärt  
    [https://learn.microsoft.com/en-us/graph/permissions-reference](https://learn.microsoft.com/en-us/graph/permissions-reference)