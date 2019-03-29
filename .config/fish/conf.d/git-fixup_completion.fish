function __git_fixup_commits
  for i in (command git log --pretty=tformat:"%h\t%s" -n20)
    printf "$i\n"
  end
end
complete -f -k -c git -n '__fish_git_using_command fixup' -a '(__git_fixup_commits)'
