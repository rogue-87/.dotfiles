# Thank you Elijah Manor <3

# alias vim="NVIM_APPNAME=vim nvim"
alias virk="NVIM_APPNAME=virk nvim"

function vims() {
    items=("nvim" "virk")
    config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config >> " --height=~50% --layout=reverse --border --exit-0)
    if [[ -z config ]]; then
        echo "Nothing selected"
        return 0
    elif [[ $config == "nvim" ]]; then
        config=""
    fi
    NVIM_APPNAME=$config nvim $@
}
