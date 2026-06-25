# NF1 - Sistemes Operatius Linux

Aquest nucli formatiu cobreix els fonaments dels sistemes operatius Linux, incloent la instal·lació, administració, gestió d'usuaris i grups, compartició de recursos, gestió avançada del sistema i scripting bàsic.

## 📚 Índex de continguts

1. [**UD1 - Instal·lació**](./UD1-Instal·lació/README.md)
   - Instal·lació i configuració inicial de sistemes Linux

2. [**UD2 - Configuració**](./UD2-Configuració/README.md)
   - Configuració bàsica del sistema operatiu Linux

3. [**UD3 - Usuaris i Grups**](./UD3-Usuaris_Grups/README.md)
   - Gestió d'usuaris, grups i permisos

4. [**UD4 - Compartició de Recursos**](./UD4_Compart_Recursos/README.md)
   - Configuració i gestió de recursos compartits

5. [**UD5 - Administració Avançada**](./UD5-Administració_Avançada/README.md)
   - Tècniques avançades d'administració del sistema

6. [**UD6 - Scripts**](./UD6-Scripts/README.md)
   - Introducció al scripting en Bash

---

## Introducció als servidors GNU/Linux

Malgrat usem Linux per referir-nos a un sistema operatiu, en realitat el que fem servir és una distribució GNU/Linux. Això vol dir que el nucli del sistema operatiu és Linux, però la resta de components (com la shell, les utilitats bàsiques i les biblioteques) originàriament provenien del projecte GNU.

Mentre que a l'escriptori la seva quota de mercat és modesta, a l'entorn de servidors i xarxes les xifres parlen per sí soles:

- El 100% de les 500 supercomputadores més potents del món executen alguna distribució de Linux. [Top500](https://top500.org).
- Més del 80% dels servidors web d'Internet funcionen sota alguna distribució de Linux.
- La immensa majoria de la infraestructura de Cloud Computing (AWS, Google Cloud, Azure) es basa en Linux.

Per què les empreses trien Linux per damunt d'altres opcions comercials? Els motius es poden resumir en cinc pilars:

- **Estabilitat i rendiment**: Un servidor Linux pot estar funcionant durant anys sense necessitat de reiniciar-se (el que anomenem uptime). A més, a l'entorn de servidor no s'instal·la interfície gràfica (GUI); tot es gestiona per línia de comandes (CLI), fet que estalvia memòria RAM i potència de processador per dedicar-los exclusivament als serveis.
- **Seguretat i robustesa**: El sistema de permisos de Linux és estricte per defecte. En no haver-hi un usuari "Administrador" actiu constantment (s'utilitza sudo només quan cal), és molt més difícil que un codi maliciós comprometi tot el sistema.
- **Cost (Codi Obert)**: La majoria de distribucions de servidor (com Ubuntu Server, Debian o Rocky Linux) són gratuïtes i lliures de llicències. Una empresa pot aixecar 100 servidors sense pagar un sol euro en llicències de sistema operatiu.
- **Flexibilitat i modularitat**: Pots agafar el codi, modificar-lo i adaptar-lo exactament a les necessitats del teu maquinari. Només s'instal·la el que es necessita.
- **Comunitat i suport**: Existeix una comunitat molt activa que ofereix suport, documentació i eines. A més, moltes empreses ofereixen serveis de suport professional per a distribucions específiques.

Tot i que existeixen altres alternatives de codi obert derivades Unix com FreeBSD, OpenBSD o NetBSD, Linux és la més estesa i la que té més suport de la comunitat. Fins i tot, GNU Linux ha superat als sistemes Unix comercials com AIX, HP-UX o Citrix, que han anat desapareixent o reduint-se a mercats molt específics.

### Distribucions

El kernel i les utilitats bàsiques constitueixen la base del sistema operatiu, però sabem que avui dia un sistema operatiu es veu acompanyat per una gran quantitat de programari auxiliar: editor de text, navegador web, gestor de fitxers, etc. La llicència oberta permet que qualsevol pugui agafar aquests elements i acompanyar-los d'altres utilitats (ja siguin bàsiques o no) segons li agradi o les seves necessitats. Així sorgeixen les distribucions de Linux o, més comunament, `distros`.

N'hi ha moltes al mercat, però per esmentar alguns dels més coneguts: "Ubuntu" (i les seves diferents "variants" com "Lubuntu", "Xubuntu", "Kubuntu", "Ubuntu Server", etc.), "Open Suse", "Arch", "Fedora", "Debian", "Red Hat", "Mint", etc.

Algunes distribucions són específiques per a servidors, com "Ubuntu Server", "Red Hat Enterprise Linux" o "Rocky Linux", ja que incorporen eines i configuracions pensades per a entorns de producció i alta disponibilitat. Altres, com "Ubuntu Desktop" o "Linux Mint", estan orientades a usuaris d'escriptori amb interfícies gràfiques amigables.

I per ser Linux són gratuïtes? Hi ha empreses que ofereixin versions comercials amb suport tècnic i serveis addicionals. Per exemple, Red Hat ofereix Red Hat Enterprise Linux (RHEL) amb subscripcions de suport, mentre que Canonical ofereix suport de pagament per empreses.

En aquest curs, la distribució que utilitzarem és **Ubuntu Server**, ja que és una de les més populars i àmpliament utilitzades en entorns professionals i que es caracteritza per no disposar d'una interfície gràfica per defecte. No tenir GUI ofereix els següents avantatges:

- **Reducció de recursos**: Sense entorn gràfic, el sistema consumeix menys memòria i CPU, permetent que més recursos estiguin disponibles per als serveis que s'executen al servidor.
- **Seguretat millorada**: Menys components instal·lats significa menys possibles vulnerabilitats. A més, la gestió per línia de comandes redueix la superfície d'atac.

Usarem la darrera versió LTS (Long Term Support) d'Ubuntu Server, la 26.04 LTS, que ofereix suport i actualitzacions de seguretat durant un període prolongat, garantint estabilitat i fiabilitat per a entorns de producció, en concret ofereix cinc anys de suport (updates) que amb la subscripció de Canonical es poden ampliar fins a 15 anys.
