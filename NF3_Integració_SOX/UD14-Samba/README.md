# UD 14. Servidor Samba

RA6. Configura un servidor Samba per compartir recursos amb clients Windows, interpretant especificacions i aplicant eines del sistema.

Durada aproximada: 18 hores

## Introducció

El protocol SMB (Session Message Block) va ser desenvolupat per IBM i posteriorment modificat per Microsoft, que va crear CIFS (Common Internet File System).
Les versions actuals dels sistemes Microsoft van evolucionar el estàndard: SMB2 (Windows Vista), SMB3 (Windows 8) i la més moderna SMB 3.1.1 que es va actualitzar amb 10 i 2016 i que incorpora suport per protocol QUIC.

Samba és un implementació del protocol SMB feta per Andrew Tridgell per permetre que sistemes no Microsoft poguessin intercanviar arxius i compartir impressores amb equips Windows.

Amb Samba es pot implementar una alternativa a un servidor NT (Samba 3).
Samba 4 ja permet crear controladors de domini de Active Directory.
Samba es publica sota llicència GPL.

## Samba con servidors d'arxius

Amb Samba podem fer que un equip Linux o Mac es converteixi en servidor d’arxius d’un grup de treball Windows. De la mateixa manera, els clients Linux, podem accedir als recursos compartits tant de màquines Windows com de servidors Samba.

Per instal·lar Samba en un sistema Linux, podem utilitzar el gestor de paquets de la distribució. Per exemple, en distribucions basades en Debian/Ubuntu, podem executar:

```bash
sudo apt update
sudo apt install samba  
```

Per reiniciar el servei Samba, podem utilitzar:

```bash
sudo systemctl restart smbd
```

L’arxiu que permet configurar el servei és  `/etc/samba/smb.conf`.

```text
[global]
    workgroup = WORKGROUP
    server string = %s
    log file = /var/log/samba/log.%m
    max log size = 1000
    security = user
    map to guest = bad user

[public]
    path = /home/public
    writable = yes
    guest ok = yes

[home]
    path = /home/%S
    writable = yes
    valid users = %S
```
