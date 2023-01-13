function activate
	if test -f "$argv[1]/bin/activate.fish"
		command fish --login --init-command="source '$argv[1]/bin/activate.fish'"
	else if test -f "$HOME/.envs/$argv[1]/bin/activate.fish"
		command fish --login --init-command="source '$HOME/.envs/$argv[1]/bin/activate.fish'"
	end
end
