alias ls="eza --icons -w 1"
alias ll="eza -lh --icons --git"
alias lsa="eza -lah --icons --git"
# Reuse ls completions for eza (avoids defining a separate completion function)
compdef eza=ls

alias cl="clear"

alias md="mkdir"

alias v="nvim"
alias nv="nvim"

alias src="source $ZDOTDIR/.zshrc"

alias ai="ollama run llama3.2"

alias cool="fastfetch"

alias cowsay="cowsay -r"

alias sshk="kitty +kitten ssh"

alias lf="lfcd"
alias ranger="rangercd"

alias myip="ipconfig getifaddr en0"

alias grep="rg --color=auto"
alias diff="diff --color=auto"
alias df="df -h"

alias dev="bun run dev"
alias pn="pnpm"
