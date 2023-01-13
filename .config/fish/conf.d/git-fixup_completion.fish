function __git_fixup_commits
  command git log --pretty=tformat:"%h%x09%s" -n20
end
complete -f -k -c git -n '__fish_git_using_command fixup' -a '(__git_fixup_commits)'
