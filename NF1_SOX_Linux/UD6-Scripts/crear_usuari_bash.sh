#!/bin/bash
#
# crear_usuari_bash.sh
#
# Script que mostra el nom del sistema i la data/hora actual,
# demana un nom d'usuari i una contrasenya, i crea l'usuari
# corresponent al sistema.
#
# Ús: sudo ./crear_usuari_bash.sh
#

# --- Comprovació de privilegis ---
# Crear usuaris requereix privilegis d'administrador (root)
if [[ "$EUID" -ne 0 ]]; then
    echo "Aquest script s'ha d'executar com a root (prova amb sudo)."
    exit 1
fi

# --- Informació del sistema ---
echo "======================================"
echo " Nom del sistema : $(hostname)"
echo " Data i hora      : $(date '+%d/%m/%Y %H:%M:%S')"
echo "======================================"
echo

# --- Demanar el nom d'usuari ---
read -rp "Introdueix el nom del nou usuari: " nom_usuari

# Comprovem que no hagi deixat el camp buit
if [[ -z "$nom_usuari" ]]; then
    echo "Error: el nom d'usuari no pot estar buit."
    exit 1
fi

# Comprovem que l'usuari no existeixi ja al sistema
if id "$nom_usuari" &>/dev/null; then
    echo "Error: l'usuari '$nom_usuari' ja existeix al sistema."
    exit 1
fi

# --- Demanar la contrasenya (dues vegades, sense mostrar-la) ---
read -rsp "Introdueix la contrasenya: " contrasenya
echo
read -rsp "Confirma la contrasenya: " contrasenya_confirmacio
echo

if [[ "$contrasenya" != "$contrasenya_confirmacio" ]]; then
    echo "Error: les contrasenyes no coincideixen."
    exit 1
fi

if [[ -z "$contrasenya" ]]; then
    echo "Error: la contrasenya no pot estar buida."
    exit 1
fi

# --- Creació de l'usuari al sistema ---
# -m crea el directori personal (/home/nom_usuari)
useradd -m "$nom_usuari"

if [[ $? -ne 0 ]]; then
    echo "Error: no s'ha pogut crear l'usuari '$nom_usuari'."
    exit 1
fi

# Assignem la contrasenya a l'usuari creat
echo "${nom_usuari}:${contrasenya}" | chpasswd

if [[ $? -eq 0 ]]; then
    echo
    echo "Usuari '$nom_usuari' creat correctament el $(date '+%d/%m/%Y %H:%M:%S') a $(hostname)."
else
    echo "Error: l'usuari s'ha creat però no s'ha pogut establir la contrasenya."
    exit 1
fi
