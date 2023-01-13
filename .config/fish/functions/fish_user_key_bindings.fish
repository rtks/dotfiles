function fish_user_key_bindings
  bind \ct '__fzf_find_file'
  bind \er '__fzf_reverse_isearch'
  bind \ec '__fzf_cd'
  bind \eC '__fzf_cd --hidden'
  bind \cg '__fzf_open'
  bind \co '__fzf_open --editor'

  bind \cq '__fzf_z'
  bind \eq '__fzf_repo'
  bind \eg '__fzf_git_rev'

  if ! test "$fish_key_bindings" = fish_default_key_bindings
    bind -M insert \ct '__fzf_find_file'
    bind -M insert \er '__fzf_reverse_isearch'
    bind -M insert \ec '__fzf_cd'
    bind -M insert \eC '__fzf_cd --hidden'
    bind -M insert \cg '__fzf_open'
    bind -M insert \co '__fzf_open --editor'

    bind -M insert \cq '__fzf_z'
    bind -M insert \eq '__fzf_repo'
    bind -M insert \eg '__fzf_git_rev'
  end
end
