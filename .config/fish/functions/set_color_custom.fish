function set_color_custom
    if [ "$argv[1]" = dark ]
        touch ~/.config/dark-mode
    else if [ "$argv[1]" = light ]
        rm ~/.config/dark-mode 2>/dev/null
    end
    if [ -f ~/.config/dark-mode ]
        set -U fish_color_autosuggestion    'brblack'
        set -ug TMUX_COLOR_FG colour0
        set -ug TMUX_COLOR_BG colour7
    else
	    set -U fish_color_autosuggestion    'brcyan'
        set -ug TMUX_COLOR_FG colour7
        set -ug TMUX_COLOR_BG colour0
    end

	set -U fish_color_command           'green'
	set -U fish_color_comment           '93a1a1'
	set -U fish_color_cwd               'green'
	set -U fish_color_cwd_root          'red'
	set -U fish_color_end               'blue'
	set -U fish_color_error             'brred'
	set -U fish_color_escape            'cyan'
	set -U fish_color_history_current   'cyan'
	set -U fish_color_host              'normal'
	set -U fish_color_match             'cyan'
	set -U fish_color_normal            'normal'
	set -U fish_color_operator          'cyan'
	set -U fish_color_param             'bryellow'
	set -U fish_color_quote             'cyan'
	set -U fish_color_redirection       'yellow'
	set -U fish_color_search_match      '--background=grey'
	set -U fish_color_selection         '--background=grey'
	set -U fish_color_user              'normal'
	set -U fish_color_valid_path        '--underline'
	set -U fish_pager_color_completion  'normal'
	set -U fish_pager_color_description 'yellow'
	set -U fish_pager_color_prefix      'cyan'
	set -U fish_pager_color_progress    'cyan'

    tmux source ~/.tmux.conf 2>/dev/null
    tmux source ~/.tmux.conf 2>/dev/null
end
