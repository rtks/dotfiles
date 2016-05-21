function __fzf_z
	cat ~/.z | awk -F '[|]' '{ printf("%s %s\n",$2,$1) }' | sort -nr \
	  | sed 's/^[0-9,.]* *//' | sed s"#$HOME#~#" | __fzfcmd | read -l sel
	and cd (echo "$sel" | sed s"#~#$HOME#")
	commandline -f repaint
end
