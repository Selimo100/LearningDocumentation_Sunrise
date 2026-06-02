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
# Mai 2026

## Woche 1 – Endpoint-Tracing und Schnupperwoche

### Hauptthemen

- REST Endpoint von Anfang bis Ende verfolgen
- GraphQL Endpoint von Anfang bis Ende verfolgen
- Austausch mit Mihaela
- Schnupperwoche begleiten

---

### Was habe ich gemacht?

In dieser Woche habe ich im Bereich **Service Fulfillment** begonnen, die verschiedenen Endpoint-Arten praktisch zu verfolgen. Zuerst habe ich einen **REST Endpoint** vom Request in Postman bis in den Code zurückverfolgt. Dabei habe ich mir genau angeschaut, wo der Request ankommt, welche Controller-Methode verwendet wird, wie die Parameter verarbeitet werden und wie der Call über Service und Repository bis zur Elasticsearch-Abfrage weiterläuft.

Anschliessend habe ich auch einen **GraphQL Endpoint** von Anfang bis Ende analysiert. Dabei habe ich dokumentiert, wie sich der Flow im Vergleich zu REST unterscheidet und welche Klassen dabei eine Rolle spielen. Alle Erkenntnisse habe ich ausführlich in OneNote festgehalten.

Zusätzlich habe ich Mihaela ein Update zu meinem aktuellen Stand gegeben. Ich habe ihr erklärt, wie ich das Projekt angehe, welchen Zeitplan ich mir gemacht habe und was ich beim Endpoint-Tracing bereits verstanden habe.

Parallel dazu war diese Woche auch die **Schnupperwoche**. Ich habe die Schnuppis beim Instagram-Projekt unterstützt, ihnen beim Einstieg geholfen und sie während der Umsetzung begleitet. Auch wenn das nicht direkt zu Service Fulfillment gehört, war es für mich persönlich sehr wertvoll, weil ich gemerkt habe, wie gerne ich Wissen weitergebe und Lernende begleite.

---

### Was habe ich gelernt?

Ich habe gelernt, dass man ein grosses Backend-Projekt am besten versteht, wenn man konkrete Requests Schritt für Schritt verfolgt. Nur die Projektstruktur zu kennen reicht nicht aus. Erst wenn man sieht, wie ein Request wirklich durch Controller, Service, Repository und Elasticsearch läuft, versteht man die Architektur richtig.

Beim Vergleich von REST und GraphQL habe ich gemerkt, dass beide Schnittstellen unterschiedliche Einstiegspunkte haben, aber sich später oft dieselben Services und Repository-Schichten teilen. Das hat mir geholfen, das Projekt nicht mehr als einzelne Dateien, sondern als zusammenhängendes System zu sehen.

---

## Woche 2 – gRPC, Dummy Endpoint und Endpoint-Design

### Hauptthemen

- gRPC Endpoint vollständig verfolgen
- Dummy Endpoint implementieren
- Endpoint-Design für Spider
- Migration-Dokumentation lesen
- Zeitplanung und Projektrolle definieren

---

### Was habe ich gemacht?

In dieser Woche habe ich mich stärker auf **gRPC** konzentriert. Ich habe einen gRPC Endpoint vom Request bis zur Response verfolgt und dokumentiert. Dabei habe ich mir den kompletten Flow angeschaut:

```
Client Request→ gRPC Stub→ DefaultBuildingServiceGrpc→ Service Layer→ Repository→ Elasticsearch→ BuildingDoc→ BuildingDto→ Proto Response
```

Das war besonders hilfreich, weil Spider später ebenfalls über gRPC mit dem Building Service kommunizieren soll.

Zusätzlich habe ich einen kleinen **Dummy REST Endpoint** implementiert. Dieser Endpoint war bewusst sehr einfach gehalten und diente dazu, den technischen Ablauf einer neuen Endpoint-Implementation besser zu verstehen. Damit konnte ich prüfen, wie ein Controller aufgebaut ist, wie der Request-Pfad funktioniert und wie eine JSON-Response zurückgegeben wird.

Danach habe ich begonnen, das Design für den eigentlichen neuen Endpoint zu erarbeiten. Ziel ist eine **Building IDs API für Spider**. Spider soll künftig für eine komplette Strasse oder eine komplette Ortschaft alle betroffenen Building-IDs laden können.

Die wichtigsten Designentscheidungen waren:

- Nur gRPC, kein REST und kein GraphQL
- Zwei getrennte Methoden statt einer generischen Methode
- `FindBuildingIdsByStreetId`
- `FindBuildingIdsByZipCode`
- Response enthält nur `repeated int64 building_ids`
- Kein vollständiges `BuildingDto`
- Kein Paging, da Spider die vollständige Liste braucht
- Keine zusätzlichen Filter im ersten Schritt

Zusätzlich habe ich die Dokumentation zur **UPC Applications Migration** gelesen und mir dazu Notizen gemacht. Ich habe mir auch überlegt, wie tief ich in das Projekt involviert sein möchte und wie ich meine Zeit sinnvoll auf Analyse, Design und Implementation aufteilen kann.

---

### Was habe ich gelernt?

Ich habe gelernt, dass gRPC deutlich strikter und strukturierter ist als REST oder GraphQL. Durch die `.proto`-Datei ist der Vertrag klar definiert, was für interne Kommunikation sehr hilfreich ist.

Der Dummy Endpoint hat mir geholfen, den Prozess einer kleinen Implementation einmal praktisch durchzugehen, ohne direkt das finale Feature bauen zu müssen. Das war ein guter Zwischenschritt, weil ich dadurch mehr Sicherheit im Projekt bekommen habe.

Beim Design der Building IDs API habe ich gelernt, wie wichtig es ist, eine Response bewusst klein zu halten. Spider braucht nur Building-IDs, also soll der Endpoint auch nur diese Daten liefern. Das macht die API schneller, klarer und einfacher wartbar.

---

## Ergänzung: Building IDs API für Spider

### Ziel

Spider soll für eine komplette Strasse oder eine komplette Ortschaft alle betroffenen Building-IDs laden können.

Use Case:

Wenn ein geplanter Stromausfall eine ganze Strasse betrifft, braucht Spider alle Building-IDs entlang dieser Strasse, um den Impact berechnen zu können.

Bestehende Suchen liefern bereits:

- Strassensuche liefert `streetId`
- Ortschaftssuche liefert `zipCode`

Was noch fehlt:

- Alle Building-IDs zu einer `streetId`
- Alle Building-IDs zu einem `zipCode`

---

### API-Typ

Die neue API soll **nur über gRPC** umgesetzt werden.

REST und GraphQL werden dafür nicht benötigt, weil Spider bereits gRPC für interne Kommunikation verwendet.

Gründe:

- bessere Performance
- stabiler Vertrag durch `.proto`
- weniger Payload
- geeignet für interne Service-Kommunikation

---

### Geplantes API-Design

```
rpc FindBuildingIdsByStreetId(    FindBuildingIdsByStreetIdRequest) returns (    FindBuildingIdsResponse);rpc FindBuildingIdsByZipCode(    FindBuildingIdsByZipCodeRequest) returns (    FindBuildingIdsResponse);
```

```
message FindBuildingIdsByStreetIdRequest {  string tenant = 1;  int64 street_id = 2;}message FindBuildingIdsByZipCodeRequest {  string tenant = 1;  string zip_code = 2;}message FindBuildingIdsResponse {  repeated int64 building_ids = 1;}
```

---

### Warum zwei Methoden?

Ich habe mich bewusst gegen einen generischen Namen wie `FindBuildingIds` entschieden.

Besser sind zwei klare Methoden:

- `FindBuildingIdsByStreetId`
- `FindBuildingIdsByZipCode`

Der Vorteil ist, dass direkt sichtbar ist, welche Suche durchgeführt wird. Dadurch bleibt die API verständlicher und weniger fehleranfällig.

---
### Persönliche Reflexion

Service Fulfillment ist für mich bisher sehr spannend, weil ich hier an einem deutlich grösseren Enterprise-System arbeite. Ich merke, dass ich durch dieses Projekt lerne, viel systematischer vorzugehen.

Besonders wichtig war für mich die Erkenntnis:

Ich sollte nicht sofort implementieren, sondern zuerst verstehen, testen, vergleichen und designen.

Die Zusammenarbeit mit **Tino und Mihaela** hilft mir sehr, weil ich dadurch sehe, wie erfahrene Entwickler an grosse Systeme herangehen. Ich freue mich darauf, noch tiefer in das Projekt einzusteigen und meine bisherigen Erfahrungen aus Journey, FlowBoard und Score&More hier anzuwenden.

---
# Juni 2026

## Woche 1 – Implementation und Testing

### Hauptthemen

- Service Layer implementieren
- Repository Layer implementieren
- WSL Development Environment einrichten
- Unit Tests und Integrationstests erstellen
- Endpoints lokal validieren

---

### Was habe ich gemacht?

Diese Woche konnte ich die eigentliche Umsetzung der Building IDs API abschliessen.

Ein wichtiger Schritt war zunächst die Einrichtung meines lokalen Entwicklungsumfelds. Da verschiedene Berechtigungen, Tools und Konfigurationen unter Windows nicht korrekt funktioniert haben, habe ich das Projekt über **WSL (Windows Subsystem for Linux)** eingerichtet. Dadurch konnte ich dieselbe Linux-Umgebung verwenden wie viele interne Systeme und erhielt die benötigten Rechte für Maven, Docker, gRPC-Tools und weitere Abhängigkeiten.

Anschliessend habe ich den **Service Layer** fertig implementiert. Dazu gehörte das neue `BuildingService` Interface sowie die zugehörige Implementierung. Die Service-Schicht übernimmt die fachliche Logik und delegiert die Suchanfragen an den Repository Layer.

Danach habe ich den **Repository Layer** umgesetzt. Dort werden die Elasticsearch-Abfragen aufgebaut und ausgeführt. Für die beiden neuen Methoden werden Building-IDs entweder über eine `streetId` oder über einen `zipCode` gesucht. Die Elasticsearch-Queries wurden bewusst möglichst einfach gehalten, damit nur die tatsächlich benötigten Daten abgefragt werden.

Zusätzlich habe ich die minimalistische Protobuf-Response `NumericBuildingId` integriert. Dadurch werden nur die numerischen Building-IDs zurückgegeben, ohne zusätzliche Gebäudedaten oder Metadaten zu übertragen.

Zum Abschluss habe ich umfassende Tests geschrieben. Dazu gehörten Tests für:

- API Layer
- Service Layer
- Repository Layer
- End-to-End Flow der beiden neuen Endpoints

Nach mehreren lokalen Testläufen konnten beide Endpoints erfolgreich validiert werden.
![[Pasted image 20260602081133.png]]
---

### Was habe ich gelernt?

Diese Woche habe ich gelernt, wie wichtig die saubere Trennung zwischen API Layer, Service Layer und Repository Layer ist. Obwohl alle Schichten zusammenarbeiten, hat jede eine klar definierte Verantwortung.

Besonders interessant war für mich die Arbeit mit WSL. Ich habe gemerkt, dass Entwicklungsumgebungen in grösseren Unternehmen oft deutlich komplexer sind als private Projekte. Die korrekte Einrichtung der Umgebung ist häufig bereits ein wichtiger Teil der eigentlichen Arbeit.

Durch die Tests habe ich ausserdem gelernt, wie wichtig automatisierte Validierung ist. Gerade bei internen APIs hilft eine gute Testabdeckung dabei, spätere Fehler frühzeitig zu erkennen und Änderungen sicher umzusetzen.

---