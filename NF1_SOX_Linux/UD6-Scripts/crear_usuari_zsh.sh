#!/usr/bin/env zsh
#
# crear_usuari_zsh.sh
#
# Script que mostra el nom del sistema i la data/hora actual,
# demana un nom d'usuari i una contrasenya, i crea l'usuari
# corresponent al sistema.
#
# Ús: sudo ./crear_usuari_zsh.sh
#

# --- Comprovació de privilegis ---
# Crear usuaris requereix privilegis d'administrador (root)
if [[ "$EUID" -ne 0 ]]; then
    print "Aquest script s'ha d'executar com a root (prova amb sudo)."
    exit 1
fi

# --- Informació del sistema ---
print "======================================"
print " Nom del sistema : $(hostname)"
print " Data i hora      : $(date '+%d/%m/%Y %H:%M:%S')"
print "======================================"
print

# --- Demanar el nom d'usuari ---
read "nom_usuari?Introdueix el nom del nou usuari: "

# Comprovem que no hagi deixat el camp buit
if [[ -z "$nom_usuari" ]]; then
    print "Error: el nom d'usuari no pot estar buit."
    exit 1
fi

# Comprovem que l'usuari no existeixi ja al sistema
if id "$nom_usuari" &>/dev/null; then
    print "Error: l'usuari '$nom_usuari' ja existeix al sistema."
    exit 1
fi

# --- Demanar la contrasenya (dues vegades, sense mostrar-la) ---
read -s "contrasenya?Introdueix la contrasenya: "
print
read -s "contrasenya_confirmacio?Confirma la contrasenya: "
print

if [[ "$contrasenya" != "$contrasenya_confirmacio" ]]; then
    print "Error: les contrasenyes no coincideixen."
    exit 1
fi

if [[ -z "$contrasenya" ]]; then
    print "Error: la contrasenya no pot estar buida."
    exit 1
fi

# --- Creació de l'usuari al sistema ---
# -m crea el directori personal (/home/nom_usuari)
useradd -m "$nom_usuari"

if [[ $? -ne 0 ]]; then
    print "Error: no s'ha pogut crear l'usuari '$nom_usuari'."
    exit 1
fi

# Assignem la contrasenya a l'usuari creat
print "${nom_usuari}:${contrasenya}" | chpasswd

if [[ $? -eq 0 ]]; then
    print
    print "Usuari '$nom_usuari' creat correctament el $(date '+%d/%m/%Y %H:%M:%S') a $(hostname)."
else
    print "Error: l'usuari s'ha creat però no s'ha pogut establir la contrasenya."
    exit 1
fi
