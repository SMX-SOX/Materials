# UD6. Gestió de servidors mitjançant scripts

RA 5. Realitza tasques de monitorització i ús del sistema operatiu en xarxa, descrivint les eines utilitzades i identificant-ne les principals incidències

Durada prevista: 12 hores

## Introducció

Un dels reptes de l'administració de sistemes actualment és necessitat d'automatitzar tasques repetitives i gestionar múltiples servidors de manera eficient. Amb l'aparició de la cultura `devops` cal poder desplegar els entorns de manera ràpida i de la forma més desatesa possible.

Això ha portat l'aparició de solucions com `Infrastructure as Code` (IaC) que permeten definir la infraestructura com a codi i automatitzar el seu desplegament, eines d'automatització com `Ansible`, `Puppet` o `Chef` i l'ús de scripts per automatitzar les comandes i accions a realitar.

I què és un script? Un script és un fitxer de text que conté una sèrie d'instruccions que poden ser executades per un intèrpret de comandes. Els scripts permeten automatitzar tasques repetitives, com ara la instal·lació de programari, la configuració de sistemes o la gestió de serveis.

## Llenguatge de programació dels scripts

### Bash

Bash (Bourne Again SHell) és un intèrpret de comandes i un llenguatge de programació de scripts que s'utilitza àmpliament en sistemes operatius Unix i Linux. Bash és una millora del shell original `sh` i ofereix moltes característiques addicionals, com ara variables, estructures de control, funcions i suport per a scripts més complexos. És el shell per defecte de moltes distribucions de Linux, com Ubuntu, Debian, etc. I té una gran quantitat scripts ja escrits i disponibles a Internet, el que facilita la reutilització de codi i l'aprenentatge de noves tècniques.

En aquesta unitat hi treballarem amb `Bash` per ser encara avui dia el shell per ser el més compatible amb la majoria de sistemes Linux i Unix, i per la seva simplicitat i facilitat d'ús.

Un exemple d'script en Bash és el següent, el tenim a l'arxiu `crear_usuari_bash.sh` en aquesta mateixa carpeta.

Tot i que `bash` des de fa temps ha estat el shell per defecte a la majoria de distribucions Linux, va aparèixer com a millora de la inicial `sh`, hi ha altres shells que ofereixen característiques addicionals i poden ser més adequats segons les necessitats de l'usuari. Alguns exemples són:

### zsh

És un shell molt potent i flexible que ofereix moltes característiques avançades, com ara autocompletat intel·ligent, historial de comandes millorada, suport per a temes i plugins, entre altres. És molt popular entre els desenvolupadors i administradors de sistemes. Es pot trobar a Kali Linux i macOS, per exemple. Per instal·lar-lo a Ubuntu i definir-lo com a shell per defecte, podeu utilitzar la comanda:

   ```bash
   sudo apt install zsh
   sudo chsh -s $(which zsh)
   ```

Podeu obrir l'script `crear_usuari_zsh.sh` i comprovar les diferències respecte a l'script en Bash.

### Fish Shell

És un shell modern i amigable que ofereix una experiència d'usuari millorada amb autocompletat automàtic, suggeriments de comandes i una sintaxi més clara. És molt fàcil d'utilitzar i configurar, i és ideal per a usuaris que busquen una experiència de línia de comandes més agradable. A més, té una sintaxi més clara per desenvolupar scripts. Té com inconvenient que no és **estàndard POSIX**, el que vol dir que no garantitza la compatibilitat amb scripts d'altres shells. Per usar-lo a Ubuntu, podeu utilitzar la comanda:

   ```bash
   sudo apt install fish
   sudo chsh -s $(which fish)
   ```

A l'arxiu `crear_usuari_fish.sh` podeu veure la versió de l'script en aquest shell.

### Altres llenguatges de programació per a scripts

Tot i que els shells han anat guanyant funcionalitats, hi ha altres llenguatges de programació que permeten desenvolupar scripts més complexos i amb més funcionalitats. Alguns exemples són:

- **Python**: Durant molt de temps, Python ha estat un llenguatge de programació molt popular per a l'automatització de tasques i la creació d'scripts. És un llenguatge interpretat, amb una sintaxi clara i llegible, i ofereix una gran quantitat de biblioteques i mòduls que faciliten la realització de tasques complexes. A més, és multiplataforma i es pot utilitzar en diferents sistemes operatius.

- **Rust**: Rust és un llenguatge de programació de sistemes que ofereix seguretat de memòria i concurrència sense comprometre el rendiment. Tot i que no és tan popular com Python per a l'automatització, Rust està guanyant popularitat per a la creació d'scripts i eines de línia de comandes gràcies a la seva eficiència i seguretat. Permet obtenir scripts que s'executen més ràpidament que els seus equivalents en Python.

- **Go**: Go és un llenguatge de programació desenvolupat per Google que ofereix un rendiment elevat i una sintaxi senzilla. Tot i que no té la popularitat de Python o Rust, és un llenguatge que ofereix un gran rendiment.

- **Perl**: Perl és un llenguatge de programació interpretat que ha estat utilitzat durant molt de temps per a l'automatització de tasques i la creació d'scripts. Tot i que ha perdut popularitat en els darrers anys, encara és utilitzat en alguns entorns i projectes.

També hi ha altres llenguatges de programació que es poden utilitzar per a l'automatització de tasques i la creació d'scripts, com ara Ruby, C, Lua, o fins i tot #C, entre altres. La tria del llenguatge dependrà de les necessitats del projecte i de les preferències de l'usuari.

## Materials propis de l'assignatura

- [Guia per a la creació d'scripts en Bash](https://github.com/carlesalonso/IntroScripting)

- [ZSH: The Z Shell](https://zsh.sourceforge.io/)

- [Fish: A friendly interactive shell](https://fishshell.com/)
