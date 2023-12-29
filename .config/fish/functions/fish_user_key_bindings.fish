function fish_user_key_bindings
  bind \cq '__fzf_z'
  bind \eg '_fzf_search_git_log'

  if ! test "$fish_key_bindings" = fish_default_key_bindings
    bind -M insert \cq '__fzf_z'
    bind -M insert \eg '_fzf_search_git_log'
  end

  bind \cd 'delete-or-deactivate-or-exit'
end
