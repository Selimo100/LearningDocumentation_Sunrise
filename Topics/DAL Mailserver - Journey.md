> Kategorie: Backend / Infrastruktur / Mail  
> Erstellt: 12.01.2026

---

## 🔍 Grundidee

Das **Frontend (React)** verschickt **keine Mails**.  
Es triggert lediglich Aktionen im **Spring-Boot-Backend**, welches:

1. Daten speichert
    
2. Business-Regeln prüft (z. B. Note < 4.0)
    
3. eine Mail erstellt
    
4. diese über den **internen DAL-Mailserver (SMTP)** versendet
    

**Warum dieser Ansatz sinnvoll ist:**

- Sicherheit (keine Credentials im Frontend)
    
- Zentrale Business-Logik
    
- Einfachere Wartung und Erweiterung (Scheduler, Templates)
    

---

## ⚙️ Technischer Ablauf (SMTP)

1. Spring Boot verbindet sich per SMTP mit dem internen Mailserver
    
2. Übergabe von `From`, `To`, `Subject`, `Body`
    
3. Der Mailserver übernimmt den Versand
    

Im DAL-Setup gilt **IP-Whitelisting**:

- Kein Login / Passwort notwendig
    
- Server-IP muss erlaubt sein
    
- Typisch: **Port 25**, kein TLS, keine Authentifizierung
    

---

## 🛠️ Spring Boot Konfiguration (Beispiel)

`spring.mail.host=192.168.1.10 spring.mail.port=25 spring.mail.properties.mail.smtp.auth=false spring.mail.properties.mail.smtp.starttls.enable=false`

---

## ✉️ Mail-Service (zentraler Versand)

Mails werden über einen **Service** verschickt (nicht im Controller):

- wiederverwendbar
    
- testbar
    
- sauber getrennt
    

Beispiel: Warnmail bei ungenügender Note (Text-Mail).

---

## 🚨 Trigger: ungenügende Note

Die Regelprüfung passiert **nach dem Speichern der Note** im Backend-Service:

- Note speichern
    
- Wert prüfen
    
- bei < 4.0 → Mail auslösen
    

Empfänger kommen idealerweise aus der DB (Praxisbildner, Berufsbildner, etc.).

---

## 📅 Monatsrapport (automatisch)

- Umsetzung mit **Spring Scheduler**
    
- Job läuft täglich
    
- prüft, ob letzter Tag des Monats
    
- sammelt Noten
    
- verschickt Mail automatisch
    

Robuster als ein fixer „letzter-Tag-Cron“.

---
### 1) Grundidee: Frontend triggert, Backend sendet

**React verschickt keine Mails.**  
React sendet nur Daten (z.B. neue Note) ans **Spring Boot Backend**. Das Backend:

1. speichert die Note in der DB
    
2. prüft die Business-Regel (z.B. Note < 4.0 = ungenügend)
    
3. baut daraus eine Mail (Betreff + Inhalt)
    
4. sendet die Mail über den **internen Mailserver (SMTP)**
    

**Warum so?**

- Sicherheit: Mailserver-Zugangsdaten liegen nicht im Frontend
    
- Konsistenz: Business-Logik ist zentral im Backend
    
- Wartbarkeit: Templates/Scheduler/Ausnahmen einfacher im Backend
    

---

### 2) Wie SMTP-Mailversand technisch abläuft (Flow)

Wenn Spring Boot eine Mail sendet, passiert vereinfacht das:

1. Spring Boot verbindet sich per **SMTP** mit dem Mailserver
    
2. Es übergibt: `From`, `To`, `Subject`, `Body`
    
3. Der Mailserver nimmt die Mail an und leitet sie intern/extern weiter (je nach Setup)
    

In eurem Setup mit **IP-Whitelisting** gilt:

- Der Mailserver akzeptiert Mails **ohne Login/Passwort**, wenn die Anfrage von einer erlaubten IP kommt (z.B. Backend-Server im gleichen Netz)
    
- Typisch: **Port 25**, ohne TLS, ohne Auth
    

---

### 3) Konfiguration in Spring Boot (`application.properties`)

Minimal-Konfiguration f¨r internen Server (Whitelist, kein Auth):

```properties
# Interner SMTP Server
spring.mail.host=192.168.1.10
spring.mail.port=25

# Kein Login (weil IP Whitelist)
spring.mail.properties.mail.smtp.auth=false

# Keine TLS Aushandlung
spring.mail.properties.mail.smtp.starttls.enable=false
```

**Wichtig:**  
Wenn eür Mailserver später TLS/Authentifizierung erfordert, müssen diese Werte angepasst werden (dann meist Port 587 + starttls true + username/password).

---

### 4) Mail-Service im Backend (zentraler Versand)

Du machst einen **Service**, der eine Mail bauen und senden kann. Das ist besser als direkt im Controller, weil:

- wiederverwendbar (Warnmail, Monatsrapport, etc.)
    
- leichter testbar
    

**Beispiel (Text-Mail):**

```java
@Service
public class MailService {

    private final JavaMailSender mailSender;

    public MailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void sendGradeWarning(String to, String studentName, String subjectName, double grade) {
        String mailSubject = "WARNUNG: Ungenuegende Note - " + studentName;

        String text = String.format("""
            Guten Tag

            Das System 'Journey' meldet eine ungenuegende Leistung.

            Schueler: %s
            Fach:     %s
            Note:     %.1f

            Bitte pruefen Sie den Fall im System.

            Freundliche Gruesse
            Journey Bot
            """, studentName, subjectName, grade);

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("journey@sunrise-avengers.ch");
        message.setTo(to);
        message.setSubject(mailSubject);
        message.setText(text);

        mailSender.send(message);
    }
}
```

---

### 5) Trigger: ungenügende Note beim Speichern

Die Logik gehört in den Punkt, wo eine Note erstellt wird (Service/Controller).

**Best Practice:** Speichern + Regelpruefung im **Backend-Service** (nicht im Controller), z.B.:

```java
public Grade createGrade(GradeDTO dto) {
    Grade saved = gradeRepository.save(map(dto));

    if (saved.getValue() < 4.0) {
        mailService.sendGradeWarning(
            "lehrmeister@sunrise-avengers.ch",
            saved.getStudentName(),
            saved.getSubjectName(),
            saved.getValue()
        );
    }

    return saved;
}
```

**Hinweis:** In echten Projekten kommt die Empfängeradresse oft aus der DB:

- Praxisbildner vom Lernenden
    
- Berufsbildner der Klasse
    
- oder eine konfigurierbare Liste
    

---

### 6) Monatsrapport: automatisch am letzten Tag des Monats

Das macht man in Spring Boot mit einem **Scheduler** (Cronjob im Backend). Ablauf:

1. Scheduler läuft automatisch (z.B. jeden Tag kurz vor Mitternacht)
    
2. Er prüft: „Ist heute der letzte Tag im Monat?“
    
3. Wenn ja: Daten aus DB holen (Noten des Monats)
    
4. Mail mit allen Noten senden
    

**Warum nicht direkt “letzter Tag” als Cron?**  
Cron-Ausdrücke sind je nach Setup nicht super angenehm für „letzter Tag“. Die robuste Variante ist: täglich laufen lassen + selber prüfen.

#### Beispiel: Scheduler (täglich 23:55)

```java
@Component
public class MonthlyReportScheduler {

    private final ReportService reportService;

    public MonthlyReportScheduler(ReportService reportService) {
        this.reportService = reportService;
    }

    @Scheduled(cron = "0 55 23 * * *", zone = "Europe/Zurich")
    public void sendMonthlyReportIfLastDay() {
        LocalDate today = LocalDate.now(ZoneId.of("Europe/Zurich"));
        boolean lastDay = today.getDayOfMonth() == today.lengthOfMonth();

        if (lastDay) {
            reportService.sendMonthlyReport(today);
        }
    }
}
```

#### ReportService: Daten holen + Mail senden

```java
@Service
public class ReportService {

    private final GradeRepository gradeRepository;
    private final JavaMailSender mailSender;

    public ReportService(GradeRepository gradeRepository, JavaMailSender mailSender) {
        this.gradeRepository = gradeRepository;
        this.mailSender = mailSender;
    }

    public void sendMonthlyReport(LocalDate date) {
        LocalDate firstDay = date.withDayOfMonth(1);
        LocalDate lastDay  = date.withDayOfMonth(date.lengthOfMonth());

        List<Grade> grades = gradeRepository.findAllBetween(firstDay, lastDay);

        String body = buildTextReport(grades, firstDay, lastDay);

        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setFrom("journey@sunrise-avengers.ch");
        msg.setTo("berufsbildner@sunrise-avengers.ch");
        msg.setSubject("Monatsrapport Noten: " + firstDay + " bis " + lastDay);
        msg.setText(body);

        mailSender.send(msg);
    }

    private String buildTextReport(List<Grade> grades, LocalDate from, LocalDate to) {
        StringBuilder sb = new StringBuilder();
        sb.append("Monatsrapport Noten ").append(from).append(" bis ").append(to).append("\n\n");

        if (grades.isEmpty()) {
            sb.append("Keine Noten in diesem Zeitraum.\n");
            return sb.toString();
        }

        for (Grade g : grades) {
            sb.append("- ")
              .append(g.getStudentName()).append(" | ")
              .append(g.getSubjectName()).append(" | ")
              .append(g.getValue()).append(" | ")
              .append(g.getExamDate())
              .append("\n");
        }
        return sb.toString();
    }
}
```

---

### 7) HTML-Mails (optional, später)

Text reicht für den Anfang. Wenn es professioneller sein soll:

- HTML mit `MimeMessage` statt `SimpleMailMessage`
    
- Optional Template Engine (Thymeleaf)
    

Aber: **erst Text stabil**, dann upgraden.

---