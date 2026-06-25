# UD6. Gestió de servidors mitjançant scripts

RA 5. Realitza tasques de monitorització i ús del sistema operatiu en xarxa, descrivint les eines utilitzades i identificant-ne les principals incidències

Durada prevista: 8 hores

## Introducció

Un dels reptes de l'administració de sistemes actualment és necessitat d'automatitzar tasques repetitives i gestionar múltiples servidors de manera eficient. Amb l'aparició de la cultura `devops` cal poder desplegar els entorns de manera ràpida i de la forma més desatesa possible.

Això ha portat l'aparició de solucions com `Infrastructure as Code` (IaC) que permeten definir la infraestructura com a codi i automatitzar el seu desplegament, eines d'automatització com `Ansible`, `Puppet` o `Chef` i l'ús de scripts per automatitzar les comandes i accions a realitar.

I què és un script? Un script és un fitxer de text que conté una sèrie d'instruccions que poden ser executades per un intèrpret de comandes. Els scripts permeten automatitzar tasques repetitives, com ara la instal·lació de programari, la configuració de sistemes o la gestió de serveis.

I amb quin llenguatge el podem escriure? El més habitual és usar el llenguatge del shell del sistema, i aquí `Bash` és el més utilitzat, però altres shells com `Zsh`, `Ksh` o `Fish` han anat guanynant popularitat. També podem escriure scripts en altres llenguatges de programació com `Python`, `Perl` o `Ruby`, que ofereixen més funcionalitats i faciliten la gestió de tasques complexes. Go (Golang) que permet compilar en un únic arxiu binari, permet executar l'script en qualsevol sistema sense necessitat de preocupar-se de dependències o versions del llenguatge.

En aquesta unitat hi treballarem amb `Bash` per ser encara avui dia el shell per ser el més compatible amb la majoria de sistemes Linux i Unix, i per la seva simplicitat i facilitat d'ús.

## Materials propis de l'assignatura

- [Guia per a la creació d'scripts en Bash](https://github.com/carlesalonso/IntroScripting)
