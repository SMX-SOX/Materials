# UD3-Usuaris i Grups

RA2. Gestiona usuaris i grups de sistemes operatius en xarxa, interpretant especificacions i aplicant eines del sistema.

Durada prevista: 8 hores

## Introducció

En aquesta unitat aprendrem a gestionar usuaris i grups en un sistema Linux, així com a configurar els perfils dels usuaris.

## Usuaris a Linux

Un usuari és una entitat que representa una persona o un procés que pot accedir al sistema. Cada usuari té un nom d'usuari únic i pot tenir una contrasenya associada, així com un identificador d'usuari (UID) i un identificador de grup (GID) que defineixen els permisos i l'accés als recursos del sistema.

D'usuaris, n'hi ha de tres tipus:

- **Usuari root**: És l'usuari amb privilegis màxims al sistema. Té accés complet a tots els fitxers i configuracions del sistema, i pot executar qualsevol comanda. L'usuari root és essencial per a tasques d'administració i manteniment del sistema, però s'ha d'utilitzar amb precaució per evitar canvis no desitjats o danys al sistema. S'identifica amb l'UID 0.
- **Usuaris del sistema**: Són usuaris creats pel sistema operatiu per a tasques específiques, com ara serveis i processos. Aquests usuaris tenen permisos limitats i no poden iniciar sessió de manera interactiva. L'UID d'aquests usuaris sol ser inferior a 1000, i sovint tenen shells com `/usr/sbin/nologin` o `/bin/false` per evitar l'accés interactiu. Alguns exemples d'usuaris del sistema són `daemon`, `bin`, `sys`, `sync`, `games`, `man`, `lp`, `mail`, `news`, `uucp`, `proxy`, `www-data`, entre altres.
- **Usuaris normals**: Són usuaris creats per l'administrador del sistema per a persones reals. Aquests usuaris poden iniciar sessió de manera interactiva i tenen més permisos que els usuaris del sistema. Tenen un UID superior a 1000 i poden tenir shells com `/bin/bash` o `/bin/sh`. Aquests usuaris poden tenir accés a fitxers i directoris propis, així com a recursos compartits del sistema.

Els usuaris creats al sistema es poden veure al fitxer `/etc/passwd`, que conté informació sobre cada usuari, com ara el nom d'usuari, l'UID, el GID, el directori d'inici i la shell per defecte. A més, les contrasenyes dels usuaris es guarden de manera segura al fitxer `/etc/shadow`, que només és accessible per l'usuari root.

```bash
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/run/ircd:/usr/sbin/nologin
_apt:x:42:65534::/nonexistent:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
systemd-network:x:998:998:systemd Network Management:/:/usr/sbin/nologin
systemd-timesync:x:996:996:systemd Time Synchronization:/:/usr/sbin/nologin
dhcpcd:x:100:65534:DHCP Client Daemon,,,:/usr/lib/dhcpcd:/bin/false
messagebus:x:101:101::/nonexistent:/usr/sbin/nologin
syslog:x:102:102::/nonexistent:/usr/sbin/nologin
systemd-resolve:x:991:991:systemd Resolver:/:/usr/sbin/nologin
uuidd:x:103:103::/run/uuidd:/usr/sbin/nologin
landscape:x:104:105::/var/lib/landscape:/usr/sbin/nologin
polkitd:x:990:990:User for polkitd:/:/usr/sbin/nologin
usuari:x:1002:1002:,,,:/home/usuari:/bin/bash
```

### Sobre root i sudo

L'usuari root és l'usuari amb privilegis màxims al sistema, i té accés complet a tots els fitxers i configuracions del sistema. Per això, és important utilitzar-lo amb precaució i només quan sigui necessari. De fet, en moltes distribucions modernes, com Ubuntu, l'usuari root està deshabilitat per defecte i s'utilitza l'eina `sudo` per executar comandes amb privilegis d'administrador.

Un usuari amb permisos d'administrador pot executar comandes amb privilegis de root utilitzant `sudo`. El sistema demana la contrasenya de l'usuari per verificar la seva identitat abans d'executar la comanda amb privilegis elevats.

Si volem treballar de forma contínua com a root, podem utilitzar la comanda `sudo -i`, que obre una sessió interactiva amb privilegis de root. Això és útil quan necessitem executar diverses comandes amb privilegis elevats sense haver d'escriure `sudo` davant de cada comanda.

## Grups a Linux

Un grup és una col·lecció d'usuaris que comparteixen permisos i accés a recursos del sistema. Cada usuari pot pertànyer a un o més grups, i cada grup té un identificador de grup (GID) únic. Els grups permeten gestionar els permisos de manera més eficient, ja que podem assignar permisos a un grup sencer en lloc de fer-ho individualment per a cada usuari.

Podem veure els grups existents al sistema al fitxer `/etc/group`, que conté informació sobre cada grup, com ara el nom del grup, el GID i els membres del grup.

```bash
root:x:0:
daemon:x:1:
bin:x:2:
sys:x:3:
tty:x:5:
disk:x:6:
lp:x:7:
mail:x:8:
uucp:x:10:
man:x:12:
proxy:x:13:
...
usuari:x:1002:
docker:x:1003:usuari
oficina1:x:1004:
oficina2:x:1005:
usuari-abc:x:1006:
control-abc:x:1007:
```

De la mateixa manera que els usuaris, els grups també es poden classificar en tres tipus:

- **Grup root**: És el grup amb privilegis màxims al sistema. Tots els usuaris que pertanyen a aquest grup tenen accés complet a tots els fitxers i configuracions del sistema. El grup root és essencial per a tasques d'administració i manteniment del sistema, però s'ha d'utilitzar amb precaució per evitar canvis no desitjats o danys al sistema. S'identifica amb el GID 0.
- **Grups del sistema**: Són grups creats pel sistema operatiu per a tasques específiques, com ara serveis i processos. El GID d'aquests grups sol ser inferior a 1000. Alguns exemples de grups del sistema són `daemon`, `bin`, `sys`, `tty`, `disk`, `lp`, `mail`, `uucp`, `man`, `proxy`, `www-data`, entre altres.
- **Grups normals**: Són grups creats pels administradors del sistema per a usuaris reals. Aquests grups poden tenir membres que poden iniciar sessió de manera interactiva i tenen més permisos que els grups del sistema. Tenen un GID superior a 1000. En els sistemes derivats de Debian, com Ubuntu, cada usuari normal té un grup amb el mateix nom que l'usuari, i aquest grup és el grup primari de l'usuari. A més, els usuaris poden pertànyer a altres grups secundaris per compartir recursos i permisos amb altres usuaris. A altres distribucions, com Red Hat, cada usuari normal pertany al grup `users` com a grup primari, d'una manera similar a com ho fan els sistemes Windows.

## Gestió de grups

### Creació de grups

Per crear un gruop nou a Linux, podem utilitzar la comanda `groupadd`. Aquesta comanda crea un nou grup amb un nom i un GID específics. Per exemple, per crear un grup anomenat `oficina1`, podem executar la següent comanda:

```bash
sudo groupadd oficina1
```

Si volem especificar un GID concret per al grup, podem utilitzar l'opció `-g`. Per exemple, per crear un grup anomenat `oficina2` amb el GID 1005, podem executar la següent comanda:

```bash
sudo groupadd -g 1005 oficina2
```

Si usem el paràmetre `-r`, crearem un grup del sistema amb un GID inferior a 1000. Per exemple, per crear un grup del sistema anomenat `control-abc` amb el GID 1007, podem executar la següent comanda:

```bash
sudo groupadd -r -g 1007 control-abc
```

### Eliminació de grups

Per eliminar un grup a Linux, podem utilitzar la comanda `groupdel`. Aquesta comanda elimina un grup existent del sistema. Per exemple, per eliminar el grup `oficina1`, podem executar la següent comanda:

```bash
sudo groupdel oficina1
```

### Modificació de grups

Per modificar un grup a Linux, podem utilitzar la comanda `groupmod`. Aquesta comanda ens permet canviar el nom del grup o el GID del grup. Per exemple, per canviar el nom del grup `oficina2` a `oficina3`, podem executar la següent comanda:

```bash
sudo groupmod -n oficina3 oficina2
```

També podem canviar el GID del grup amb l'opció `-g`. Per exemple, per canviar el GID del grup `control-abc` a 1008, podem executar la següent comanda:

```bash
sudo groupmod -g 1008 control-abc
```

## Gestió d'usuaris

### Creació d'usuaris

Per crear usuaris a Linux, podem utilitzar diverses eines i comandes. Algunes de les més comunes són:

- `adduser`: Aquesta comanda crea un nou usuari i configura el seu directori d'inici, la shell per defecte i altres paràmetres. També ens permet establir una contrasenya per a l'usuari. ´És pròpia de distribucions com Debian i Ubuntu, i és més amigable que `useradd`, ja que guia l'usuari a través del procés de creació d'un nou usuari.

- `useradd`: Aquesta comanda crea un nou usuari, però no configura el seu directori d'inici ni la shell per defecte. Cal configurar aquests paràmetres manualment. Alguns d'aquests paràmetres són:

  - `-m`: Crea el directori d'inici de l'usuari si no existeix.
  - `-s`: Especifica la shell per defecte de l'usuari, exemple `/bin/bash` o `/bin/sh`.
  - `-G`: Afegeix l'usuari a un o més grups secundaris.
  - `-g`: Especifica el grup primari de l'usuari.
  - `-r`: Crea un usuari del sistema amb un UID inferior a 1000.

### Eliminació d'usuaris

Per eliminar un usuari a Linux, podem utilitzar la comanda `userdel`. Aquesta comanda elimina un usuari existent del sistema. Per exemple, per eliminar l'usuari `usuari`, podem executar la següent comanda:

```bash
sudo userdel usuari
```

Si l'usuari té un directori d'inici i volem eliminar-lo juntament amb l'usuari, podem utilitzar l'opció `-r`. Per exemple, per eliminar l'usuari `usuari` i el seu directori d'inici, podem executar la següent comanda:

```bash
sudo userdel -r usuari
```

### Modificació d'usuaris

Per modificar un usuari a Linux, podem utilitzar la comanda `usermod`. Aquesta comanda ens permet canviar el nom d'usuari, la contrasenya, el directori d'inici, la shell per defecte i altres paràmetres. Alguns dels paràmetres més comuns són:

- `-l`: Canvia el nom d'usuari.
- `-d`: Canvia el directori d'inici de l'usuari.
- `-m`: Mou el contingut del directori d'inici de l'usuari al nou directori especificat amb `-d`.
- `-s`: Canvia la shell per defecte de l'usuari.
- `-G`: Afegeix l'usuari a un o més grups secundaris eliminant-lo dels grups existents.
- `-aG`: Afegeix l'usuari a un o més grups secundaris sense eliminar-lo dels grups existents.
- `-g`: Canvia el grup primari de l'usuari.
- `-U`: Canvia el UID de l'usuari. Canviar l'UID d'un usuari pot afectar els permisos dels fitxers i directoris propietat d'aquest usuari, ja que els permisos es basen en l'UID. Per tant, cal tenir precaució en canviar l'UID d'un usuari existent.

Per exemple, per canviar el nom d'usuari `usuari` a `nou-usuari`, canviant també el directori d'inici, podem executar la següent comanda:

```bash
sudo usermod -l nou-usuari -d /home/nou-usuari -m usuari
```

Un cas habitual és afegir un usuari al grup `sudo` per permetre-li executar comandes amb privilegis d'administrador. Per exemple, per afegir l'usuari `usuari` al grup `sudo`, podem executar la següent comanda:

```bash
sudo usermod -aG sudo usuari
```

### Gestió de contrasenyes

Tot i actualment s'està replantejant l'ús de contrasenyes com a mètode d'autenticació, encara són el mètode més comú per autenticar usuaris a Linux. Per gestionar les contrasenyes dels usuaris, podem utilitzar la comanda `passwd`. Aquesta comanda ens permet establir o canviar la contrasenya d'un usuari.

```bash
sudo passwd usuari
```

> Quan s'executa la comanda `passwd`, el sistema demana que introduïm la nova contrasenya dues vegades per verificar que s'ha escrit correctament. La contrasenya es xifra i s'emmagatzema al fitxer `/etc/shadow`, que només és accessible per l'usuari root.

Altres paràmetres útils de la comanda `passwd` són:

- `-l`: Bloqueja la contrasenya de l'usuari, impedint que aquest iniciï sessió amb la seva contrasenya actual.
- `-u`: Desbloqueja la contrasenya de l'usuari, permetent que aquest iniciï sessió amb la seva contrasenya actual.
- `-e`: Expira la contrasenya de l'usuari, obligant-lo a canviar-la en el proper inici de sessió.
- `-d`: Elimina la contrasenya de l'usuari, permetent que aquest iniciï sessió sense contrasenya (no recomanat per motius de seguretat).
- `-n`: Estableix el nombre mínim de dies que han de passar abans que l'usuari pugui canviar la seva contrasenya.
- `-x`: Estableix el nombre màxim de dies que la contrasenya de l'usuari és vàlida abans d'expirar.
- `-w`: Estableix el nombre de dies abans que la contrasenya de l'usuari expiri, perquè el sistema comenci a avisar-lo que ha de canviar-la.
- `-i`: Estableix el nombre de dies després que la contrasenya de l'usuari hagi expirat, abans que el compte sigui desactivat.
- `-S`: Mostra l'estat de la contrasenya de l'usuari, incloent si està bloquejada, la data de l'últim canvi i els paràmetres de caducitat.

> Com administrador del sistema, és important establir polítiques de contrasenyes que poden incloure períodes de validesa, així també com bloquejar l'accés a usuaris inactius, per exemple perquè es troben d'excència.

I on es guarden les contrasenyes?

Les contrasenyes dels usuaris es guarden de manera segura al fitxer `/etc/shadow`, que només és accessible per l'usuari root. Aquest fitxer conté informació sobre cada usuari, com ara la contrasenya xifrada, la data de l'últim canvi de contrasenya i els paràmetres de caducitat.

Si mirem el fitxer `/etc/shadow`, veurem que les contrasenyes no es guarden en text pla, sinó que es xifren utilitzant un algorisme de hash. Això significa que, encara que algú accedeixi al fitxer, no podrà veure les contrasenyes reals dels usuaris.

```bash
usuari:$6$4756Fa8Us6zPUPLA$p8YZOAPNBDRclmEc5H6coznlTU2zAv2M3y376X/2Rz7.WIjmE1ognu.MHhI3beUepLrNvVj1gM/3UDLkqPFtT/:20624:0:99999:7:::
```

Podem veure els següents camps:

- El nom d'usuari (`usuari`).
- El `$6$` indica que s'utilitza l'algorisme de hash SHA-512 per xifrar la contrasenya. És un algorisme de hash segur i robust que genera una cadena de caràcters única per a cada contrasenya.
- El camp entre el segon i el tercer `$` és la "sal" (salt), que és una cadena aleatòria que s'afegeix a la contrasenya abans de xifrar-la. La sal ajuda a protegir les contrasenyes contra atacs de diccionari i de força bruta, ja que fa que dues contrasenyes iguals generin hashes diferents.
- El camp després del tercer `$` és la contrasenya xifrada. Aquesta cadena és el resultat de l'algorisme de hash aplicat a la contrasenya original i la sal.
- El `20624` indica la data de l'últim canvi de contrasenya en dies des del 1 de gener de 1970 (epoch time).
- El `0` indica el nombre mínim de dies que han de passar abans que l'usuari pugui canviar la seva contrasenya. Això significa que l'usuari pot canviar la seva contrasenya immediatament després d'haver-la establert.
- El `99999` indica el nombre màxim de dies que la contrasenya és vàlida abans d'expirar. El valor `99999` significa que la contrasenya no expira mai.
- El `7` indica el nombre de dies abans que la contrasenya expiri, perquè el sistema comenci a avisar l'usuari que ha de canviar-la.
- Els dos camps buits al final del registre són per a la data d'expiració del compte i per a un camp reservat per a ús futur. Com que estan buits, significa que el compte no té una data d'expiració establerta i que no hi ha cap informació addicional disponible.

### Informació sobre els usuaris

En Linux, podem obtenir informació detallada sobre els usuaris i els grups utilitzant diverses comandes. Algunes de les més útils són:

- `id`: Mostra l'UID, el GID i els grups als quals pertany un usuari. Per exemple, per obtenir informació sobre l'usuari `usuari`, podem executar la següent comanda: `id usuari`.

- `groups`: Mostra els grups als quals pertany un usuari. Per exemple, per obtenir informació sobre els grups de l'usuari `usuari`, podem executar la següent comanda: `groups usuari`.

- `getent passwd`: Mostra informació sobre tots els usuaris del sistema, incloent el nom d'usuari, l'UID, el GID, el directori d'inici i la shell per defecte. Per exemple, per obtenir informació sobre l'usuari `usuari`, podem executar la següent comanda: `getent passwd usuari`.

- `who`: Mostra els usuaris que estan actualment connectats al sistema, així com informació sobre les seves sessions, com ara l'horari d'inici de sessió i la terminal utilitzada.

- `w`: Mostra informació detallada sobre els usuaris connectats al sistema, incloent el temps d'inactivitat, la càrrega del sistema i les comandes que estan executant.

- `last`: Mostra informació sobre l'últim inici de sessió d'un usuari. Per exemple, per obtenir informació sobre l'usuari `usuari`, podem executar la següent comanda: `last usuari`.

- `whoami`: Mostra el nom d'usuari de l'usuari actual. Aquesta comanda és útil per verificar amb quin usuari estem treballant en un moment donat.

- `finger`: Mostra informació detallada sobre un usuari, incloent el seu nom complet, el directori d'inici, la shell per defecte i l'horari d'inici de sessió. Aquesta comanda pot no estar instal·lada per defecte en algunes distribucions, però es pot instal·lar fàcilment des dels repositoris oficials.

## Perfil d'usuari

Quan un usuari inicia sessió al sistema, es carrega un perfil d'usuari que defineix l'entorn de treball i les configuracions específiques per a aquest usuari. El perfil d'usuari inclou variables d'entorn, configuracions de la shell, scripts d'inici i altres paràmetres que afecten el comportament del sistema per a aquest usuari.

I com es crea aquest perfil? Bàsicament el sistema crea un directori d'inici per a cada usuari, que sol ser `/home/nom_usuari`, i copia fitxers de configuració predeterminats des del directori `/etc/skel`. Aquests fitxers inclouen configuracions de la shell, com ara `.bashrc`, `.profile` i altres fitxers ocults que defineixen l'entorn de treball de l'usuari.

Podem veure per un usuari el perfil llistant el contingut del seu directori d'inici amb la comanda `ls -la /home/nom_usuari`. Això ens mostrarà tots els fitxers i directoris, incloent els fitxers i carpetes ocultes que comencen amb un punt (`.`).

```bash
usuari@server:~$ ls -laA
total 32
-rw------- 1 usuari usuari  673 Jun 21 08:00 .bash_history
-rw-r--r-- 1 usuari usuari  220 Feb 13 12:16 .bash_logout
-rw-r--r-- 1 usuari usuari 3771 Feb 13 12:16 .bashrc
drwx------ 2 usuari usuari 4096 Jun 20 08:02 .cache
-rw------- 1 usuari usuari   20 Jun 20 13:47 .lesshst
drwx------ 3 usuari usuari 4096 Jun 20 13:38 .local
-rw-r--r-- 1 usuari usuari  807 Feb 13 12:16 .profile
drwx------ 2 usuari usuari 4096 Jun 20 07:59 .ssh
```

Per personalitzar el perfil dels nous usuaris, podem modificar els fitxers de configuració al directori `/etc/skel`. Qualsevol fitxer que afegim o modifiquem en aquest directori es copiarà automàticament al directori d'inici dels nous usuaris quan es creïn.

### Modificar els arxius de configuració de l'entorn

Dins de /etc/skel/ ja existeixen diversos arxius ocults per defecte (pots veure'ls amb ls -A /etc/skel). Els més importants per a editar són:

- `.bashrc`: Ideal per a afegir àlies (aliases) de comandes, funcions personalitzades o canviar el color i disseny del prompt (PS1).
- `.bash_profile` o `.profile`: Útil per a definir variables d'entorn globals de l'usuari (com les rutes PATH).

Com a exemple pràctic veiem com afegir un àlies i un missatge de benvinguda. Obre l'arxiu `.bashrc` de la plantilla com a administrador:

```bash
sudo nano /etc/skel/.bashrc
```

Afegeix les següents línies al final de l'arxiu:

```bash
# Àlies personalitzats per al nou usuari
alias ll='ls -lA'
alias actualitzar='sudo apt update && sudo apt upgrade -y'

# Missatge de benvinguda en obrir la terminal
echo "¡Benvingut al servidor, $USER!"
```

### Creació carpetes per defecte

Si vols que tots els usuaris tinguin carpetes específiques en el seu inici (per exemple, una carpeta anomenada Projectes o Compartit), crea-les directament allà dins:

```bash
sudo mkdir /etc/skel/Projectes
sudo mkdir /etc/skel/Compartit
```

### Creació arxius de text o plantilles

Pots deixar un arxiu d'instruccions o normes del servidor a l'arrel del directori de l'usuari:

```bash
echo "Benvingut. Recorda canviar la teva contrasenya cada 90 dies." | sudo tee /etc/skel/LLEGEIX-ME.txt
```

> La comanda `tee` s'utilitza per escriure el contingut a un fitxer amb permisos d'administrador, ja que `/etc/skel` requereix privilegis elevats per modificar-se i usant el el redirector clàssic `>` només aplicaria el sudo a la comanda echo. La comanda tee actua com una "T" de lampisteria: rep una entrada de text i la bifurca cap a dues sortides (la pantalla i un arxiu).

### Afegir rutes de programari al PATH

Per afegir rutes de programari al PATH de tots els usuaris, podem editar l'arxiu `/etc/skel/.bashrc` i afegir la línia següent:

```bash
export PATH=$PATH:/ruta/al/teu/programari
```

## Inicis de sessió i tancaments de sessió

Quant un usuari inicia sessió al sistema, es carreguen els fitxers de configuració del seu perfil d'usuari, com ara `.bashrc`, `.profile` i altres fitxers ocults. Aquests fitxers defineixen l'entorn de treball i les configuracions específiques per a aquest usuari.

Però com puc canviar d'usuari sense tancar la sessió actual?

Per canviar d'usuari sense tancar la sessió, podem utilitzar la comanda `su` (substitute user). Aquesta comanda ens permet iniciar una sessió com un altre usuari sense haver de tancar la sessió actual. Per exemple, per canviar a l'usuari `usuari`, podem executar la següent comanda `su usuari`. El sistema demanarà la contrasenya de l'usuari `usuari` abans de permetre l'accés.

Si us pregunteu si això equival a iniciar la sessió amb l'usuari `usuari`, la resposta és que no exactament. Quan utilitzem `su`, estem canviant temporalment a l'usuari especificat, dins la mateixa sessió de terminal, no canviem a la seva carpeta personal, ni es carrega el seu entorn complet.

Si volem iniciar sessió com un altre usuari i carregar el seu entorn complet, podem utilitzar l'opció `-` o `--login` amb la comanda `su`. Per exemple, per iniciar sessió com l'usuari `usuari` i carregar el seu entorn complet, podem executar la següent comanda:

```bash
su - usuari
```

Per tancar la sessió de l'usuari actual i tornar a l'usuari anterior, podem utilitzar la comanda `exit`, si fem servir `exit` amb una sessió iniciada des del sistema, tornarem a la pantall d'inici de sessió del sistema.
