fpath=(/opt/homebrew/share/zsh/site-functions $fpath)

autoload -Uz compinit

zcompdump="$XDG_CACHE_HOME/zsh/zcompdump"

if [[ -n "$zcompdump"(#qN.mh-24) ]]; then
    # Fresh dump exists (modified within last 24h) — fast path
    compinit -C -d "$zcompdump"
else
    # No dump, or stale — full init with security check
    compinit -d "$zcompdump"
fi

unset zcompdump

# Enable interactive completion menu selection
zstyle ':completion:*' menu select

# Make completion case-insensitive
# Example: "doc" can complete to "Documents"
# lowercase input matches upper and lower
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
