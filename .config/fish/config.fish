if status is-interactive
    # Commands to run in interactive sessions can go here
    alias lsa="ls -la"
    alias py="python3"
    alias n="nvim"
    # alias l="lvim"
    alias lg="lazygit" 
    alias zed="flatpak run dev.zed.Zed"
    alias "icat"="kitten icat"
    alias neovim="echo \"Wrong\""

    alias :q="echo \"okay if you are sure\" && sleep 1 && exit"
    alias abcdefghijklmnopqrstuvwxyz="calcurse"

    alias doitnow="sudo fish -c \$history[1]"

    alias -- "+x"="chmod +x"

    export EDITOR=nvim


    export GTK_THEME=Adwaita:dark
    export XCURSOR_THEME=Bibata-Modern-Classic
    export XCURSOR_SIZE=24
    # fix vscodium
    export ELECTRON_OZONE_PLATFORM_HINT=wayland
    export QT_QPA_PLATFORMTHEME=qt5ct
    export QT_QPA_PLATFORM=wayland
    # export XDG_CURRENT_DESKTOP=sway
    export XDG_DATA_HOME=$HOME/.local/share/
    
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export MOZC_IBUS_CANDIDATE_WINDOW=ibus
    export HOSTNAME=$(hostname)
    export WINIT_X11_SCALE_FACTOR=1.0

    # export PATH=$PATH:/home/d/.cargo/bin
    #
    # fish_add_path /home/d/.cargo/bin
    fish_add_path /home/d/bin/
    fish_add_path /home/d/.local/share/gem/ruby/3.2.0/bin

    set --universal pure_show_subsecond_command_duration true
    set --universal pure_threshold_command_duration 1
    set --universal pure_reverse_prompt_symbol_in_vimode true
    # source "$HOME/.cargo/env.fish"
    # pyenv init - | source


    function howbig
        ls -lah $(which $argv[1])
    end

    # =============================================================================
    #
    # Utility functions for zoxide.
    #
    
    # pwd based on the value of _ZO_RESOLVE_SYMLINKS.
        function __zoxide_pwd
            builtin pwd -L
        end
    
    # A copy of fish's internal cd function. This makes it possible to use
    # `alias cd=z` without causing an infinite loop.
        if ! builtin functions --query __zoxide_cd_internal
            string replace --regex -- '^function cd\s' 'function __zoxide_cd_internal ' <$__fish_data_dir/functions/cd.fish | source
        end
    
    # cd + custom logic based on the value of _ZO_ECHO.
        function __zoxide_cd
            if set -q __zoxide_loop
                builtin echo "zoxide: infinite loop detected"
                builtin echo "Avoid aliasing `cd` to `z` directly, use `zoxide init --cmd=cd fish` instead"
                return 1
            end
            __zoxide_loop=1 __zoxide_cd_internal $argv
        end
    
    # =============================================================================
    #
    # Hook configuration for zoxide.
    #
    
    # Initialize hook to add new entries to the database.
        function __zoxide_hook --on-variable PWD
            test -z "$fish_private_mode"
            and command zoxide add -- (__zoxide_pwd)
        end
    
    # =============================================================================
    #
    # When using zoxide with --no-cmd, alias these internal functions as desired.
    #
    
    # Jump to a directory using only keywords.
        function __zoxide_z
            set -l argc (builtin count $argv)
            if test $argc -eq 0
                __zoxide_cd $HOME
            else if test "$argv" = -
                __zoxide_cd -
            else if test $argc -eq 1 -a -d $argv[1]
                __zoxide_cd $argv[1]
            else if test $argc -eq 2 -a $argv[1] = --
                __zoxide_cd -- $argv[2]
            else
                set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
                and __zoxide_cd $result
            end
        end
    
    # Completions.
        function __zoxide_z_complete
            set -l tokens (builtin commandline --current-process --tokenize)
            set -l curr_tokens (builtin commandline --cut-at-cursor --current-process --tokenize)
    
            if test (builtin count $tokens) -le 2 -a (builtin count $curr_tokens) -eq 1
                # If there are < 2 arguments, use `cd` completions.
                complete --do-complete "'' "(builtin commandline --cut-at-cursor --current-token) | string match --regex -- '.*/$'
            else if test (builtin count $tokens) -eq (builtin count $curr_tokens)
                # If the last argument is empty, use interactive selection.
                set -l query $tokens[2..-1]
                set -l result (command zoxide query --exclude (__zoxide_pwd) --interactive -- $query)
                and __zoxide_cd $result
                and builtin commandline --function cancel-commandline repaint
            end
        end
        complete --command __zoxide_z --no-files --arguments '(__zoxide_z_complete)'
    
    # Jump to a directory using interactive search.
        function __zoxide_zi
            set -l result (command zoxide query --interactive -- $argv)
            and __zoxide_cd $result
        end
    
    # =============================================================================
    #
    # Commands for zoxide. Disable these using --no-cmd.
    #
    
        abbr --erase z &>/dev/null
        alias z=__zoxide_z
    
        abbr --erase zi &>/dev/null
        alias zi=__zoxide_zi
    
    # =============================================================================
    #
    # To initialize zoxide, add this to your configuration (usually
    # ~/.config/fish/config.fish):
    #
    #   zoxide init fish | source
end

