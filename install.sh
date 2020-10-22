#!/bin/bash

# Script para instalar y configurar programas en un OS recién instalado según las preferencias que tengamos.
#
# Author: Pablo Martín Anaquín
# Date: 10-09-2020
# Use: sudo ./install.sh

isRoot(){
    if [ "$EUID" -ne 0 ]; then
        return 1
    fi
}

checkRoot(){
    if ! isRoot; then
        echo "Ejecuta el programa como root"
        exit 1
    fi
}

isVMware(){
    VIRT=`lscpu | awk '/VMware$/{print $NF}'`
    if [[ $VIRT != "VMware" ]]; then
        echo "No es una VM de VMware"
        return 1
    else
        echo "Instalando VM-Tools"
        tools="install open-vm-tools -y"
        case $1 in
            pop|ubuntu)
                apt $tools
                ;;
            fedora)
                dnf $tools
                ;;
            centos)
              yum $tools
                ;;
    esac
    fi
}

checkOS(){
    if [[ -e /etc/debian_version ]]; then
        OS="debian"
        PROGRAMS="vim htop terminator neofetch"
        POP_PROG="gparted gnome-shell-pomodoro gnome-tweaks remmina transmission vlc simplescreenrecorder build-essential manpages-es manpages-es-extra manpages-dev manpages-posix manpages-posix-dev"
        source /etc/os-release
        if [[ $ID == "pop" || $ID == "ubuntu" ]]; then
            apt update && apt full-upgrade
            apt install $PROGRAMS
            if [[ $ID == "pop" ]]; then
                apt install $POP_PROG
            fi
            isVMware $ID
            exit 1
        fi
    elif [[ -e /etc/system-release ]]; then
        source /etc/os-release
        if [[ $ID == "fedora" ]]; then
            OS="fedora"
            dnf udpate -y
            isVMware $ID
            exit 1
        fi
        if [[ $ID == "centos" ]]; then
            OS="centos"
            yum check-update
            isVMware $ID
            exit 1
        fi

    else
        echo "Parece que no estas corriendo Pop_OS, Ubuntu, Fedora o CentOS"
        exit 1
    fi
}

menu(){
    echo "¿Que quieres hacer?"
    echo "  1) Actualizar sistema e instalar aplicaciones"
    echo "  2) Configurar bash"
    echo "  3) Configurar vim"
    echo "  4) Exit"
    until [[ $OPTION =~ ^[1-5]$ ]]; do
        read -rp "Elige una opción del [1-4]: " OPTION
    done

    case $OPTION in
        1)  echo "Instalando programas en OS"
            checkOS
            ;;
        2)
            ;;
        3)
            ;;
        4)
            exit 0
            ;;
    esac
}

checkRoot
menu
