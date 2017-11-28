function __git_fixup_commits
  for i in (command git log --pretty=tformat:"%h\t%s" -n20 | awk '{printf("%02d-%s\n", NR-1, $0)}')
    printf "$i\n"
  end
end
complete -f -c git -n '__fish_git_using_command fixup' -a '(__git_fixup_commits)'

