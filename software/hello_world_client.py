from ftplib import FTP
import io

# Jouw Robot IP
ROBOT_IP = "192.168.125.1"

print("Verbinding maken...")

try:
    # Login op de robot (meestal is user 'abb' en wachtwoord 'abb', of leeg)
    ftp = FTP(ROBOT_IP)
    ftp.login("abb", "abb") 
    
    # We zagen op je foto dat we direct in de map zaten, 
    # maar voor de zekerheid gaan we naar HOME
    try:
        ftp.cwd("HOME")
    except:
        pass # Als we er al zijn, is het ook goed

    print("VERBONDEN! De brievenbus is open.")
    
    while True:
        naam = input("Welke naam moet de robot schrijven? (of 'stop'): ")
        if naam == 'stop': break
        
        # Maak van de tekst een bestandje in het geheugen
        bestand_data = io.BytesIO(naam.encode('utf-8'))
        
        # Stop het in de brievenbus (Uploaden)
        print(f"Bestand 'naam.doc' wordt geupload...")
        ftp.storbinary("STOR naam.doc", bestand_data)
        
        print("Klaar! Kijk op het robotscherm.")

    ftp.quit()

except Exception as e:
    print("Oei, er ging iets mis:", e)