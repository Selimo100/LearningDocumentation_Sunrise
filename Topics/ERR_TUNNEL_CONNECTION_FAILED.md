- Backend wurde nicht öffentlich geroutet 

`net::ERR_TUNNEL_CONNECTION_FAILED` kommt fast immer vom **Proxy/VPN-Pfad** zwischen Browser und Zielhost. Der Browser will einen **CONNECT-Tunnel** zu `risingtrack-backend.lab.local` aufbauen (typisch fuer HTTPS ueber Proxy) – der Aufbau klappt aber nicht. Das passiert **vor** deiner Web-App/ deinem Server. Deine Serverlogs sehen dabei meist **gar nichts**.

### Typische Ursachen

- **Proxy/VPN Pflicht im Netz**: Falsche Proxy-Einstellungen, defekte PAC/WPAD, Proxy gerade down.
    
- **Keine Ausnahme fuer Intranet-Hosts**: `*.lab.local` sollte oft **am Proxy vorbei** direkt gehen.
    
- **Firewall/Sicherheitsgateway blockt**: Zielhost/Port gesperrt (z. B. Zscaler, Sophos, Cisco, usw.).
    
- **DNS**: `risingtrack-backend.lab.local` laesst sich ueber den Proxy nicht aufloesen.
    
- **SSL-Inspection/Zertifikat**: Manchmal bricht das Gateway den CONNECT ab (Policy, Zertifikat, Kategorie).
    
- **Falscher Port**: Proxy erwartet 443, App lauscht auf anderem Port.
    

### Schnelltest: clientseitig vs. serverseitig

- Wenn es **serverseitig** waere (App down), siehst du eher `ERR_CONNECTION_REFUSED/TIMED_OUT`.  
    **TUNNEL** weist klar auf **Proxy/VPN** hin.
    
- Teste **ohne Proxy/VPN** (Falls moeglich): Gleiches Netz, Proxy aus → Seite aufrufen.
    
- **nslookup** aufloesen:
    
    `nslookup risingtrack-backend.lab.local`
    
    Falls keine Adresse: DNS/Hosts-Problem.
    
- **Port-Erreichbarkeit**:
    
    `# Linux/macOS nc -vz risingtrack-backend.lab.local 443 # Windows Test-NetConnection risingtrack-backend.lab.local -Port 443`
    
- **Direkt via curl** (ohne Proxy):
    
    `curl -v https://risingtrack-backend.lab.local/api/auth/ldap-status`
    
    Kommt eine Antwort → Server ok, Problem ist Proxy.
    
- **Mit Proxy testen** (ersetze PROXYHOST:PORT):
    
    `curl -v -x http://PROXYHOST:PORT https://risingtrack-backend.lab.local/api/auth/ldap-status`
    
    Bekommst du 407/403 oder Abbruch → Proxy/Policy.
    

### Was du konkret pruefen solltest

1. **Proxy-Settings** in OS/Browser:
    
    - Stimmt die PAC-URL?
        
    - Gibt es eine **Bypass-Liste**: `*.lab.local` eintragen.
        
2. **VPN** an/aus probieren (je nach Firmenpolicy).
    
3. **DNS fuer .local**: Wird mDNS erwartet oder Firmen-DNS? Ggf. Suchsuffix/Zone checken.
    
4. **Zertifikate**: Firmen-Root-CA installiert? SSL-Inspection kann CONNECT abbrechen.
    
5. **Firewall/Policy**: Security-Team fragen, ob `risingtrack-backend.lab.local:443` erlaubt ist.
    
6. **Server-Seite** (nur zur Sicherheit): Lauscht der Backend-Dienst auf dem erwarteten Port/Interface?  
    Intern von einem Server im selben Netz:
    
    `curl -v https://localhost:443/health # bzw. curl -v https://risingtrack-backend.lab.local/api/auth/ldap-status`
    
    Wenn das intern geht, ist es sehr sicher ein Proxy/VPN/DNS-Thema.
    

### Fazit

Der Fehler ist **nicht in deiner Webseite/Frontend-Logik**, sondern **im Netzwerkpfad (Proxy/VPN/DNS/Firewall)**. Starte mit Proxy/PAC-Bypass fuer `*.lab.local` und DNS-Check; danach Policy/Firewall klaeren.

Wenn du moechtest, poste kurz:

- Proxy/PAC aktiviert ja/nein,
    
- Ergebnis von `nslookup` und `Test-NetConnection`,
    
- Ob es ohne Proxy/VPN klappt.  
    Dann leite ich dir die naechsten gezielten Schritte ab.