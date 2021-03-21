# Configuring my linux OS
## Bash
[link to bashrc](bashrc)

## Vim
Configuraciones para `/etc/vim/vimrc` de las cuales se pueden copiar las que se necesiten en el `~/.vimrc` de cada usuario -> [vimrc](vimrc)

Opciones de `vimrc` para verificar si se encuentra instalado Vim-Plug y agregar lista de plug-ins -> [vimrcHome](vimrcHome)

## Install and configuration script for Linux. 
[install.sh](install.sh)

El script tiene 4 opcines para configurar un sistema Linux:
 - Actualizar sistema e instalar aplicaciones: 
    * Verifica si el sistema es una VM para instalar open-vm-tools
        * Soporta deribados Debian/CentOs/fedora
    * Instala lista de programas definidas en el script 
        * Terminado para derivados de debian
        * Centos y fedora en progreso o pueden modificar el script �
 - Configurar bash
    * Copia el archivo `bash` a `~/.bashrc`
 - Configurar vim
    * Copia el archivo `vimrc` a `~/.vimrc`

## Copy ssh keys to many hosts
[ssh-copy.sh file](ssh-copy.sh)

```
HOST_FILE="$PWD/hosts"                    # one host per line
Use:
    $ ./ssh-copy.sh ~/.ssh/id_rsa.pub
```

## Git configurations
[gitconfig file](gitconfig)
