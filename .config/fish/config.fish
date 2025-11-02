function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive
    # No greeting
    set fish_greeting

    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases from bashrc
    alias ls 'eza --icons'
    alias grep 'grep --color=auto'
    alias pamcan pacman
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'
    alias dots '/usr/bin/git --git-dir=/home/tlsfbwls/.dotfiles --work-tree=/home/tlsfbwls'
    
end

# Environment variables from bashrc
set -gx GOPATH $HOME/.go
fish_add_path $GOPATH/bin

fish_add_path ~/.local/bin/droid

zoxide init fish | source

source /usr/share/fish/vendor_completions.d/asdf.fish
