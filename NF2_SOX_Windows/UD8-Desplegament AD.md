# UD 8. Desplegament de un Directori Actiu

RA3. Realitza tasques de gestió sobre dominis identificant necessitats i aplicant eines d'administració de dominis.

Durada prevista: 2 hores

## Concepte de directori actiu

El directorio actiu és el producte estrella de Microsoft per a la gestió de dominis i xarxes. És un servei de directori que permet administrar i organitzar recursos dins d'una xarxa, com ara usuaris, grups, ordinadors i altres dispositius.

Un servei de directori, es una base de dades que emmagatzema informació sobre els recursos d'una xarxa i proporciona serveis d'autenticació i autorització per a aquests recursos.

El directori actiu utilitza protocols com LDAP (Lightweight Directory Access Protocol) per a la consulta i modificació de la informació del directori, DNS (Domain Name System) per a la resolució de noms i Kerberos per a l'autenticació segura.

### Objectius del directori actiu:

- Administració centralitzada:
  - Usuaris, equips i grups s’administren des d’una estructura comuna.
  - Polítiques basades en els grups (GPO) que permeten configurar els sistemes de forma centralitzada.
- Seguretat:
  - Els usuaris s’autentiquen contra el sistema per assegurar la seva identitat, enlloc de tenir que autenticar-se en cada equip de forma local.
  - Els equips accedeixen als serveis mitjançant auntenticació usant el protocol Kerberos.

### El controlador de domini

La gestió del directori actiu la realitzen els controladors de domini (DC).
En Windows 2025 es poden tenir tants DC com es vulguin gestionant un domini.

Els DCs del domini s’aniran replicant la informació entre ells i repartint-se els roles. Des de 2008 Server, la gestió del domini es realitza mitjançant DNS, per això cal que existeixi sempre un servidor DNS que contingui el domini.

## Configuració del domini

L'eina d'administració del domini és el "Server Manager", que ens permetrà afegir els rols, accedir a les consoles d'administració i gestionar els serveis del servidor.

![Server Manager](./img/desplegament_ad_1.png)

### Configuracions incials

El primer pas serà canviar el nom del servidor, per un nom és identicatiu, com per exemple "DC1". Per canviar el nom del servidor, anirem a "Local Server" i farem clic a "Computer Name".

![Canviar el nom del servidor](./img/desplegament_ad_2.png)

El següent pas és canviar la configuració de xarxa per tal que el controlador del domini s'apunti a sí mateix com a servidor DNS. Aquest pas és molt important, ja que si no el propi controlador de domini no veurà el domini.

![Configuració de xarxa](./img/desplegament_ad_3.png)

### Afegir rol de "Active Directory Domain Services"

Un cop canviat el nom del servidor i configurada la xarxa, ja podem afegir el rol de "Active Directory Domain Services" (AD DS) al servidor. Per fer-ho, anirem a "Manage" i seleccionarem "Add Roles and Features".

![Afegir rol AD DS](./img/desplegament_ad_4.png)

![Afegir rol AD DS](./img/desplegament_ad_5.png)

![Afegir rol AD DS](./img/desplegament_ad_6.png)

### Promoció del servidor a controlador de domini

Un cop instal·lat el rol, cal fer el desplegament, se'ns marcarà una notificació a la part superior del "Server Manager" indicant que cal fer el desplegament del rol. Farem clic a "Promote this server to a domain controller".

![Promote this server to a domain controller](./img/desplegament_ad_7.png)

A continuació cal seleccionar el tipus de desplegament, les opcions són:

- **Afegir un controlador de domini a un domini existent**: és afegir un nou controlador de domini a un domini que ja existeix.
- **Crear un nou arbre de dominis dins d’un bosc existent**: és crear un subdomini dins d’un domini que ja existeix. Per exemple, si el domini existent és "escola.test", es podria crear un subdomini "secundaria.escola.test".
- **Crear un nou domini**: és crear un nou domini, dins d’un nou bosc (forest) i posar-li un nom, com per exemple "escola.test".

![Crear un nou domini](./img/desplegament_ad_8.png)

Ara cal indicar el nivell funcional del bosc i del domini, que marca la compatibilitat del domini amb els istemes operatius, en aquest cas serà Windows Server 2025.

També cal indicar la contrasenya de restauració dels serveis d’Active Directory (DSRM), per evitar oblits, posarem la mateixa contrasenya que la de l’usuari administrador.

Ja hem indicat anteriorment que el servei de directori actiu utilitza DNS, el sistema avisa que no troba cap disponible i que procedeix a instal·lar-lo. Acceptarem la instal·lació del servei DNS.

![Instal·lació del servei DNS](./img/desplegament_ad_9.png)

Abans d'usar els serveis DNS, els servidors Windows usaven un protocol propi anomentat NETBIOS i que encara avui es fa servir per a la resolució de noms en xarxes locals. Per això, cal indicar un nom NETBIOS pel domini, que serà el mateix que el nom del domini, però sense els sufixe i en majúscules.

![Nom NETBIOS](./img/desplegament_ad_10.png)

Ens demana on ubicarà els arxius de gestió del directori actiu, deixarem les opcions per defecte i farem clic a "Next", per arribar a la pantalla de resum, on farem clic a "Install" per iniciar el procés de promoció del servidor a controlador de domini.

![Resum de la promoció del servidor a controlador de domini](./img/desplegament_ad_11.png)

A més, genera un script de PowerShell amb les ordres que s’han executat, per si volem fer la promoció del servidor a controlador de domini mitjançant línia de comandes. Això és ideal a l'hora de fer promocions massives de servidors, ja que es poden automatitzar amb scripts.

![Script de PowerShell](./img/desplegament_ad_12.png)

Un cop finalitzat el procés, el sistema es reiniciarà automàticament i ja tindrem el nostre servidor com a controlador de domini.

![Servidor com a controlador de domini](./img/desplegament_ad_13.png)
