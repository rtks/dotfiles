function __fzf_z
	cat $Z_DATA | awk -F '[|]' '{ printf("%s %s\n",$2,$1) }' | sort -nr \
	  | sed 's/^[0-9,.]* *//' | sed s"#$HOME#~#" | fzf | read -l sel
	and cd (echo "$sel" | sed s"#~#$HOME#")
	commandline -f repaint
end
