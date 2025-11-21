Kurzfassung:

- Ursache: Ich habe den User-Bind per **DN-Schablone in OU=All** gemacht (`CN=!REPLACE!,OU=All,...`). **Contractors** liegen woanders ⇒ Bind/Suche fanden sie nicht.
    
- Fix: **UPN-Bind** nutzen (`!REPLACE!@swi.srse.net`) – ist OU-unabhängig.
    
- Base DN: auf **Domain-Root** setzen (`DC=swi,DC=srse,DC=net`) und **SUBTREE** suchen.
    
- Filter: breiter machen – `(|(sAMAccountName={u})(userPrincipalName={u}))`.
    
- Achtung: Domäne mit Punkten immer in **mehrere DC=** zerlegen (nicht `dc=swi.srse`).
    
- Optional: Extern meist **LDAPS/636**; prüfe, dass **employeeID** bei allen Nutzern gesetzt ist (sonst Fallback).
# Was war die Ursache?

- **Falsche Bind-Schablone (VALIDATE_DN):** Ich habe Benutzer als DN unter `OU=All` gebunden (`CN=!REPLACE!,OU=All,...`). Agents in `OU=Contractors` passten nicht in diese Schablone → User-Bind schlug fehl.
    
- **AD vs. OpenLDAP Muster vermischt:** Die Default-Schablone `uid=!REPLACE!,ou=users,dc=example,dc=com` passte nicht zu unserem Active Directory (wo meist **UPN**/`user@domain` oder `DOMAIN\user` verwendet wird).
    
- **Zu enger Suchkontext:** Suchen und/oder Bind waren effektiv auf einen Teilbaum beschränkt. Externe Agents lagen ausserhalb.
    
- **Filter zu eng:** Nur `sAMAccountName` – falls der Client mit UPN ankommt, findet die Suche den User nicht.
    
- **Base DN/Domain falsch interpretiert:** Punkte in der Domäne müssen in **mehrere DC=…** zerlegt werden (`DC=swi,DC=srse,DC=net`), nicht `dc=swi.srse`.
    

# Wie haben wir es behoben?

- **UPN-Bind eingeführt:** `VALIDATE_DN=!REPLACE!@swi.srse.net`. Damit ist der Benutzer-Bind OU-unabhängig (funktioniert in **All** und **Contractors**).
    
- **Domain-Root als Base DN:** `LDAP_BASE_DN=DC=swi,DC=srse,DC=net` + `SUBTREE` → Suche deckt alle OUs ab.
    
- **Breiterer Suchfilter:** `(|(sAMAccountName=…)(userPrincipalName=…))` → trifft beide Eingabeformen.
    
- **Logging geschärft, aber ohne Secrets:** Bessere Diagnose, keine sensiblen Daten im Log.
    

# Checkliste fürs nächste Mal

1. **Identität zum Binden (User-Bind):**
    
    - In AD bevorzugt **UPN** (`user@domain.tld`) oder **DOMAIN\user** verwenden – **nicht** hart eine DN-Schablone mit OU.
        
2. **Base DN richtig wählen:**
    
    - Für organisationsweite Logins: **Domain-Root** (`DC=…,DC=…,DC=…`) + `SUBTREE`.
        
    - Dots in der Domäne → aufteilen in mehrere `DC=`.
        
3. **Suchfilter robust machen:**
    
    - Mindestens `(|(sAMAccountName={user})(userPrincipalName={user}))`.
        
4. **Attribute prüfen:**
    
    - Wenn du `employeeID` als Schlüssel nutzt, sicherstellen, dass es **für alle** Nutzer gesetzt ist (sonst Fallback, z. B. `objectGUID`).
        
5. **Protokoll/Port:**
    
    - Intern oft 389 (LDAP), extern meist **LDAPS (636)**. SSL/Firewall entsprechend konfigurieren.
        
6. **Test & Debug:**
    
    - Mit Apache Directory Studio: Verbindung auf Domain-Root, `SUBTREE`, Filter testen.
        
    - In der App: klare Log-Meldungen (z. B. „user_not_found“, „invalid_credentials“, „ldap_unreachable“).
        
7. **Sicherheit:**
    
    - Service-Account-Passwörter nie im Chat/Repo, sofort rotieren, `.env` nicht committen.
        
8. **Umgebungsvariablen klar halten:**
    
    - `AD_UPN_SUFFIX`, `VALIDATE_DN` (UPN-Template), `LDAP_BASE_DN`, `LDAP_USE_SSL` – sauber dokumentieren.
        