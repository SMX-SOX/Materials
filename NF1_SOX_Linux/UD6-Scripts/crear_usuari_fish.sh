#!/usr/bin/env fish
#
# crear_usuari_fish.sh
#
# Script que mostra el nom del sistema i la data/hora actual,
# demana un nom d'usuari i una contrasenya, i crea l'usuari
# corresponent al sistema.
#
# Ús: sudo fish ./crear_usuari_fish.sh
#

# --- Comprovació de privilegis ---
# Fish no té la variable $EUID, cal obtenir-la amb `id -u`
set euid (id -u)
if test "$euid" -ne 0
    echo "Aquest script s'ha d'executar com a root (prova amb sudo)."
    exit 1
end

# --- Informació del sistema ---
echo "======================================"
echo " Nom del sistema : "(hostname)
echo " Data i hora      : "(date '+%d/%m/%Y %H:%M:%S')
echo "======================================"
echo

# --- Demanar el nom d'usuari ---
read -l -P "Introdueix el nom del nou usuari: " nom_usuari

# Comprovem que no hagi deixat el camp buit
if test -z "$nom_usuari"
    echo "Error: el nom d'usuari no pot estar buit."
    exit 1
end

# Comprovem que l'usuari no existeixi ja al sistema
if id "$nom_usuari" >/dev/null 2>&1
    echo "Error: l'usuari '$nom_usuari' ja existeix al sistema."
    exit 1
end

# --- Demanar la contrasenya (dues vegades, sense mostrar-la) ---
read -s -l -P "Introdueix la contrasenya: " contrasenya
echo
read -s -l -P "Confirma la contrasenya: " contrasenya_confirmacio
echo

if test "$contrasenya" != "$contrasenya_confirmacio"
    echo "Error: les contrasenyes no coincideixen."
    exit 1
end

if test -z "$contrasenya"
    echo "Error: la contrasenya no pot estar buida."
    exit 1
end

# --- Creació de l'usuari al sistema ---
# -m crea el directori personal (/home/nom_usuari)
useradd -m "$nom_usuari"

if test $status -ne 0
    echo "Error: no s'ha pogut crear l'usuari '$nom_usuari'."
    exit 1
end

# Assignem la contrasenya a l'usuari creat
echo "$nom_usuari:$contrasenya" | chpasswd

if test $status -eq 0
    echo
    echo "Usuari '$nom_usuari' creat correctament el "(date '+%d/%m/%Y %H:%M:%S')" a "(hostname)"."
else
    echo "Error: l'usuari s'ha creat però no s'ha pogut establir la contrasenya."
    exit 1
end
