# Configuring my linux OS

## Bash

[link to bashrc](bashrc)

## Vim - local user configurations

> ln -s ~/cloneRepository/vimrc ~/.vimrc

- [vimrc](vimrc)

## Install and configuration script for Linux

[install.sh](install.sh)

El script tiene 4 opcines para configurar un sistema Linux:

- Actualizar sistema e instalar aplicaciones:
  - Verifica si el sistema es una VM para instalar open-vm-tools
    - Soporta deribados Debian/CentOs/fedora
  - Instala lista de programas definidas en el script
    - Terminado para derivados de debian
    - Centos y fedora en progreso o pueden modificar el script
- Configurar bash
  - Copia el archivo `bash` a `~/.bashrc`
- Configurar vim
  - Copia el archivo `vimrc` a `~/.vimrc`

## Copy ssh keys to many hosts

- [ssh-copy.sh file](ssh-copy.sh)

```bash
HOST_FILE="$PWD/hosts"                    # one IP host per line
Use:
    $ ./ssh-copy.sh ~/.ssh/id_rsa.pub
```
## [Mac Config](./mac_conf.md)

## Git configurations

> ln -s ~/cloneRepository/gitconfig ~/.gitconfig

- [gitconfig file](gitconfig)

## Visual Studio Code

```bash
code --list-extensions > <extensions_file.txt>
code --install-extension <extension_name>
```

[Extensions list to install](./code-list-extensions.md)

## WSL2 confgurations

1. Stop WSL:  "wsl --shoutdown"
2. Copy [".wslconfig"](.wslconfig) to the route "C:\Users\<UserName>\.wslconfig"

## References

- [WSL/Powershell commands](wsl.md)
