function fish_user_key_bindings
  if type fzf >/dev/null ^&1
    bind \cq '__fzf_z'
    bind \eg '__fzf_git_rev'
    if bind -M insert >/dev/null ^/dev/null
      bind -M insert \cq '__fzf_z'
      bind -M insert \eg '__fzf_git_rev'
    end
  end
  bind \cx '__global_alias'
  if bind -M insert >/dev/null ^/dev/null
    bind -M insert \cx '__global_alias'
  end
end
