# UD2. Configuració bàsica servidor GNU/Linux

RA1. Instal·la sistemes operatius en xarxa descrivint-ne les característiques i interpretant-ne la documentació tècnica.

Durada prevista: 4 hores.

Un cop tenim el nostre servidor Ubuntu Server instal·lat, el primer que caldrà fer és actualitzar-lo i configurar-lo correctament. En aquesta unitat veurem com fer-ho.

>Previ a treballar aquesta activitat, és important que feu un repàs de les comandes bàsiques de terminal que vau estudiar el curs passat, ja que seran imprescindibles per a la gestió del sistema. En especial, cal que tingueu clar com moure-us pel sistema de fitxers, mostrar el contingut de carpetes, com crear i eliminar fitxers i directoris, com copiar i moure fitxers, com veure el contingut d'un fitxer i com editar-lo amb editors de text com `nano`. També és important que tingueu clar com utilitzar les comandes `sudo` i `su` per executar ordres amb privilegis d'administrador.
>
>Aquí teniu un enllaç al llibre online [The Linux Command Line](https://linuxcommand.org/tlcl.php) que us pot ajudar a repassar. **Dediqueu temps a casa a repassar les comandes, ja que són la base per a poder administrar un sistema GNU/Linux.**

## Instal·lació d'aplicacions i actualització del sistema

Als sistemes Linux les aplicacions tradicionalment s'instal·len a través de repositoris, que són servidors on es troben els paquets d'aplicacions i les seves dependències. A Ubuntu Server, el gestor de paquets és `apt`, que ens permet instal·lar, actualitzar i eliminar aplicacions fàcilment, de tota manera, veurem com han aparegut alternatives com `snap` i `flatpak`, que permeten instal·lar aplicacions de manera més independent del sistema.

### Gestió de paquets amb apt

**Paquet**: arxiu que conté una sèrie de fitxers que es distribueixen conjuntament i permeten la instal·lació d'un programa. La raó principal de la distribució conjunta és que el funcionament de cada fitxer en complementa o en requereix uns altres.

**Repositori**: lloc on es troben els paquets d'aplicacions i les seves dependències. Els repositoris poden ser oficials, mantenits per l'equip de desenvolupament del sistema operatiu, o no oficials, mantinguts per tercers. Això vol dir que, per defecte, el nostre equip anirà a buscar els paquets als repositoris que tingui definits.

**Dependències**: paquets que són necessaris per al correcte funcionament d'un altre paquet. Per exemple, si instal·lem un programa que necessita una llibreria concreta, aquesta llibreria serà una dependència del programa i s'instal·larà automàticament si no està present al sistema. Les dependències neixen perquè es vol evitar la duplicació de codi i aprofitar el codi ja existent, però també poden generar problemes si no es gestionen correctament. Per exemple, si un paquet necessita una versió concreta d'una llibreria i aquesta llibreria s'actualitza a una versió incompatible, el paquet deixarà de funcionar correctament.

Per tant, quan s'instal·la un paquet, cal també assegurar-se que totes les seves dependències estiguin correctament instal·lades i actualitzades. Això és una de les tasques principals del **gestor de paquets**, que s'encarrega de resoldre les dependències i garantir que el sistema funcioni de manera estable.

| | Família Debian | Família SUSE | Família Red Hat |
| :--- | :--- | :--- | :--- |
| **Gestor d’alt nivell** | apt | zypper | dnf (reemplaça yum) |
| **Gestor de baix nivell** | dpkg | rpm | rpm |

#### Comandes apt bàsiques

- `apt install nomdelpaquet`: instal·la paquets i les seves dependències.
- `apt remove nomdelpaquet`: desinstal·la el paquet indicat.
- `apt purge nomdelpaquet`: desinstal·la el paquet i elimina arxius configuració.
- `apt update`: actualitza la informació sobre quins paquets contenen els repositoris que es guarden a /etc/apt/sources.list.
- `apt upgrade`: actualitza els paquets ja instal·lats amb les darreres versions que hi ha als repositoris.
- `apt autoremove`: desinstal·la paquets que hi ha al sistema i que ja no es fan servir.
- `apt clean`: esborra els arxius dels paquets ja instal·lats per estalviar disc.

#### Informació sobre els repositoris

En anteriors versions l'arxiu `/etc/apt/sources.list` contenia la llista de repositoris que el sistema utilitza per buscar i descarregar paquets, però des de la versió 24.04, es va introduir un nou sistema de gestió de repositoris que utilitza arxius individuals dins del directori `/etc/apt/sources.list.d/`, amb l'objectiu de millorar l'organització i la gestió dels repositoris. Cada arxiu dins d'aquest directori correspon a un repositori específic, i el seu nom sol reflectir el nom del repositori o del paquet que conté. Per defecte hi ha un arxiu anomenat `ubuntu.sources`que conté els repositoris oficials d'Ubuntu, i es poden afegir arxius addicionals per a repositoris de tercers.

```bash
# Exemple d'arxiu ubuntu.sources
Types: deb
URIs: http://es.archive.ubuntu.com/ubuntu/
Suites: resolute resolute-updates resolute-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

Types: deb
URIs: http://security.ubuntu.com/ubuntu/
Suites: resolute-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
```

Amb la comanda `apt update` s'actualitza la informació sobre quins paquets contenen els repositoris que es guarden a `/etc/apt/sources.list.d/`, assegurant que els repositoris estiguin actualitzats i accessibles.

### Actualització del sistema

Per instal·lar les actualitzacions dels diferents paquets instal·lats al sistema:

`sudo apt update && sudo apt upgrade -y`

Per actualitzar més en profunditat, incloent actualitzacions de kernel, canvis de dependències i eliminació de paquets obsolets, s'utilitza la comanda:

`sudo apt update && sudo apt full-upgrade`

Finalment, si el que volem és migrar a una nova versió del sistema, s'utilitza la comanda `sudo do-release-upgrade`.

>**Important**: abans de fer un canvi de versió del sistema, és necessari fer un `apt full-upgrade` per assegurar que tots els paquets estiguin actualitzats i que no hi hagi dependències trencades. Un cop fet el upgrade, cal reiniciar el sistema i aleshores, executar el release-upgrade. Si no es fa així, el sistema pot quedar en un estat inconsistent i provocar errors de dependències que poden afectar el funcionament del sistema.

### Gestió de baix nivell amb dpkg

La comanda dpkg és el gestor de baix nivell:

- no descarrega els paquets
- no resol dependències

Opcions bàsiques:

- `sudo dpkg –i nomdelpaquet`: instal·la el paquet
- `sudo dpkg –reconfigure nomdelpaquet`: reconfigura el paquet ja instal·lat.
- `sudo dpkg –r nomdelpaquet`: elimina un paquet

El problema del dpkg és que no resol les dependències, per tant, si un paquet necessita una llibreria concreta i aquesta no està instal·lada, el paquet no funcionarà correctament, per això, s'usava la comanda `apt install -f` per intentar resoldre les dependències trencades.

Amb les versions més recents, la comanda `apt` permet instal·lar un paquet directament des d'un arxiu `.deb` i resoldre les dependències automàticament, per exemple: `sudo apt install ./nomdelpaquet.deb`.

### Alternatives a apt: snap i flatpak

Tot i que `apt` continua sent el gestor de paquets tradicional i més utilitzat en distribucions basades en Debian, com Ubuntu, durant els darrers anys han sorgit noves alternatives que ofereixen un enfocament diferent per a la instal·lació i gestió d'aplicacions: **Snap** i **Flatpak**. Aquestes tecnologies busquen resoldre alguns dels problemes clàssics de la instal·lació de programari, com les dependències complexes i els conflictes entre versions de llibreries.

#### Snap: l'alternativa de Canonical

Snap és el format desenvolupat per Canonical (l'empresa darrere d'Ubuntu) i està profundament integrat al sistema operatiu.

- **Avantatges del servidor**: Permet empaquetar aplicacions de terminal, serveis de fons (dimonis) i eines del sistema (com Docker o Nextcloud).
- **Actualitzacions**: Són automàtiques i en segon pla, garantint pegats de seguretat ràpids.
- **Aïllament**: Utilitzeu AppArmor per confinar aplicacions i protegir el sistema.
- **Inconvenients**: el codi Snap Store està tancat i centralitzat per Canonical. A més, les aplicacions Snap ocupen més espai en disc que les instal·lades amb apt.

Per instal·lar un paquet Snap, s'utilitza la comanda: `sudo snap install nomdelpaquet`. Teniu informació detallada de la comanda snap al següent [enllaç](https://soyadmin.com/comandos-para-manejar-snap-desde-la-consola-como-todo-un-campeon/).

#### Flatpak: l'alternativa de Red Hat

Flatpak és un sistema de distribució d'aplicacions desenvolupat per Red Hat i altres col·laboradors de la comunitat Linux, però se centra més en aplicacions gràfiques i entorns d'escriptori. Ubuntu no inclou de manera nativa, però es pot instal·lar fàcilment. De tota manera, el seu ús en servidors no està recomanat, i de fet, la major part d'aplicacions disponibles són per a entorns d'escriptori. De fet, distribucions basades en Ubuntu com Mint o Zorin, que estan orientades a entorns d'escriptori, sí que inclouen Flatpak de manera nativa.

Resumint, es recomana `Snap` per aquelles aplicacions autocontingudes i que necessiten actualitzacions automàtiques, mentre que els paquets `deb` tradicionals es recomanen per a eines essencials i serveis on el rendiment i la compatibilitat amb el sistema són crítics.

## Configuracions bàsiques del sistema

### Configuració del nom de la màquina

El nom de la màquina és un identificador únic que permet distingir-la dins d'una xarxa. Aquest nom és important per a la gestió del sistema i per a la comunicació amb altres dispositius. A Ubuntu Server, el nom de la màquina es pot configurar durant la instal·lació, però també es pot canviar posteriorment amb la comanda `hostnamectl set-hostname nomdelamaquina`. Per exemple, si volem canviar el nom de la màquina a "servidor1", executarem:

```bash
sudo hostnamectl set-hostname servidor1
```

A més, cal ctualitzar el fitxer `/etc/hosts` per reflectir aquest canvi, editant la línia que relacioni l'adreça IP de la màquina amb el nou nom, sinó tindrem problemes a l'hora de treballar amb el sistema.

```bash
127.0.0.1 localhost
127.0.1.1 servidor1

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

### Configuració del teclat

En primer lloc, amb la comanda `localectl status` podem veure la configuració actual del sistema, incloent l'idioma i la distribució del teclat. Per canviar la distribució del teclat, podem utilitzar la comanda `sudo dpkg-reconfigure keyboard-configuration`, que ens permetrà seleccionar la distribució adequada segons el nostre teclat físic. Un cop fet el canvi, cal reiniciar el servei de teclat amb `sudo service keyboard-setup restart` per aplicar els canvis.

### Configuració de la zona horària i de l'hora del sistema

Per comprovar data, hora (recordeu que els ordinadors usen hora UTC) i zona horària usem la comanda `timedatectl`, que ens mostrarà la informació actual del sistema:

```bash
                Local time: ds. 2026-06-20 14:30:42 UTC
           Universal time: ds. 2026-06-20 14:30:42 UTC
                 RTC time: ds. 2026-06-20 14:27:07
                Time zone: Etc/UTC (UTC, +0000)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

Si s'ha de canviar la zona horària, primer cal veure quines zones horàries estan disponibles amb la comanda `timedatectl list-timezones`. Un cop seleccionada la zona horària correcta, es pot establir amb la comanda `sudo timedatectl set-timezone nomdelazonahoraria`, per exemple:

```bash
sudo timedatectl set-timezone Europe/Madrid
```

Normalment l'equip sincronitza l'hora amb un servidor NTP, però pot passar que si hem pausat la màquina o l'hem apagat guardant l'estat, l'hora del sistema es desincronitzi. En aquest cas, podem forçar la sincronització amb la comanda `sudo timedatectl set-ntp true`.

Si tenim un equip que no té accés a Internet, podem establir l'hora manualment amb la comanda `sudo timedatectl set-time "YYYY-MM-DD HH:MM:SS"`, substituint "YYYY-MM-DD HH:MM:SS" per la data i hora correctes. Per exemple, per establir l'hora a les 15:45 del 20 de juny de 2026, executaríem:

```bash
sudo timedatectl set-time "2026-06-20 15:45:00"
```

## Configuració de la xarxa

En Ubuntu Server, la configuració de la xarxa es gestiona principalment a través de Netplan, que és una eina que permet definir la configuració de xarxa mitjançant fitxers YAML. Aquests fitxers es troben al directori `/etc/netplan/` i tenen l'extensió `.yaml`. Per exemple, un fitxer de configuració de Netplan podria tenir el següent aspecte:

```yaml
# This is the network config written by 'subiquity'
network:
  ethernets:
    enp0s3:
      dhcp4: true
      dhcp6: true
      match:
        macaddress: 08:00:27:25:4d:4f
      set-name: enp0s3
    enp0s8:
      dhcp4: true
      dhcp6: true
  version: 2
```

L'opció macaddress permet identificar la targeta de xarxa per la seva adreça MAC, que és un identificador únic assignat a cada dispositiu de xarxa. Això és útil per assegurar que la configuració s'aplica a la targeta correcta, especialment en sistemes amb múltiples interfícies de xarxa.

Si necessitem usar una configuració estàtica, per exemple, quan una de les interfícies està en mode "adaptador pont" o "xarxa interna", podem modificar el fitxer YAML per establir una adreça IP fixa, una màscara de subxarxa i una passarel·la. Per exemple:

```yaml
network:
  ethernets:
    enp0s3:
      dhcp4: false
      dhcp6: true
      addresses:
        - 192.168.1.100/24
      routes:
        - to: default
          via: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 1.1.1.1
      match:
        macaddress: 08:00:27:25:4d:4f
      set-name: enp0s3
    enp0s8:
     dhcp4: true
     dhcp6: true
  version: 2
```

Un detall molt important a tenir en compte és que els fitxers YAML són molt sensibles a la **indentació** (alineació) i que cal usar **espais** en lloc de tabuladors.

Per aplicar els canvis, cal executar la comanda `sudo netplan apply`, que llegirà els fitxers de configuració i aplicarà la nova configuració de xarxa al sistema. Si hi ha algun error en la sintaxi del fitxer YAML, Netplan mostrarà un missatge d'error i no aplicarà els canvis fins que es corregeixi el problema.

Un cop aplicats els canvis, podem verificar la configuració de la xarxa amb la comanda `ip a`, que mostrarà les interfícies de xarxa i les adreces IP assignades.

### Altres configuracions

Als sistemes GNU/Linux, les configuracions solen fer a través de fitxers de text, que es troben en diferents directoris del sistema. Alguns exemples de fitxers de configuració importants són:

- `/etc/hosts`: Conté la relació entre adreces IP i noms de màquina.
- `/etc/resolv.conf`: Conté la configuració dels servidors DNS.
- `/etc/fstab`: Conté la configuració de les particions i sistemes de fitxers que es muntaran automàticament en iniciar el sistema.
- `/etc/passwd`: Conté informació sobre els usuaris del sistema, com el nom d'usuari, l'identificador d'usuari (UID), el directori d'inici i la shell per defecte.
- `/etc/group`: Conté informació sobre els grups d'usuaris del sistema, com el nom del grup, l'identificador de grup (GID) i els membres del grup.
- `/etc/shadow`: Conté informació sobre les contrasenyes dels usuaris, com la contrasenya xifrada, la data de l'últim canvi de contrasenya i les polítiques de caducitat de la contrasenya.

A més, quan instal·lem serveis addicionals, aquests solen crear els seus propis fitxers de configuració dins del directori `/etc/`, amb el nom del servei o aplicació. Per exemple, si instal·lem el servidor web Apache, es crearan fitxers de configuració dins del directori `/etc/apache2/`.
