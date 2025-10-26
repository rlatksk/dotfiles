function dots-push
    set -l commit_msg "dotfiles update"
    
    if test (count $argv) -gt 0
        set commit_msg "$argv"
    end
    
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit -m "$commit_msg"
    
    if test $status -eq 0
        echo "Pushing to remote..."
        git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push
        echo "Done!"
    else
        echo "Commit failed. Please check the error above."
    end
end
