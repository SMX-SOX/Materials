# UD 12. Monitorització en Directori Actiu

RA 5. Realitza tasques de monitorització i ús del sistema operatiu en xarxa, descrivint les eines utilitzades i identificant-ne les principals incidències

Durada prevista: 8 hores

## Monitorització

L’administració de sistemes implica un manteniment proactiu (preventiu) per tenir una mesura del rendiment real dels sistemes, detectar colls d’ampolla, etc.

La monitorització dels diferents equips, entre ells dels servidors, permet detectar problemes, intrusions, abans que el problema afecti de forma greu el funcionament de l’organització.

Tenim diverses eines de monitorització disponibles al servidor:

- **Task Manager**: Permet veure els processos en execució, l’ús de CPU, memòria, xarxa i disc. És útil per identificar processos que consumeixen molts recursos.

- **Server Manager**: Proporciona una visió general de l’estat del servidor, incloent l’ús de recursos, esdeveniments i alertes. Permet gestionar rols i característiques del servidor.

- **Performance Monitor**: Permet crear gràfics i informes sobre l’ús de recursos del sistema, com CPU, memòria, disc i xarxa. És útil per analitzar tendències i identificar problemes de rendiment.

- **Resource Monitor**: Proporciona informació detallada sobre l’ús de recursos del sistema, incloent CPU, memòria, disc i xarxa. Permet identificar quins processos estan utilitzant més recursos i com es distribueixen aquests recursos entre els diferents processos.

### Task Manager

El task manager o administrador de tasques permet observar quins processos i tasques s’estan executant en el servidor, veure el seu consum de recursos i si és necessari cancel·lar una tasca determinada.

- **Procesess**: Ens mostra les aplicacions en execució, els processos en background. Per cadascun indica el consum de CPU i RAM.

- **Details**: tenim la llista completa de processos sense agrupar amb tota la informació detallada.

- **Performance**: ens mostra gràfics de l’ús de CPU, RAM, disc i xarxa.

- **Services**: ens mostra els serveis en execució i el seu estat. A més dóna la possibilitat d’iniciar, aturar o reiniciar un servei.

![Task Manager](./images/UD12_01.png)

## Server Manager

Des del propi Server Manager tenim un parell d'opcions de monitorització, a Performance podem programar tasques per monitoritzar l’ús de CPU, RAM.

![Server Manager](./images/UD12_02.png)

### Performance Monitor

És una eina que permet crear gràfics i informes sobre l’ús de recursos del sistema, com CPU, memòria, disc i xarxa. És útil per analitzar tendències i identificar problemes de rendiment. Permet crear informes i gràfics personalitzats per monitoritzar l’ús de recursos del sistema al llarg del temps.

![Performance Monitor](./images/UD12_03.png)

### Resource Monitor

És una eina que proporciona una informació similar a la que podeu obtenir amb l'opció de Performance del Task Manager. És menys flexible que el Performance Monitor i no tant vistòs com l'opció de Performance del Task Manager.

![Resource Monitor](./images/UD12_04.png)

## Auditoria

L’auditoria ens permet tenir un control centralitzat sobre els diferents objectes del directori actiu.

En entorns de producció, és molt important poder determinar qui ha accedit a un recurs o qui ha reiniciat una contrasenya, per exemple.

### Política d’auditoria

- Auditar events de logon de comptes (autenticació).
- Auditar l’administració dels comptes.
- Auditar l’accés del servei de directori.
- Auditar events de logon.
- Auditar l’accés a objectes.
- Auditar canvis de directives.
- Auditar ús de privilegis.
- Auditar seguiment de processos.
- Auditar esdeveniments del sistema.

Marcarem totes aquelles polítiques que es vulguin auditar. Per exemple, account logon events, logon events i object access.

![Auditoria](./images/UD12_05.png)

També es pot auditar l’accés a objectes, com ara fitxers i carpetes compartides. Per fer-ho, cal habilitar l’auditoria d’accés a objectes i configurar els permisos d’auditoria a les carpetes o fitxers que es vulguin auditar.

![Auditoria d'accés a objectes](./images/UD12_06.png)

### Visor d'esdeveniments

El visor d’esdeveniments és una eina que permet veure els esdeveniments registrats al sistema, com ara errors, advertències i informació. És útil per identificar problemes i incidències en el sistema.

![Visor d'esdeveniments](./images/UD12_07.png)

### Exemple auditar esborrat de fitxers

Anem a documentar com auditar quin usuari esborra una carpeta o arxiu d’una unitat de xarxa. Aquesta auditoria pot ser molt útil en cas de pèrdues de dades per tenir evidències de qui l’ha realitzat.

A la carpeta compartida anem a `Auditing` i indiquem que es volen controlar els esborrats.

![Auditoria d'esborrat de fitxers](./images/UD12_08.png)

A l’editor de GPO ho editem sobre una GPO que apliqui al servidor d’arxius (en aquest cas, és el mateix DC).

![Auditoria d'esborrat de fitxers GPO](./images/UD12_09.png)

També cal anar a la secció de configuració avançada

![Auditoria d'esborrat de fitxers GPO avançada](./images/UD12_10.png)

Marquem auditar el sistema de fitxers i les propietats del gestor de manipulacions (handle manipulation properties).

![Auditoria d'esborrat de fitxers GPO avançada 2](./images/UD12_11.png)

Un cop fet això cal actualitzar (gpupdate) al servidor de fitxers, que en el nostre cas, és el controlador de domini.

Per comprovar, des d’un client esborrem quelcom de la unitat de xarxa auditada, en el nostre cas una carpeta.

Al visor d’events, dins la secció Security veurem que apareixen events de la categoria File System.

![Auditoria d'esborrat de fitxers GPO avançada 3](./images/UD12_12.png)

Observem que ens diu que l’usuari ha esborrat quelcom, però com saber exactament què? Per fer-ho ens hem de fixar al ID del handle, caldrà buscar els events relacionats amb aquest hadle i seleccionar el que tingui identificador 4656.

![Auditoria d'esborrat de fitxers GPO avançada 4](./images/UD12_13.png)

Si l’obrim podem veure tant l’usuari com l’objecte en concret que s’ha esborrat.

![Auditoria d'esborrat de fitxers GPO avançada 5](./images/UD12_14.png)

## Enllaços d’interès

- [Microsoft Learn:Configure Performance Monitoring ](https://learn.microsoft.com/en-us/windows-server/identity/ad-fs/deployment/configure-performance-monitoring)

- [Enabling File Share Auditing in Active Directory (Windows Server)](https://medium.com/@basharraed/enabling-file-share-auditing-in-active-directory-windows-server-7f71755fe8b7)
