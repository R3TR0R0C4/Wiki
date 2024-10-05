#!/bin/bash
nom_paquet="google-chrome-stable"

lock=0
#Comprovem que no hi ha cap bloqueig en apt
if [ -f /var/lib/apt/lists/lock ]; then
    rm -f /var/lib/apt/lists/lock
    rm -f /var/lib/dpkg/lock-frontend
    rm -f /var/lib/dpkg/lock
    lock=1 #Configurem comprobant a 1
fi

#Guardem les versions en variables
versio_instalada=$(dpkg -s "$nom_paquet" 2>/dev/null | awk '/Version/{print $2}')
versio_candidata=$(apt-cache policy "$nom_paquet" 2>/dev/null | awk '/Candidate/{print $2}')

if [ "$versio_instalada" = "$versio_candidata" ]; then #Comprovem si la versio instalada es igual a l
    echo "Installed version of '$nom_paquet': $versio_instalada" #Si ho és printem el nom del paquet 

elif [ "$versio_instalada" != "$versio_candidata" ]; then #Si la versió instalada no és igual a la ca
    #Echo opcional
    echo "'$nom_paquet' esta fora de versio"

    # Perform apt update and re-check package version
    apt update > /dev/null 2>&1
    apt-cache update > /dev/null 2>&1

    #Realitzem l'instal·lació del paquet
    apt install $nom_paquet #&> /dev/null 
    apt install $nom_paquet #&> /dev/null 

    #Comprobem si el lock de apt estava present
    if [ $lock == 1 ]; then
        #En cas que estés present, arreglem l'instal·lació trencada
        apt update --fix-missing --quiet &> /dev/null
        apt --fix-broken install &> /dev/null
    fi
else
    echo "'$nom_paquet' no instal·lat"
fi
