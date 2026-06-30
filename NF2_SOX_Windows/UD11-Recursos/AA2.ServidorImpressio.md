# Servidor Impressió

## Introducció

A una organització un ús eficient de les impressores és fonamental per a la productivitat i la gestió de recursos. Un servidor d'impressió centralitza la gestió de les impressores, permetent als usuaris enviar treballs d'impressió des de qualsevol lloc dins de la xarxa i facilitant l'administració dels dispositius d'impressió.

En aquesta activitat veurem com configurar un servidor d'impressió en un entorn de Directori Actiu, com crear cues d'impressió amb múltiples impressores i com desplegar les impressores als usuaris de manera eficient mitjançant polítiques de grup.

## Compartició bàsicad'impressores

La compartició bàsica usant el protocol SMB, es pot usar tant en entorns de servidor-client, com en entorns de grup de treball, on un equip Windows 10 o 11 comparteix una impressora amb altres equips de la xarxa. Per compartir una impressora, s'accedeix a les opcions "Impressores i escàners" del sistema operatiu, es selecciona la impressora que es vol compartir i se selecciona l'opció "Administrar".

A continuació, es fa clic a "Propietats de la impressora" i es selecciona la pestanya "Compartir". Aquí es marca l'opció "Comparteix aquesta impressora" i es pot assignar un nom de compartició que serà visible per als altres equips de la xarxa.

![Compartició d'impressores](../Imatges/AA2.ServidorImpressio/UD11_25.png)

## Servidor d'impressió

Si disposem d'un entorn amb un servidor Windows Server, podem configurar un servidor d'impressió que centralitzi la gestió de les impressores. Això permet als administradors controlar l'accés a les impressores, gestionar els controladors i monitoritzar l'ús de les impressores.

![Servidor d'impressió](../Imatges/AA2.ServidorImpressio/UD11_26.png)

Un cop instal·lat el rol, s'accedeix a la consola de "Gestió d'impressores" o "Print Management".

![Gestió d'impressores](../Imatges/AA2.ServidorImpressio/UD11_27.png)

Per agregar una impressora, cal anar a la secció "Printers" i fent botó dret seleccionar "Add Printer". Es pot afegir una impressora local o de xarxa, i es poden instal·lar els controladors necessaris.

Per instal·lar la impressora, en primer lloc ens pregunta on està connectada la impressora, si és local o de xarxa. Si és de xarxa, caldrà introduir la IP o el nom del servidor on està connectada. Un cop seleccionada la impressora, es poden instal·lar els controladors corresponents. Per exemple, seleccionem "Add a new printer using an existing port" i triem el port LPT1.

El següent pas és seleccionar el fabricant i el model de la impressora, per fer això, es triar l'opció "Install a new driver". Aquí ens apareixerà una llista de fabricants i models d'impressores i, per exemple, triem  una impressora "Brother".

Un cop fet això, ens apareixerà a la llista d'impressores disponibles.
