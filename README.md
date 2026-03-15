# System Configurations and Scripts

This project contains configurations for various operating systems I use, including installation scripts, editor configurations, terminals, and command guides in Markdown format.

## Index

- [System Configurations and Scripts](#system-configurations-and-scripts)
  - [Index](#index)
  - [Scripts](#scripts)
    - [Package Installation on OS](#package-installation-on-os)
    - [SSH Keys Copy](#ssh-keys-copy)
  - [Editor Configurations](#editor-configurations)
    - [Vim](#vim)
    - [Neovim](#neovim)
    - [Tmux](#tmux)
    - [Visual Studio Code](#visual-studio-code)
  - [Terminal Configurations](#terminal-configurations)
    - [Bash](#bash)
    - [Zsh](#zsh)
    - [Git](#git)
  - [Guides and References](#guides-and-references)
    - [Mac Configuration](#mac-configuration)
    - [WSL/Powershell Commands](#wslpowershell-commands)
    - [WSL2 Configuration](#wsl2-configuration)

## Scripts

### Package Installation on OS

- [pckg_install_os.sh](pckg_install_os.sh)

The script has 4 options to configure a Linux system:

- Update system and install applications:
  - Checks if the system is a VM to install open-vm-tools
  - Supports Debian/CentOS/Fedora derivatives
  - Installs list of programs defined in the script
    - Completed for Debian derivatives
    - CentOS and Fedora in progress or you can modify the script
- Configure bash
  - Copies the `bashrc` file to `~/.bashrc`
- Configure vim
  - Copies the `vimrc` file to `~/.vimrc`

### SSH Keys Copy

- [ssh-copy.sh](ssh-copy.sh)

```bash
HOST_FILE="$PWD/hosts"                    # one IP host per line
Usage:
    $ ./ssh-copy.sh ~/.ssh/id_rsa.pub
```

## Editor Configurations

### Vim

> ln -s /REPO/PATH/editor/vimrc ~/.vimrc

- [vimrc](editor/vimrc)
- [Snippets](editor/snippets/)

### Neovim

- [nvim_init.lua](editor/nvim_init.lua)

### Tmux

- [tmux.conf](editor/tmux.conf)

### Visual Studio Code

```bash
code --list-extensions > <extensions_file.txt>
code --install-extension <extension_name>
```

- [Extensions list](editor/code-list-extensions.md)
- [Settings](editor/vscsettings.json)
- [Keybindings](editor/vsCodeKeybindings.json)

## Terminal Configurations

### Bash

(Compatible with Linux and Mac)

- [bashrc](terminal/bashrc)
- [bash_aliases](terminal/bash_aliases)

### Zsh

(Mac only)

- [zshrc](terminal/zshrc)

### Git

> ln -s ~/dev/config/terminal/gitconfig ~/.gitconfig

- [gitconfig](terminal/gitconfig)

## Guides and References

### Mac Configuration

- [Mac terminal configuration](terminal/mac_conf_terminal.md)

### WSL/Powershell Commands

- [wsl_commands.md](wsl_commands.md)

### WSL2 Configuration

1. Stop WSL: `wsl --shutdown`
2. Copy [.wslconfig](.wslconfig) to the path `C:\Users\<UserName>\.wslconfig`
