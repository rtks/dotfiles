function __git_fixup_commits
  set -l cnt
  for msg in (command git log --pretty=tformat:"%h\t%s" -n20)
    printf "%02d-$msg\n" (count $cnt)
    set cnt $cnt 1
  end
end
complete -f -c git-fixup -a '(__git_fixup_commits)'
