function fish_user_key_bindings
  bind \cq '__fzf_z'
  bind \eg '_fzf_search_git_log_custom'

  if ! test "$fish_key_bindings" = fish_default_key_bindings
    bind -M insert \cq '__fzf_z'
    bind -M insert \eg '_fzf_search_git_log_custom'
  end

  bind \cd 'delete-or-deactivate-or-exit'

  # For VSCode
  bind \e\[1\;5C nextd-or-forward-word
  bind \e\[1\;5D prevd-or-backward-word
end
