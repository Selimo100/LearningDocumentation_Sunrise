> Kategorie: Semesterprojekt / Architektur / Lerntransfer  
> Start: Februar 2026  
> Ziel: Theorie aus der Berufsschule praktisch anwenden und vertiefen

---

## Warum mache ich dieses Projekt?

Dieses SMART-Semesterprojekt dient nicht nur dazu, eine funktionierende Anwendung zu entwickeln, sondern vor allem dazu, **Schultheorie in reale Praxis zu übertragen**.

Ich möchte:
- NoSQL nicht nur theoretisch verstehen, sondern produktiv einsetzen
- Docker nicht nur erklären können, sondern real deployen
- Cloud-Deployment selbst umsetzen
- Architekturentscheidungen bewusst treffen
- ein vollständiges, eigenständiges Projekt von Idee bis Deployment umsetzen
    

Dieses Projekt zwingt mich, **ganzheitlich zu denken**:  
Architektur, Datenmodell, Sicherheit, Deployment, UX und Wartbarkeit.

---

# Projektbeschreibung

FlowBoard ist eine webbasierte Anwendung, mit der Lernende ihre Projekte strukturiert planen und verwalten können.

Die Anwendung bietet:

- Benutzer-Login
- Projektverwaltung mit Git-Repository-Verknüpfung
- Konfigurierbare Kanban-Boards
- Sprint-Management
- Containerisierung
- Cloud-Deployment
    

Die Lösung wird containerisiert betrieben und in einer Cloud-Umgebung deployt.

---

#  Was lerne ich konkret neu?

## NoSQL in der Praxis (MongoDB)

In der Schule lerne ich relationale Modelle (SQL).  
Hier wende ich bewusst **NoSQL** an.

Neu für mich:

- Dokumentenbasierte Datenstruktur
- Hierarchische Datenmodelle (Projekt → Board → Liste → Issue)
- Flexible Schemas
- Embedded Documents vs. Referenzen
- Datenmodellierung ohne Foreign Keys
- Denormalisierung bewusst einsetzen
    

Warum wichtig?

Kanban-Boards sind stark hierarchisch.  
NoSQL passt konzeptionell besser als klassische relationale Tabellen.

---

## Docker & Containerisierung

Ich lerne:

- Dockerfiles schreiben
- Multi-Service-Setups
- docker-compose verwenden
- Umgebungsvariablen sauber trennen
- Reproduzierbare Entwicklungsumgebungen
- Unterschiede zwischen Dev- und Production-Setup
    

Das ist direkte Anwendung von:

- Modul DevOps
- CI/CD-Theorie
- Infrastruktur-Grundlagen
    

---

##  Cloud-Deployment

Mit Render lerne ich:

- Container in der Cloud deployen
- Git-Integration
- Environment Variables in Production
- Logging & Monitoring
- Service-Konfiguration
    

Das verbindet Theorie mit:

- Netzwerktechnik
- Serverkonzepte
- Deployment-Strategien
    

---

## Architektur-Verständnis

Ich arbeite mit:

- Astro (SSR + API Routes)
- Trennung von Frontend & Backend-Logik
- API-Design (CRUD)
- Session-Management
- Passwort-Hashing
- Authentifizierung
    

Ich denke nicht nur als Entwicklerin,  
sondern beginne, wie eine **Architektin** zu denken.

---

# Technisches Konzept

## Architektur

Monolithische Webanwendung mit:

- Frontend (Astro + Tailwind)
- Backend (Astro API Routes)
- MongoDB Atlas (NoSQL)
- Docker (Containerisierung)
- Render (Cloud Hosting)
    
Server Side Rendering wird verwendet.

---

## Technologie-Stack

Frontend:

- Astro
- Tailwind CSS
- Islands Architecture

Backend:
- API Endpoints
- CRUD-Logik
- Authentifizierung
    

Datenbank:
- MongoDB Atlas

Deployment:
- Docker
- Render

---

# 📊 Funktionsumfang

## Benutzerverwaltung

- Registrierung
- Login
- Session-Management
- Geschützte Projekte
    

## Projektverwaltung

- Projekt erstellen
- Git-Repository verknüpfen
- Projekte wechseln

## Issue Boards
- Standardlisten (Backlog, Sprint, In Progress, etc.)
- Eigene Listen erstellen
- Drag & Drop zwischen Listen

## Issues

- Titel
- Beschreibung
- Priorität
- Story Points
- Sprint-Zuweisung
    

## Sprint-Management

- Sprint erstellen
- Aktivieren / Abschliessen    
- Fortschritt anzeigen
- Export

---

# Theorie → Praxis Transfer

|Schulthema|Anwendung im Projekt|
|---|---|
|NoSQL|MongoDB Datenmodell|
|Docker|Containerisierung|
|DevOps|Reproduzierbare Builds|
|Netzwerke|Cloud Deployment|
|Security|Passwort-Hashing|
|Datenmodellierung|Dokumentenstruktur|
|Projektmanagement|Kanban & Sprints|

---

# Persönliche Lernziele

- Ich will Infrastruktur verstehen, nicht nur Code schreiben
- Ich will moderne Webarchitektur anwenden
- Ich will Deployment selbstständig durchführen
- Ich will ein Projekt von Grund auf selbst designen
- Ich will Theorie nicht nur für Prüfungen lernen, sondern praktisch einsetzen

---

#  Aha-Momente bisher

- NoSQL zwingt mich anders zu denken als relationale Modelle
- Docker ist einfacher, wenn man das Konzept einmal verstanden hat
- Architekturentscheidungen sind wichtiger als einzelne Codezeilen
- Planung (Backlog, User Stories) spart enorm Zeit