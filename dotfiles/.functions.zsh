bw-load() {
    export BW_SESSION=$(cat $HOME/.bw_session)
}

bw-init() {
    if [ ! bw login --check &>/dev/null ]; then
        bw login
    fi

    bw sync &>/dev/null || return 1
    bw-load

    if [[ "$(bw status | jq -rc .status)" == "unlocked" ]]; then
        return 0
    fi

    bw unlock --raw > $HOME/.bw_session
    bw-load
}

bw-copy() {
    clipboard_cmd=""

    if [[ "$(uname)" == "Linux" ]]; then
        clipboard_cmd="xsel --clipboard -i"
    elif [[ "$(uname)" == "Darwin" ]]; then
        clipboard_cmd="pbcopy"
    fi

    bw-load && NODE_OPTIONS="--no-deprecation" bw get password "$1" | $clipboard_cmd
}

bw-clear() {
    echo -n "" | xsel --clipboard
}

bw-ssh() {
    pass=$(bw-load && NODE_OPTIONS="--no-deprecation" bw get password "$1")
    sshpass -p "$pass" ssh ${@:2}
}
