function git-fixup
    set MAX_LOG_COUNT 30
    
    if type fzf > /dev/null
        if git diff --cached --quiet
            set commits "No staged changes. Use git add -p to add them."
            set ret 1
        else
            set commits (git log --oneline -n "$MAX_LOG_COUNT")
            set ret $status
        end
        
        if [ "$ret" != 0 ]
            set headline (echo "$commits" | head -n1)
            if [ "$headline" = "No staged changes. Use git add -p to add them." ]
                echo "$headline" >&2
            end
            return "$ret"
        end
        
        for i in $commits; echo $i; end | fzf-tmux | read -l line
        [ "$status" = 0 -a "$line" != "" ]; or return "$status"
        
        git commit --fixup (echo "$line" | awk '{print $1}')
    else
        if [ (count $argv) = 0 ]
            git commit --fixup HEAD
        else
            if echo $argv[1] | grep '^[0-9]*-[a-f0-9]*$' > /dev/null
                git commit --fixup (echo $argv[1] | cut -d- -f2)
	    else
	        git commit --fixup $argv
            end
        end
    end
end
