source "$ZDOTDIR/paths.zsh"

source "$ZDOTDIR/history.zsh"

source "$ZDOTDIR/shell_behavior.zsh"

source "$ZDOTDIR/completion.zsh"

source "$ZDOTDIR/fzf.zsh"

source "$ZDOTDIR/zoxide.zsh"

source "$ZDOTDIR/aliases.zsh"

source "$ZDOTDIR/bindings.zsh"

source "$ZDOTDIR/git_commands.zsh"

source "$ZDOTDIR/file_manager.zsh"

source "$ZDOTDIR/commands.zsh"

source "$ZDOTDIR/plugins.zsh" # just defines functions, no side effects

load_autosuggestions_plugin # 1st: autosuggest wraps base widgets

load_history_plugin # 2nd: history-search adds widgets

source "$ZDOTDIR/prompt.zsh" # 3rd: Pure wraps on top

load_syntax_plugin # 4th: fsh, absolute last


# bun completions
[ -s "/Users/ozan/.bun/_bun" ] && source "/Users/ozan/.bun/_bun"
