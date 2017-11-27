function git-rev
    set MAX_LOG_COUNT 30
    
    set commits (git log --oneline -n "$MAX_LOG_COUNT")
    set ret $status
    
    if [ "$ret" != 0 ]
        set headline (echo "$commits" | head -n1)
        if [ "$headline" = "No staged changes. Use git add -p to add them." ]
            echo "$headline" >&2
        end
        return "$ret"
    end
    
    for i in $commits; echo $i; end | fzf-tmux | awk '{ print $1 }' | read -l line
    [ "$status" = 0 -a "$line" != "" ]; or return "$status"
    commandline -i "$line"
    commandline -f repaint
end
