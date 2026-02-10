Definition Botnet: Netz von infizierten Rechnern / Server --> Node
## **1. Zusammenfassung der Situation**

Ihr Produktionsserver `nodejs.lab.local` wurde durch eine gezielte Attacke kompromittiert, die einen Crypto-Miner installierte. Die Untersuchung wurde durch massive Performance-Probleme eingeleitet - das System wies eine dauerhafte CPU-Auslastung von 100% auf, verursacht durch einen bösartigen Miner-Prozess mit dem Namen `./CXdf9YmI`. Die Infektion beschränkte sich ausschliesslich auf diesen einen Server, was durch die Abwesenheit von Performance-Problemen auf anderen Servern im Netzwerk bestätigt wurde.

## **2. Identifizierter Angriffsablauf**

Die forensische Analyse ergab einen präzisen zeitlichen Ablauf, der am 18. Januar 2026 um 00:00:06 Uhr begann. Genau zu diesem Zeitpunkt wurde die Malware erstmals aktiv. Die zeitliche Nähe zu einem vorhergehenden Dienstabsturz des `dal-ai-backend` um 00:00:01 Uhr ist bemerkenswert, wobei hier zwei mögliche Interpretationen bestehen: Entweder stellt der Absturz den eigentlichen Angriffsvektor dar, oder er wurde durch die bereits einsetzende extreme Systemauslastung des Miners verursacht.

In der zweiten Phase etablierte der Angreifer robuste Persistenzmechanismen, darunter manipulierte Cron-Jobs in `/etc/cron.d/` und Udev-Regeln in `/etc/udev/rules.d/`. Das Script `auto-upgrade` sorgte dafür, dass der Miner nach jedem Stoppen oder System-Reboot automatisch neu installiert wurde. Die Dekodierung eines im Cronjob versteckten Base64-Strings enthüllte ein Installations-Script, das die Mining-Binary von der IP `138.124.51.192` nachlädt.

Wichtig festzuhalten ist, dass sich die Infektion nicht auf andere Server im Netzwerk ausgebreitet hat. Die Abwesenheit von Performance-Problemen auf anderen Systemen und die fehlenden Anzeichen lateralen Movements bestätigen, dass der Angriff gezielt auf diesen einzelnen Server beschränkt blieb.

## **3. Analyse des Crypto-Miner Scripts**

Das gefundene Miner-Script zeigte eine bemerkenswerte Komplexität und Raffinesse, die auf professionelle Angreifer hindeutet. Bei der Payload-Dekodierung wurde ein hochgradig optimiertes XMRig-Mining-Script entdeckt, das mehrere fortschrittliche Funktionen enthielt.

Das Script begann mit der Manipulation der Hosts-Datei, bei der über 40 bekannte Mining-Pool-Domains auf localhost umgeleitet wurden – eine clevere Taktik, um konkurrierende Miner zu blockieren und die eigene Dominanz zu sichern. Besonders bemerkenswert war der Multi-Architektur-Support: Das Script erkannte automatisch die CPU-Architektur (x86_64, ARM) und lud die spezifisch optimierte Binary für maximale Mining-Effizienz.

Die Persistenz wurde durch mehrere redundante Mechanismen sichergestellt: Ein täglicher Cron-Job mit Base64-kodiertem Payload sorgte für regelmässige Neuansteckung, während eine Udev-Regel bei jeder Netzwerkänderung den Miner neu installierte. Die Integration von Udev-Regeln nistete die Malware tief im System-Management ein, was sie für Standard-Antiviren-Tools schwer auffindbar machte.

Das Script enthielt ausgeklügelte Selbstschutzmechanismen, darunter einen aggressiven Prozess-Killer, der das System nach anderen Minern scannte und diese eliminierte, um die volle CPU-Leistung für sich zu beanspruchen. Für den Download der eigentlichen Mining-Binaries nutzte der Angreifer einen Command-and-Control-Server unter der IP `138.124.51.192`, wobei architekturspezifische Versionen für verschiedene Systeme bereitgestellt wurden.

## **4. Identifizierte Sicherheitslücken**

Die Untersuchung offenbarte mehrere kritische Sicherheitslücken, die der Angreifer erfolgreich ausnutzte. An erster Stelle steht die zeitliche Korrelation zwischen dem Dienstabsturz und der Malware-Aktivierung. Während der genaue kausale Zusammenhang nicht zweifelsfrei geklärt werden kann, ist die Nähe der Ereignisse auffällig – möglicherweise wurde der Absturz durch die einsetzende extreme Systembelastung des Miners verursacht.

Es bleibt unklar, ob der Angreifer die exponierten .env-Dateien tatsächlich ausgelesen hat. Während die Dateien mit sensiblen Credentials wie Datenbank-Passwörtern, LDAP-Administratorzugängen, GitLab-Tokens und API-Keys unverschlüsselt im Dateisystem lagen, gibt es keinen direkten Beweis dafür, dass diese tatsächlich kompromittiert wurden. Die Dateiberechtigungen (644) boten zwar potenziellen Zugriff, ob dieser tatsächlich genutzt wurde, lässt sich aus den vorliegenden Logs nicht zweifelsfrei ableiten.

Die Remote-Code-Execution-Schwachstelle in Next.js Version 16.0.1 stellte eine erhebliche Gefahr dar, da sie dem Angreifer theoretisch direkten Code-Zugriff auf den Server ermöglichte. Diese Version blieb seit November 2025 ungepatcht, obwohl die Sicherheitslücke öffentlich dokumentiert war.

Die 24 parallel laufenden `serve`-Prozesse auf den Ports 3000-3030 erwiesen sich bei näherer Untersuchung als legitime Entwicklungsprojekte, die im Rahmen der normalen Serveraktivitäten ausgeführt wurden. Diese Prozesse, alle mit root-Privilegien, sind Teil der bestehenden Infrastruktur und stellen kein Indiz für zusätzliche Malware-Aktivität dar.

Hervorzuheben ist, dass die interne NPM-Infrastruktur `npm.lab.local` nicht als Infektionsvektor identifiziert werden konnte. Da sich der Angriff nicht im Netzwerk ausgebreitet hat und andere Server keine Performance-Probleme aufwiesen, ist es unwahrscheinlich, dass eine kompromittierte npm-Registry beteiligt war. Der Angriff konzentrierte sich ausschliesslich auf die Sicherheitslücken des einzelnen Node.js Servers.

## **5. Forensische Erkenntnisse**

Die zeitliche Rekonstruktion ergab eine präzise Angriffssequenz: Am 18. Januar 2026 um 00:00:06 Uhr wurde die Malware erstmals aktiv und etablierte sich mit dem Prozessnamen `./CXdf9YmI`. Der zeitnahe Dienstabsturz des `dal-ai-backend` um 00:00:01 Uhr könnte entweder den Angriffsvektor darstellen oder – wahrscheinlicher – eine Folge der einsetzenden extremen Systembelastung durch den Miner gewesen sein.

Die Netzwerkanalyse identifizierte den externen Command-and-Control-Server `138.124.51.192` für Miner-Downloads und die Domain `abcdefghijklmnopqrst.net` für das initiale Dropper-Script. Die interne IP `npm.lab.local` wurde zwar in Logs identifiziert, scheint jedoch nicht direkt am Angriff beteiligt gewesen zu sein, da keine lateralen Bewegungen zu anderen Servern festgestellt wurden.

Die Log-Forensik über `journalctl` und `syslog` bestätigte die präzise Aktivierungszeit der Malware und ermöglichte die Rückverfolgung des Infektionspfades. Die Untersuchung der Persistenz-Mechanismen in `/etc/cron.d/` und `/etc/udev/rules.d/` offenbarte die ausgeklügelte Wiederansteckungsstrategie des Angreifers.

Die Infektion hatte sich tief im System verankert: Systemd Services wurden manipuliert, Cron-Jobs infiltriert, Udev-Regeln missbraucht und die Hosts-Datei für die Blockade konkurrierender Miner modifiziert. Die Dekodierung der Base64-Payloads in den Cronjobs lieferte direkte Einblicke in die Funktionsweise des Malware-Delivery-Systems.

## **6. Angriffscharakteristika**

Die Attacke zeigte charakteristische Merkmale professioneller Mining-Malware. Das XMRig-basierte Script verfügte über Multi-Architektur-Support und aggressive Selbstschutzmechanismen, die konkurrierende Miner eliminierten, um die volle CPU-Leistung zu monopolisieren.

Wichtig festzuhalten ist, dass die Infektion keine wurmartigen Charakteristika aufwies. Es gab keine Anzeichen von Typosquatting-Packages, keine automatische Verbreitung über CI/CD-Pipelines und kein laterales Movement zu anderen Systemen im Netzwerk. Die Abwesenheit von Performance-Problemen auf anderen Servern bestätigt, dass der Angriff gezielt und lokal begrenzt blieb.

Die Tarnung durch Udev-Regeln nistete die Malware tief im System-Management ein, was konventionelle Detection-Mechanismen umging. Die Privilege-Eskalation auf root-Ebene und die multiplen Persistenzmechanismen (Cron, Udev, Systemd) sicherten dem Miner dauerhaften Zugang, jedoch ohne sich weiter auszubreiten.

Spezifische Indicators of Compromise (IoCs) umfassten den 8-stelligen Zufallsprozessnamen `CXdf9YmI`, Netzwerkverbindungen zur bösartigen IP `138.124.51.192`, Base64-kodierte Cron-Jobs in `/etc/cron.d/auto-upgrade` und das charakteristische Muster `[A-Za-z0-9]{8}` in Prozessnamen.

## **7. Durchgeführte Tests & Ergebnisse**

Die systematische Untersuchung begann mit der Analyse der Performance-Probleme, die zur Identifikation des Miner-Prozesses `./CXdf9YmI` führten. Die Log-Forensik über `journalctl` und `syslog` ermöglichte die präzise Zeitstempelanalyse und enthüllte die zeitliche Nähe zwischen möglichem Dienstabsturz und Malware-Aktivierung.

Die Persistence-Check in `/etc/cron.d/` und `/etc/udev/rules.d/` identifizierte die automatischen Wiederansteckungsmechanismen. Die Payload-Dekodierung der Base64-Strings in den Cronjobs lieferte direkte Einblicke in das Malware-Delivery-System und die verwendeten Command-and-Control-Server.

Die Netzwerkanalyse bestätigte, dass keine lateralen Bewegungen zu anderen Servern stattfanden. Die ausschliessliche CPU-Auslastung des betroffenen Servers bei normaler Auslastung aller anderen Systeme im Netzwerk unterstützt die These eines lokal begrenzten Angriffs.

Die Untersuchung der zahlreichen `serve`-Prozesse ergab, dass es sich hierbei um legitime Entwicklungsprojekte handelt, die Teil der bestehenden Server-Infrastruktur sind und nicht mit der Malware-Infektion in Verbindung stehen.

Die Multi-Architektur-Erkennung des Scripts wurde bestätigt – das Malware-System konnte zwischen x86_64 und ARM unterscheiden und lud die entsprechend optimierten Binaries. Die Selbstschutzmechanismen wurden durch die Analyse der Prozess-Killing-Routinen verifiziert, die das System nach anderen Minern durchsuchten.

Die Untersuchung der .env-Dateien ergab zwar exponiert liegende Credentials, konnte jedoch keinen Beweis für deren tatsächliche Kompromittierung liefern. Die vorhandenen Logs geben keine Auskunft darüber, ob diese Dateien tatsächlich ausgelesen wurden.

## **10. Fazit**

Die Crypto-Miner-Infektion auf `nodejs.lab.local` resultierte aus einem gezielten Angriff, der sich ausschliesslich auf diesen Server beschränkte. Die präzise Aktivierung der Malware um 00:00:06 Uhr am 18. Januar 2026 liefert einen klaren forensischen Marker für den Angriffsbeginn. Der zeitnahe Dienstabsturz könnte eine Folge der einsetzenden extremen Systembelastung gewesen sein, ein direkter kausaler Zusammenhang lässt sich jedoch nicht zweifelsfrei nachweisen.

Wichtig ist festzuhalten, dass es sich nicht um einen wurmartigen Angriff handelte, der sich im Netzwerk ausgebreitet hätte. Die Infektion blieb lokal begrenzt, was durch die normale Performance aller anderen Server im Netzwerk bestätigt wird. Die zahlreichen `serve`-Prozesse erwiesen sich als legitime Bestandteile der Entwicklungsinfrastruktur und nicht als Indiz für zusätzliche Malware-Aktivität.

Die interne NPM-Infrastruktur `npm.lab.local` scheint nicht kompromittiert gewesen zu sein, da keine Anzeichen für eine verteilte Infektion vorliegen. Die Frage, ob die exponierten .env-Dateien tatsächlich ausgelesen wurden, bleibt unbeantwortet – während die Credentials in Klartext vorlagen, gibt es keinen konkreten Beweis für deren Missbrauch.

Die Hauptschwachstelle lag in der erfolgreichen Installation und Persistenz des Miners durch ausgeklügelte Cron- und Udev-Mechanismen. Die Bereinigung erfordert eine fokussierte Analyse der spezifischen Sicherheitslücken dieses Servers, ohne dass eine netzwerkweite Gefährdung anzunehmen ist. Der gezielte, lokal begrenzte Charakter des Angriffs ermöglicht eine kontrollierte Wiederherstellung der Systemsicherheit.