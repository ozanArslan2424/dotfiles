# ---------- XDG base directories ----------
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# ---------- Editor ----------
export EDITOR="nvim"
export VISUAL="nvim"

# ---------- Telemetry opt-outs ----------
export RAILWAY_NO_TELEMETRY=1
export DO_NOT_TRACK=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ANALYTICS=1

# ---------- Tool config locations ----------
export KITTY_CACHE_DIR="$HOME/.cache/kitty"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export FLYCTL_INSTALL="$HOME/.fly"
export PNPM_HOME="$HOME/Library/pnpm"
export CHROME_EXECUTABLE="/Applications/Helium.app/Contents/MacOS/Helium"

# ---------- Build flags ----------
export LDFLAGS="-L/opt/homebrew/opt/node@22/lib"
export CPPFLAGS="-I/opt/homebrew/opt/node@22/include"

# ---------- Pager ----------
if command -v bat >/dev/null 2>&1; then
    export MANPAGER="bat -l man -p"
elif command -v batcat >/dev/null 2>&1; then
    export MANPAGER="batcat -l man -p"
fi
