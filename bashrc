# ==============================
# ~/.bashrc — Portable & Clean
# ==============================

# --- Interactive shell only ---
[[ $- != *i* ]] && return

# --- macOS fix: allow Ctrl-S ---
command -v stty >/dev/null && stty -ixon 2>/dev/null

# --- History behavior ---
HISTCONTROL=ignoreboth:erasedups   # no duplicates / no leading space
HISTSIZE=2000                     # in-memory history
HISTFILESIZE=4000                 # on-disk history
HISTIGNORE="pwd:ls:ll:clear:history:exit"
shopt -s histappend               # append, don't overwrite
shopt -s checkwinsize             # auto resize terminal

# --- Better globbing (safe everywhere) ---
shopt -s globstar 2>/dev/null     # ** recursive glob (if supported)

# --- less improvements (Linux only if exists) ---
command -v lesspipe >/dev/null && eval "$(SHELL=/bin/sh lesspipe)"

# --- Detect OS ---
OS="$(uname -s)"

# ==============================
# Prompt
# ==============================

# --- Fast git branch detection ---
git_branch() {
  git rev-parse --is-inside-work-tree &>/dev/null || return
  git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null
}

# --- Colors (if supported) ---
if [[ "$TERM" == *color* || "$TERM" == *256color* ]]; then
  PS1='\[\e[36m\]\u@\h\[\e[0m\]:\[\e[32m\]\W\[\e[0m\]\[\e[31m\]$(git_branch 2>/dev/null | sed "s/.*/ [&]/")\[\e[0m\]\$ '
else
  PS1='\u@\h:\W\$ '
fi

# --- Xterm title ---
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
  ;;
esac

# ==============================
# Colors & Aliases
# ==============================

# --- ls colors (Linux vs macOS) ---
if ls --color -d . &>/dev/null; then
  alias ls='ls --color=auto'
else
  alias ls='ls -G'
fi

alias ll='ls -lh'
alias la='ls -lha'
alias grep='grep --color=auto 2>/dev/null'

# ==============================
# Completion
# ==============================

# --- Linux bash-completion ---
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
  . /etc/bash_completion
fi

# --- macOS (Homebrew) ---
if [[ -n "$HOMEBREW_PREFIX" && -f "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]]; then
  . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
fi

# ==============================
# Optional Tools (safe load)
# ==============================

# kubectl completion
if command -v kubectl >/dev/null; then
  source <(kubectl completion bash 2>/dev/null)
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"

# ==============================
# PATH additions
# ==============================

[[ -d "$HOME/.console-ninja/.bin" ]] && PATH="$HOME/.console-ninja/.bin:$PATH"

export PATH

