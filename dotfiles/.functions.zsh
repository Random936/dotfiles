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
