function dots-add-config
    set -l config_file "$HOME/.config/fish/dots_config_dirs.txt"
    
    # Initialize default directories if file doesn't exist
    if not test -f $config_file
        printf "fastfetch\nfish\nhypr\nkitty\nquickshell\nsession\nwlogout\n" > $config_file
    end
    
    # Read saved directories
    set -l config_dirs (cat $config_file)
    
    # If arguments provided, add new directories to the list
    if test (count $argv) -gt 0
        for dir in $argv
            if not contains $dir $config_dirs
                echo $dir >> $config_file
                set config_dirs $config_dirs $dir
                echo "Added $dir to default directories list."
            end
        end
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
