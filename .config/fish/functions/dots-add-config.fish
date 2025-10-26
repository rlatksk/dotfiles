function dots-add-config
    set -l config_dirs fastfetch fish hypr kitty quickshell session wlogout
    
    if test (count $argv) -gt 0
        set config_dirs $argv
    end
    
    set -l dots_cmd "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
    
    for dir in $config_dirs
        set -l full_path "$HOME/.config/$dir"
        
        if test -e $full_path
            echo "Adding .config/$dir to dotfiles..."
            eval $dots_cmd add .config/$dir
        else
            echo "Warning: .config/$dir does not exist, skipping..."
        end
    end
    
    echo "Done! Files staged. Run 'dots status' to see changes."
end
