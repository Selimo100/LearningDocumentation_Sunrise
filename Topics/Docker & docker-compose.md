> Kategorie: DevOps / Deployment / Infrastruktur  
> Erstellt: 20.01.2026  
> Ziel: Verstehen, wie Applikationen reproduzierbar und sauber deployt werden können.

---

## 🔍 Was ist Docker?

**Docker** ist eine Plattform, mit der Applikationen in sogenannten **Containern** laufen.  
Ein Container enthaelt:

- die Applikation
    
- alle Abhaengigkeiten
    
- eine definierte Laufzeitumgebung
    

➡️ Dadurch laeuft die App **ueberall gleich**, egal ob lokal, auf einem Server oder im Testsystem.

---

## 🧩 Zentrale Begriffe

- **Image:** Vorlage (Blueprint) fuer einen Container
    
- **Container:** Laufende Instanz eines Images
    
- **Dockerfile:** Bauanleitung fuer ein Image
    
- **docker-compose:** Tool, um mehrere Container gemeinsam zu starten
    

---

## 🛠️ Dockerfile – Grundidee

Ein Dockerfile beschreibt Schritt fuer Schritt, wie ein Image gebaut wird.

### Beispiel (Backend – Spring Boot):

`FROM eclipse-temurin:17-jdk WORKDIR /app COPY target/app.jar app.jar EXPOSE 8080 ENTRYPOINT ["java", "-jar", "app.jar"]`

➡️ Ergebnis: Ein Image, das das Backend starten kann.

---

## 🧱 Fullstack mit separaten Dockerfiles

In einem Fullstack-Projekt gibt es meist:

- Frontend (React)
    
- Backend (Spring Boot)
    
- Datenbank (MariaDB/Postgres)
    

Jede Komponente bekommt **ihr eigenes Dockerfile**, um sauber getrennt zu bleiben.

Vorteile:

- bessere Wartbarkeit
    
- gezieltes Rebuilden
    
- klare Verantwortlichkeiten
    

---

## 🔗 docker-compose – mehrere Services starten

Mit **docker-compose** koennen mehrere Container gleichzeitig gestartet werden.

### Beispiel `docker-compose.yml`:

``` yml
version: "3.9"

services:
  backend:
    build: ./backend
    ports:
      - "8080:8080"
    depends_on:
      - db

  frontend:
    build: ./frontend
    ports:
      - "3000:3000"

  db:
    image: mariadb:11
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: journey
```

➡️ Ein Befehl startet alles:

`docker-compose up`

---

## 💡 Aha-Momente

- Docker ersetzt kein Deployment-Tool, sondern standardisiert Umgebungen
    
- Fehler entstehen oft durch Volumes oder Ports, nicht durch Docker selbst
    
- docker-compose ist ideal fuer **lokale Entwicklung und Testserver**
    
- Ohne Dockerfile kein reproduzierbares Setup
    

---

## 📌 Einsatz in meinen Projekten

- **Journey:** Testserver mit Frontend + Backend + DB
    
- **Score&More:** Vorbereitung fuer sauberes Testing nach Releases
    
- Lernziel: Infrastruktur besser verstehen, nicht nur Code schreiben