bw-init() {
    bw login --check &>/dev/null || return 0
    bw sync &>/dev/null || return 0

    bw unlock --raw > $HOME/.bw_session
}

bw-load() {
    export BW_SESSION=$(cat $HOME/.bw_session)
}
