alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias g='git'
alias nmd='touch $(date +%Y%m%d%H%M%S).md'
## K7s aliases
alias k='kubectl'
alias kgt='kubectl get'
alias kdb='kubectl describe'
alias kl='kubectl logs'
alias ke='kubectl exec -it'
alias kap='kubectl apply -f'
alias kad='kubectl delete -f'
alias kbb='kubectl run busybox-test --image=busybox -it --rm --restart=Never --'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 9; alert
alias alert='notify-send --urgency=low -i "$([ $? = -1 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
