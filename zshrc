# --- ENTORNO Y PATH ---
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# --- HISTORIAL ---
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=2000

# ignoreboth: no duplicados y no comandos con espacio
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# # Ignorar comandos específicos (Zsh usa variables diferentes a HISTIGNORE)
HISTORY_IGNORE="(pwd|uptime|ll|history|htop|top|ls|clear|id|exit)"

# --- OPCIONES DE SHELL ---
setopt AUTO_CD              # Escribe el nombre de una carpeta para entrar sin 'cd'
setopt NO_BEEP              # Silencio, por favor
stty -ixon                  # Deshabilitar control de flujo (XON/XOFF)

# --- PROMPT (Sencillo y con Git) ---
# Zsh tiene su propio sistema para manejar el branch de Git
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{red}[%b]%f'
setopt PROMPT_SUBST

# Configuración del Prompt: [usuario]@[host]:[carpeta][branch]$
# %n=user, %m=host, %~=path corto, %f=reset color
PROMPT='%F{cyan}%n@%m%f:%F{green}%~%f${vcs_info_msg_0_} %# '

# --- ALIAS ---
alias ls='ls -G'            # En macOS -G activa colores
alias grep='grep --color=auto'
alias k='kubectl'

# Cargar alias externos si existen
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# --- COMPLETADO ---
autoload -Uz compinit && compinit
# Autocompletado de kubectl para Zsh
if [ $((which kubectl) > /dev/null 2>&1) ]; then
    source <(kubectl completion zsh)
fi

# --- NVM (Si lo usas) ---
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
