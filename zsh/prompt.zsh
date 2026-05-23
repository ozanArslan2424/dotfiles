# Prevent Python virtualenv from polluting the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

PURE_DIR="$ZPLUGINDIR/pure"
ASYNC_DIR="$ZPLUGINDIR/zsh-async"

# Clone if missing
[[ -d "$PURE_DIR" ]] || git clone --depth=1 https://github.com/sindresorhus/pure "$PURE_DIR"
[[ -d "$ASYNC_DIR" ]] || git clone --depth=1 https://github.com/mafredri/zsh-async "$ASYNC_DIR"

fpath+=("$PURE_DIR" "$ASYNC_DIR")

autoload -Uz async

async

autoload -Uz promptinit

promptinit

PURE_PROMPT_SYMBOL='❯'
PURE_PROMPT_VICMD_SYMBOL='❮'
PURE_CMD_MAX_EXEC_TIME=2
zstyle :prompt:pure:path color cyan
zstyle :prompt:pure:git:branch color 242
zstyle :prompt:pure:prompt:success color green
zstyle :prompt:pure:prompt:error color red

prompt pure

if [[ -n "$KITTY_INSTALLATION_DIR" ]]; then
    autoload -Uz -- "$KITTY_INSTALLATION_DIR/shell-integration/zsh/kitty-integration"
    kitty-integration
    unfunction kitty-integration
fi
