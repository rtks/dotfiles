function fish_user_key_bindings
  ### fzf ###
  if type fzf >/dev/null ^&1
    bind \ct '__fzf_ctrl_t'
    bind \cr '__fzf_ctrl_r'
    bind \ec '__fzf_alt_c'
    if bind -M insert > /dev/null ^ /dev/null
      bind -M insert \ct '__fzf_ctrl_t'
      bind -M insert \cr '__fzf_ctrl_r'
      bind -M insert \ec '__fzf_alt_c'
    end
  end
  ### fzf ###
  if type fzf >/dev/null ^&1
    bind \cq '__fzf_z'
    if bind -M insert >/dev/null ^/dev/null
      bind -M insert \cq '__fzf_z'
    end
  end
  bind \cx '__global_alias'
  if bind -M insert >/dev/null ^/dev/null
    bind -M insert \cx '__global_alias'
  end
end
