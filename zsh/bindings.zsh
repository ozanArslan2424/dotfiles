bindkey -e

# Option+Left / Option+Right — word jump
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word

# Option+Backspace — delete word backward
bindkey '^[^?' backward-kill-word

# Selected text — readable inverse instead of garish defaults
zle_highlight=(region:standout special:standout isearch:standout suffix:bold paste:none)
