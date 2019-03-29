function v
	grep '^>' ~/.viminfo | cut -c3- | grep -v ".git/COMMIT_EDITMSG" | while read line
        [ -f (echo $line | sed s"#~#$HOME#") ]
        and echo "$line"
    end | __fzfcmd -d -m -1 -q "$argv[1]" | read -l sel
    and vim (echo $sel | sed s"#~#$HOME#")
end
