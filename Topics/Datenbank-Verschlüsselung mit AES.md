> Kategorie: Security / Datenbank / Backend  
> Erstellt: 20.01.2026  
> Ziel: Sensible Daten sicher in der Datenbank speichern.

---

## 🔍 Warum Daten verschluesseln?

Nicht alle Daten duerfen im Klartext in der Datenbank stehen, z. B.:

- Leistungsdaten
    
- Beurteilungen
    
- sensible Semester-Informationen
    

➡️ Falls jemand direkten Zugriff auf die DB bekommt, sollen die Inhalte **nicht lesbar** sein.

---

## 🔐 AES – Advanced Encryption Standard

AES ist ein **symmetrischer Verschluesselungsalgorithmus**:

- gleicher Key zum Ver- und Entschluesseln
    
- sehr schnell
    
- Industriestandard
    

In MariaDB/MySQL stehen dafuer die Funktionen bereit:

- `AES_ENCRYPT()`
    
- `AES_DECRYPT()`
    

---

## 🧩 Technische Umsetzung (MariaDB)

### Verschlüsseln beim Speichern:

`INSERT INTO semester_data (content) VALUES (AES_ENCRYPT('Text', 'secret_key'));`

### Entschlüsseln beim Lesen:

`SELECT AES_DECRYPT(content, 'secret_key') FROM semester_data;`

➡️ In der DB liegt nur **Binary Data**, kein Klartext.

---

## ⚙️ Wichtige Details

- Standardmässig **128-bit AES** (sicher und schnell)
    
- AES ist blockbasiert → Padding wird automatisch verwendet
    
- Falscher Key = unlesbarer Inhalt (NULL oder Müll)
    
- Key sollte **nicht hart im Code stehen** (Env-Variable!)
    

---

## 🛡️ Vorteile dieser Lösung

- Schutz bei DB-Leaks
    
- Einfache Integration
    
- Keine externe Library nötig
    
- Performance bleibt stabil
    

---

## ⚠️ Grenzen & Hinweise

- Verschlüsselte Felder sind **nicht durchsuchbar**
    
- Indizes funktionieren nur eingeschränkt
    
- Key-Management ist kritisch
    
- Keine Ende-zu-Ende-Verschlüsselung
    

---

## 💡 Aha-Momente

- Verschlüsselung kann direkt in der DB passieren
    
- Security ist kein Feature, sondern eine Grundhaltung
    
- Nicht alles muss verschlüsselt werden – aber das Richtige
    

---

## 📌 Einsatz in Journey

- Verschlüsselung von Semester-Daten
    
- Entschlüsselung nur im Backend-Service
    
- Keine Klartextdaten in der Datenbank
    

---