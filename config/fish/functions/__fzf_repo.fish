function __fzf_repo
	for i in (cat $Z_DATA); test -e (string match -r '^[^|]*' $i)/.git; and echo $i; end | awk -F '[|]' '{ printf("%s %s\n",$2,$1) }' | sort -nr \
	  | sed 's/^[0-9,.]* *//' | sed s"#$HOME#~#" | eval (__fzfcmd) | read -l sel
	and cd (echo "$sel" | sed s"#~#$HOME#")
	commandline -f repaint
end
