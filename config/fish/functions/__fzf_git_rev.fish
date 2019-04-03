function __fzf_git_rev
	git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" --all | eval (__fzfcmd) $FZF_DEFAULT_OPT | sed 's#^[^0-9a-f]*##' | awk '{print $1}' | read -l sel
test "$sel"; and commandline -it -- $sel
commandline -f repaint
end
