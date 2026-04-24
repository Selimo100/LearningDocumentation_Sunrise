>Link zu meiner Doku für Service Fulfillment:
https://sunrisecomm-my.sharepoint.com/:o:/g/personal/selina_mogicato_sunrise_net/IgC-pc1mfeoOR5fJ6-v6sD_aAUcTiIRJuvALsp6IPRX4bOY?e=P180Hj

# April 2026

---

## Ziel dieses Journals

Dieses Journal dokumentiert meinen Einstieg in **Service Fulfillment** und insbesondere in das Projekt **Building Service**.  
Da das Projekt deutlich grösser und komplexer ist als meine bisherigen Projekte, halte ich hier fest, wie ich mich Schritt für Schritt eingearbeitet habe, welche Erkenntnisse ich gewonnen habe und wie ich weiter vorgehen möchte.

---

## Woche 1 – Einstieg und erstes Verständnis

### Hauptthemen

- Projekt lokal bauen
- Technologien verstehen
- Modulstruktur analysieren
- Erste technische Zusammenfassung erstellen

---

### Was habe ich gemacht?

In der ersten Woche habe ich begonnen, mich in den **Building Service** einzuarbeiten. Mein erstes Ziel war es, das Projekt überhaupt lokal zu verstehen und lauffähig zu bekommen.

Dafür habe ich das Projekt mit **Maven** lokal gebaut und mich mit den wichtigsten Technologien beschäftigt. Ich habe mir angeschaut, welche Rolle **Spring Boot**, **WebFlux**, **GraphQL**, **gRPC**, **Elasticsearch**, **PostgreSQL**, **Maven** und **Protocol Buffers** im Projekt spielen.

Ein grosser Teil meiner Arbeit bestand darin, die **Projektstruktur** zu verstehen. Der Building Service ist ein Multi-Module-Maven-Projekt. Ich habe mir deshalb die einzelnen Module angeschaut und dokumentiert, wofür sie zuständig sind.

Die wichtigsten Module sind:

- `building-service-starter`
- `building-service-index`
- `building-service-grpc`
- `building-client`
- `building-service-loader`
- `building-service-fuzzy-test`

Ich habe mir dazu Notizen und ein Diagramm erstellt, damit ich besser verstehe, wie die Module zusammenhängen.

---

### Was habe ich gelernt?

Ich habe gelernt, dass grosse Enterprise-Projekte am Anfang sehr überwältigend wirken können, wenn man direkt in den Code springt. Viel sinnvoller ist es, zuerst die **Architektur und Verantwortlichkeiten** zu verstehen.

Besonders wichtig war für mich die Erkenntnis, dass jedes Modul eine klare Aufgabe hat:

- `starter` ist die eigentliche laufende Applikation
- `index` enthält Datenmodelle und Elasticsearch-Repositories
- `grpc` definiert den API-Vertrag
- `client` ist für interne gRPC-Aufrufe gedacht
- `loader` lädt Daten in Elasticsearch
- `fuzzy-test` testet Such- und Normalisierungslogik

Dadurch wurde das Projekt für mich deutlich greifbarer.

---

## Woche 2 – Systemflow und Endpoint-Verständnis

### Hauptthemen

- API-Flow verstehen
- REST, GraphQL und gRPC vergleichen
- Relevante Klassen identifizieren
- Vorgehensplan erstellen

---

### Was habe ich gemacht?

In der zweiten Woche habe ich mich stärker mit dem **technischen Flow** des Systems beschäftigt. Ich wollte verstehen, wie eine Anfrage durch das Projekt läuft.

Der wichtigste Flow, den ich mir notiert habe, ist:

API → Service → Repository → Elasticsearch

Das bedeutet: Eine Anfrage kommt über eine API-Schicht rein, wird an die Service-Schicht weitergegeben, landet in einem Repository und wird dort als Elasticsearch-Query ausgeführt.

Ich habe mir verschiedene relevante Klassen und Dateien angeschaut, unter anderem:

- `GraphqlController`
- `DefaultBuildingServiceGrpc`
- `BuildingSearchController`
- `BuildingService`
- `ReactiveBuildingDocRepository`
- `BuildingDocRepositoryImpl`
- `BuildingDoc`
- `SearchParametersDto`
- `SearchParameters`
- relevante Converter
- `buildingservice.proto`

Zusätzlich habe ich begonnen, die bestehenden Endpoints zu analysieren. Dabei ging es darum herauszufinden, welche Endpoints bereits ähnliche Informationen liefern und welche für eine neue Anforderung wiederverwendet werden könnten.

Ich habe dafür REST-, GraphQL- und gRPC-Endpoints verglichen.

---

### Was habe ich gelernt?

Ich habe gelernt, dass ein grosses Backend oft mehrere API-Arten gleichzeitig anbietet. In diesem Projekt existieren **REST, GraphQL und gRPC** nebeneinander.

Das war für mich spannend, weil ich dadurch gesehen habe, dass nicht jede Schnittstelle denselben Zweck erfüllt:

- REST ist gut für klassische HTTP-Endpunkte
- GraphQL ist flexibel für Frontend-Abfragen
- gRPC ist stark typisiert und effizient für interne Kommunikation

Ich habe auch besser verstanden, dass man vor einer neuen Implementation zuerst prüfen sollte, was bereits existiert. Oft ist es besser, bestehende Logik wiederzuverwenden, statt etwas komplett neu zu bauen.

---

## Woche 3 – Endpoint-Analyse und praktische Vorbereitung

### Hauptthemen

- Postman / Swagger vorbereiten
- Endpoints auswählen
- Cheatsheet schreiben
- Vorgehen mit Mihaela abstimmen

---

### Was habe ich gemacht?

In dieser Phase habe ich mir überlegt, welche Endpoints ich genauer analysieren möchte. Ich habe mir sinnvolle REST-, GraphQL- und gRPC-Endpoints ausgesucht, die ich später mit Postman oder einem gRPC-Client testen will.

Dabei habe ich mich vor allem auf Endpoints konzentriert, die für Gebäude-, Strassen- und Suchfunktionen relevant sind.

Beispiele:

- Street Autocomplete
- Building Number Autocomplete
- Search Buildings
- Find Building by ID
- Unified Building

Ich habe ausserdem ein **Cheatsheet** geschrieben, in dem ich festgehalten habe, welche Schritte nötig waren, um das Projekt lokal zum Laufen zu bringen. Dazu gehören auch Themen wie Truststore, Proxy und benötigte Tickets.

Mit Mihaela habe ich einen Checkpoint gemacht und meinen geplanten Ablauf besprochen. Danach habe ich meinen Plan nochmals strukturiert und ihr geschickt, damit sie nachvollziehen kann, wie ich an die Aufgabe herangehen möchte.

---

### Was habe ich gelernt?

Ich habe gelernt, dass es bei solchen Projekten nicht reicht, nur den Code zu lesen. Man muss die Endpoints auch **praktisch testen**, um wirklich zu verstehen, was sie zurückgeben.

Ausserdem habe ich gemerkt, dass saubere Dokumentation mir hilft, den Überblick zu behalten. Gerade bei einem Projekt mit vielen Modulen, Technologien und Schnittstellen ist es sehr wichtig, alles Schritt für Schritt festzuhalten.

Der Austausch mit Mihaela war hilfreich, weil ich so sicherstellen konnte, dass ich nicht in eine falsche Richtung arbeite.

---

## Technisches Verständnis

### Projektidee

Der Building Service ist ein Backend-Microservice, der als zentrale Such- und Referenzschicht für Gebäude- und Adressdaten dient.

Er ermöglicht unter anderem:

- Gebäudesuche
- Adressnormalisierung
- Autocomplete für Orte und Strassen
- Suche nach Gebäude-IDs
- Zugriff über REST, GraphQL und gRPC

Die Daten werden primär in **Elasticsearch** abgefragt, weil Elasticsearch sehr gut für schnelle Suchanfragen, Autocomplete und fuzzy Search geeignet ist.

---

## Architektur

### Vereinfachter Flow

Client  
  ↓  
API Layer  
  ↓  
Service Layer  
  ↓  
Repository Layer  
  ↓  
Elasticsearch

### Modulübersicht

|Modul|Aufgabe|
|---|---|
|`building-service-starter`|Hauptapplikation, REST/GraphQL/gRPC|
|`building-service-index`|Domain-Objekte, Elasticsearch-Repositories|
|`building-service-grpc`|gRPC-Vertrag mit `.proto` Dateien|
|`building-client`|Client-Library für gRPC|
|`building-service-loader`|Importiert Daten aus PostgreSQL nach Elasticsearch|
|`building-service-fuzzy-test`|Tests für Fuzzy Search und Normalisierung|

---

## Wichtige Erkenntnisse

### 1. Nicht direkt coden

Mein erster Impuls wäre oft, direkt in den Code zu springen. Bei diesem Projekt habe ich aber gemerkt, dass das nicht sinnvoll ist.  
Zuerst muss ich verstehen:

- Welche Module gibt es?
- Welche Schicht macht was?
- Wo beginnt ein Request?
- Wo wird gesucht?
- Wo wird gemappt?
- Welche Objekte werden zurückgegeben?

Erst dann macht eine Implementation Sinn.

---

### 2. REST, GraphQL und gRPC haben unterschiedliche Rollen

Ich habe gesehen, dass ein System mehrere Schnittstellen anbieten kann, ohne dass sie redundant sind.

REST ist klassisch und leicht testbar.  
GraphQL ist flexibel für Clients.  
gRPC ist effizient und stark typisiert.

Das hilft mir, API-Design differenzierter zu verstehen.

---

### 3. Elasticsearch ist keine normale Datenbank

Elasticsearch wird hier nicht als klassische relationale Datenbank verwendet, sondern als Suchindex.

Das bedeutet:

- Daten kommen aus einem anderen Quellsystem
- Der Loader schreibt sie in Elasticsearch
- Queries sind auf Suche und Performance optimiert
- Mappings und Dokumentstrukturen sind sehr wichtig

---

### 4. Build- und Umgebungsprobleme gehören dazu

Ich habe mich auch mit Truststore, Maven und Proxy beschäftigt. Dabei habe ich gelernt, dass lokale Entwicklungsumgebungen in Firmen oft komplexer sind als private Projekte.

Damit Maven intern Dependencies laden kann, braucht es:

- den richtigen Proxy
- ein Truststore mit internen Zertifikaten
- korrekt gesetzte `MAVEN_OPTS`

Das war zwar mühsam, aber sehr lehrreich.

---

## Mein aktueller Plan

Als Nächstes möchte ich:

1. Einen bestehenden Endpoint vollständig von Anfang bis Ende verfolgen
2. REST-Endpoints in Postman testen
3. GraphQL-Queries testen
4. gRPC-Methoden testen
5. Die Responses vergleichen
6. Herausfinden, welcher bestehende Endpoint am nächsten an die neue Anforderung kommt
7. Danach erst das Design für einen neuen Endpoint definieren

---

## Persönliche Reflexion

Der Einstieg in Service Fulfillment war anspruchsvoll, aber auch sehr spannend.  
Ich merke, dass ich hier in einem viel grösseren und professionelleren System arbeite als bei meinen bisherigen Projekten.

Besonders wertvoll ist, dass ich nicht nur neue Technologien sehe, sondern auch lerne, wie grosse Systeme in echten Unternehmensumgebungen aufgebaut sind.

Ich freue mich darauf, weiter mit **Tino und Mihaela** zusammenzuarbeiten, weil ich dabei sehr viel über Architektur, Schnittstellen und saubere Analyse lernen kann.

Für mich ist dieses Projekt eine gute Gelegenheit, meine bisherige Erfahrung aus Journey, FlowBoard und Score&More auf ein grösseres Enterprise-System zu übertragen.

  
![](https://chc-onenote.officeapps.live.com.mcas.ms/o/GetImage.ashx?WOPIsrc=https%3A%2F%2Fsunrisecomm%2Dmy%2Esharepoint%2Ecom%2Fpersonal%2Fselina%5Fmogicato%5Fsunrise%5Fnet%2F%5Fvti%5Fbin%2Fwopi%2Eashx%2Ffiles%2F3b673184978c481984046f988c142ab5&access_token=eyJhbGciOiJSUzI1NiIsImtpZCI6IkM4Q0RCQjg0MTNGOEQ2NDI3RkUzNUJGODg3QTJBQTkwREVCNDJFNTciLCJ0eXAiOiJKV1QiLCJ4NXQiOiJ5TTI3aEJQNDFrSl80MXY0aDZLcWtONjBMbGMifQ%2EeyJuYW1laWQiOiIwIy5mfG1lbWJlcnNoaXB8c2VsaW5hLm1vZ2ljYXRvQHN1bnJpc2UubmV0IiwibmlpIjoibWljcm9zb2Z0LnNoYXJlcG9pbnQiLCJpc3VzZXIiOiJ0cnVlIiwiY2FjaGVrZXkiOiIwaC5mfG1lbWJlcnNoaXB8MTAwMzIwMDM5ZTY4ZTBjMkBsaXZlLmNvbSIsInNoYXJpbmdpZCI6IjAwMzA4ZGNhLTkxNDctMzc3MC02ODcxLTEwYjE4Y2Y3NTE5YyIsInNpZ25pbl9zdGF0ZSI6IltcImttc2lcIl0iLCJ1dGkiOiJocHBacHlGSVJrcUNvTXp3OXI0aUFBIiwib2lkIjoiYTdiNjU0MjUtZjdlOC00M2VjLWI0NjctYjg2MDQ0MWY1ZDQyIiwiaXNsb29wYmFjayI6IlRydWUiLCJhcHBjdHgiOiIzYjY3MzE4NDk3OGM0ODE5ODQwNDZmOTg4YzE0MmFiNTtuRHJYbDUxQiszS01MNjc2Ti9iSVhTWEZZUTg9O0RlZmF1bHQ7OzdGRkZGRkZGRkZGQkZGRkY7VHJ1ZTs7OzE4NTE5NzI7ZTkyMDBkYTItMTBlMi0wMDAxLWUxYzgtNGJlNTZlZmFiMDQ3IiwiZmlkIjoiMTg4NzgzIiwiaXNzIjoiMDAwMDAwMDMtMDAwMC0wZmYxLWNlMDAtMDAwMDAwMDAwMDAwQDkwMTQwMTIyLTg1MTYtMTFlMS04ZWZmLTQ5MzA0OTI0MDE5YiIsImF1ZCI6IndvcGkvc3VucmlzZWNvbW0tbXkuc2hhcmVwb2ludC5jb21AZTZjYTNhMWYtYmRjYS00ZjAyLWI5MzYtNmI5NGZlMjYzNGNjIiwibmJmIjoiMTc3NzA0MDczNyIsImV4cCI6IjE3NzcwNzY3MzcifQ%2EpH3w1Pd9rrDHKCDFTHM9xMAD0cbkKAhg%2DLuJRIAYl5xuX52xcj6x%2DPBkyMQVPRB5HfopiIpItItHadFs7w3wb8j0FSGlbXzTvoBC0epbZjNu8W5SriCYQGvSV8KweHLV5GxkOULakXc%5Fu69bjnyVpAK05Er%5F96xGo%2DXOUtDDa5LZBXjw9CRZvZpJR2XQGVr5QXFgbOM5ALiM61jrSv%5F8kEeBf3TbKuZ1u6bghm4h6i%5F9ZqD%2DrwWQImnb%2D38OOKsLlMUteejZesnHQdufjz7ozvp2jgMjCdFJ7EO3Wt3mb28a3qMCZ286T7fPqfTeqbL1NMOTVpE55TdHd23MJCksvg&access_token_ttl=1777076737903&ObjectDataBlobId=%7B67f34766-80e9-4a89-99fd-d315cccdac62%7D%7B1%7D&usid=45c9bde0-dc75-bfd6-a8c1-b9b4b3058911&build=16.0.20014.41015&waccluster=CH3&wdwacuseragent=MSWACONSync&McasCtx=1)

---
# Mai 2026
