# UD4-Compartició de recursos

La compartició de recursos en xarxa és una de les utilitats o raons principals perquè els sistemes operatius es connectin en xarxa.

Els poden compartir en xarxa tots tipus de recursos, encara que els recursos més habituals són:

- Arxius i carpetes
- Impressores

Quins avantages té la compartició de recursos?

- **Estalvi de costos**: No cal comprar una impressora per a cada usuari, sinó que es pot compartir una sola impressora entre diversos usuaris. De la mateixa manera, es poden compartir arxius i carpetes entre diversos usuaris sense necessitat de duplicar-los, amb el corresponent estalvi en dispostius d'emmagatzematge.

- **Facilitat d'accés**: Els usuaris poden accedir als recursos compartits des de qualsevol lloc de la xarxa, sense necessitat de desplaçar-se físicament fins al dispositiu que conté el recurs.

- **Facilitat de gestió i seguretat**: La gestió dels recursos compartits és més senzilla i segura, ja que es poden controlar els permisos d'accés i les configuracions des d'un únic punt de gestió. A més evitem el problema de la **inconsistència de dades**, ja que només hi ha una còpia del recurs compartit, i tots els usuaris accedeixen a la mateixa versió.

## Compartició d'arxius i carpetes

Als sistemes *nix*, com Linux, la compartició d'arxius i carpetes es pot realitzar mitjançant diversos protocols, com ara `NFS` (Network File System) o `Samba` (SMB/CIFS). Mentre que el primer és natiu del món Unix, el segon va néixer per oferir compatibilitat amb sistemes Windows.

En aquesta unitat estudiarem el protocol `NFS`, deixant Samba per més endanvant, quan veiem la integració de Linux amb Windows.

### Què és NFS?

NFS (Network File System) és un protocol de compartició de fitxers que permet als usuaris accedir a fitxers i directoris en un servidor remot com si fossin locals. Malgrat el seu nom, no és un sistema de fitxers en si mateix, sinó un protocol que permet muntar sistemes de fitxers remots a la màquina local.

Aquest protocol va ser desenvolupat per Sun Microsystems a principis dels anys 80 per a permetre la compartició de fitxers entre sistemes Unix, sent adoptat àmpliament en entorns Linux i altres sistemes operatius com els derivats de BSD i macOS. Fins i tot Windows ofereix suport per a NFS tant a nivell de servidor com de client, encara que no és tan comú com el protocol SMB.

El seu funcionament es basa a les següents característiques:

- **Model client-servidor**: NFS segueix un model client-servidor, on el servidor NFS comparteix directoris i els clients NFS poden muntar aquests recursos compartits com si fossin part del seu sistema de fitxers local.

- **Transparència**: Els usuaris poden accedir als fitxers remots com si estiguessin en el seu propi sistema, sense necessitat de conèixer la ubicació física dels fitxers.

- **Crides RPC (Remote Procedure Call)**: NFS utilitza crides RPC per a la comunicació entre el client i el servidor, permetent que les operacions de fitxers es realitzin de manera remota.

Pel que fa les versions, les dues que s'usen a l'actualitat són:

- **NFSv3**: És la versió més utilitzada i estable, que ofereix suport per a operacions de lectura i escriptura, així com per a la gestió de permisos i propietats dels fitxers. No disposa però de mecanismes de seguretat com el xifrat.

- **NFSv4**: És la versió més recent i completa, que ofereix millors funcionalitats de seguretat, com ara autenticació, les llistes de control d'accés (ACLs) i xifrat.

### Recordatori sistema permisos UGO

Als sistemes Unix, els permisos d'accés als fitxers i directoris es gestionen mitjançant un model de permisos conegut com a UGO (User, Group, Others). Aquest model defineix tres tipus d'usuaris:

- **User (U)**: L'usuari propietari del fitxer o directori.
- **Group (G)**: El grup propietari del fitxer o directori.
- **Others (O)**: Tots els altres usuaris que no són ni el propietari ni pertanyen al grup del fitxer o directori.

És a dir, que cada fitxer o carpeta té associats un **usuari propietari**, un **grup propietari**.

A Sistemes Operatius Monolloc, ja vam veure com es poden canviar la propietat d'un fitxer o carpeta amb la comanda `chown` que permet canviar l'usuari i el grup o la comanda `chgrp` que permet canviar només el grup.

```bash
# Canviar propietari i grup d'un fitxer
chown usuari:grup fitxer
# Canviar només el propietari d'un fitxer
chown usuari fitxer
# Canviar només el grup d'un fitxer
chgrp grup fitxer
chown :grup fitxer

# Canviar propietari i grup d'una carpeta i tot el seu contingut
chown -R usuari:grup carpeta

# Comprovar propietari i grup d'un fitxer o carpeta
ls -l fitxer
ls -l carpeta
```

Els permisos d'accés es representen amb tres bits per a cada tipus d'usuari, que indiquen si tenen permís de lectura (r), escriptura (w) i execució (x). D'aquesta manera, els permisos es poden expressar de la següent manera:

| Permís  | Significat |
|---------|------------|
| r       | Permís de lectura: l'usuari pot llegir el contingut del fitxer o llistar el contingut del directori. |
| w       | Permís d'escriptura: l'usuari pot modificar el contingut del fitxer o afegir/eliminar fitxers dins del directori.|
| x       | Permís d'execució: l'usuari pot executar el fitxer o accedir al directori.|

El permís d'accés per cada tipus d'usuari es pot representar amb una combinació de tres bits, on cada bit correspon a un permís específic. Per exemple, els permisos `rwx` es representen com `111` en binari, mentre que els permisos `rw-` es representen com `110`. Aquests permisos es poden expressar en forma octal, on cada combinació de tres bits es converteix en un dígit octal (0-7).

Per exemple:

| Permisos | Binari | Octal |
|----------|--------|-------|
| rwx      | 111    | 7     |
| rw-      | 110    | 6     |
| r-x      | 101    | 5     |
| r--      | 100    | 4     |

Per modificar o establir els permisos d'accés a fitxers i directoris, es pot utilitzar la comanda `chmod`. Aquesta comanda permet canviar els permisos d'accés de manera simbòlica o numèrica.

```bash
# Canviar permisos d'accés de manera simbòlica
# Afegir permís d'escriptura per al grup
chmod g+w fitxer
# Treure permís d'execució per a altres usuaris
chmod o-x fitxer

# Establir permisos d'accés de manera numèrica
chmod 755 fitxer

## Aplicar permisos d'accés a una carpeta i tot el seu contingut
chmod -R 775 carpeta
```

### Instal·lació i configuració de NFS

1. El primer pas serà la instal·lació del paquet `nfs-kernel-server` al servidor NFS.
2.

### Permisos d'accés a recursos compartits NFS

Per defecte, NFS no valida els usuaris, sinó que confia en el sistema de permisos del sistema de fitxers local. Això significa que els permisos d'accés als fitxers i directoris compartits a través de NFS es basen en els permisos establerts al sistema de fitxers del servidor NFS usant el UID i el GID definits a la propietat del fitxer o directori. Per tant, és important assegurar-se que els usuaris i grups tinguin els mateixos UID i GID tant al servidor com als clients NFS per garantir un accés correcte.

Posem el següent exemple per il·lustrar millor:

Al servidor NFS tenim definits els següents usuaris (UID i GID):

| Usuari | UID  | GID  |
|--------|----- |----- |
| joan   | 1001 | 1001 |
| bob    | 1002 | 1002 |
| maria  | 1003 | 1003 |
| pep    | 1004 | 1310 |

A una màquina client els usuaris definits són:

| Usuari | UID  | GID  |
|--------|----- |----- |
| pep    | 1001 | 1001 |
| joan   | 1002 | 1310 |

Suposem una carpeta anomenada `recurs` amb propietat de user amb permisos 750. Quin tipus d’accés tindran els usuaris d’un host al que s’ha compartit el recurs com rw?
