if status is-interactive
    # Commands to run in interactive sessions can go here
    alias lsa="ls -la"
    alias py="python3"
    alias n="nvim"
    alias l="lvim"
    alias lg="lazygit"
    alias zed="flatpak run dev.zed.Zed"
    alias neovim="echo \"Wrong\""

    alias :q="echo \"okay if you are sure\" && sleep 1 && exit"
    alias abcdefghijklmnopqrstuvwxyz="calcurse"

    alias -- "+x"="chmod +x"

    export EDITOR=/usr/bin/nvim


    export GTK_THEME=Adwaita:dark
    export XCURSOR_THEME=Bibata-Modern-Classic
    export XCURSOR_SIZE=24
    # fix vscodium
    export ELECTRON_OZONE_PLATFORM_HINT=wayland
    export QT_QPA_PLATFORMTHEME=qt5ct
    export QT_QPA_PLATFORM=wayland
    export XDG_CURRENT_DESKTOP=sway
    
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export MOZC_IBUS_CANDIDATE_WINDOW=ibus

    # export PATH=$PATH:/home/d/.cargo/bin
    #
    fish_add_path /home/d/.cargo/bin
    fish_add_path /home/d/bin/
    fish_add_path /home/d/.local/share/gem/ruby/3.2.0/bin

    set --universal pure_show_subsecond_command_duration true
    set --universal pure_threshold_command_duration 1
    set --universal pure_reverse_prompt_symbol_in_vimode true
    pyenv init - | source
end
