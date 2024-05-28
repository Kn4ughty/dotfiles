if status is-interactive
    # Commands to run in interactive sessions can go here
    alias py="python3"
    alias n="nvim"
    alias neovim="echo \"Wrong\""

    alias :q="echo \"okay if you are sure\" && sleep 1 && exit"
    alias -- "+x"="chmod +x"

    export EDITOR=/usr/bin/nvim


    export GTK_THEME=Adwaita:dark

    # fix vscodium
    export ELECTRON_OZONE_PLATFORM_HINT=wayland

end
