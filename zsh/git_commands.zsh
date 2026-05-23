alias gcm="git checkout main"
alias gfp="git fetch && git pull"

function gap() {
    if [ -z "$1" ]; then
        echo "Commit message required"
        return 1
    fi

    git add .
    git commit -a -m "$1"
    git push
}
