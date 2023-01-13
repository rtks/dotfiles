function __fzf_git_rev
    set MAX_LOG_COUNT 100
    
    set commits (git log --oneline --decorate --color --graph -n "$MAX_LOG_COUNT" --all)
    set ret $status
    
    if [ "$ret" != 0 ]
        set headline (echo "$commits" | head -n1)
        if [ "$headline" = "No staged changes. Use git add -p to add them." ]
            echo "$headline" >&2
        end
        return "$ret"
    end
    
    for i in $commits; echo $i; end | fzf-tmux --preview 'git show --color $(echo {} | grep -o "[0-9a-f]\{7,40\}")' | grep -o "[0-9a-f]\{7,40\}"| read -l line
    [ "$status" = 0 -a "$line" != "" ]; or return "$status"
    commandline -i "$line"
    commandline -f repaint
end
