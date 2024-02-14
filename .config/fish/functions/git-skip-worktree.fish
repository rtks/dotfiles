function git-skip-worktree
  if test "$argv" = "no"
    git update-index --no-skip-worktree (git ls-files -v | string match -rg "^S (.*)")
  else
    git update-index --skip-worktree (git status | string match -rg '^\s(?:modified|deleted):\s*(.*)$')
  end
end
