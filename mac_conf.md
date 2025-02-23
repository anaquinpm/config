# Mac configuration's

## Bash configuration

```sh
chsh -s /bin/bash   # change default shell
# add bashrc file configurations to ~/.bash_profile

## Install bashh with brew
brew install bash
sudo sh -c 'echo /opt/homebrew/bin/bash >> /etc/shells'
cat /etc/shells      # Check the whole shell list
chsh -s /opt/homebrew/bin/bash
```


## Visual studio Code

```bash
cat << EOF >> ~/.bash_profile
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF
```

## General commands

```bash
NetworkQuality -s
caffeinate [-t <seconds>] [-s|-d|-m] # sleep mode temporarily off
pmset -g    # get general power configuration
  sudo pmset -a disablesleep 1
```
