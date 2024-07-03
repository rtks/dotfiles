for i in $fish_complete_path/git.fish
    if test $i != (status --current-filename); and test -e $i
        source $i
        break
    end
end

function __fish_git_function_subcommand
    set commands (functions | string split ',' | string replace -fr '^git-' '')
    for i in $commands
        echo -e "$i\t$(functions -Dv git-$i)[5]"
    end
end
complete --no-files git -a '(__fish_git_function_subcommand)' -n __fish_git_needs_command

function __git_fixup_commits
    command git log --pretty=tformat:"%h%x09%s" -n20
end
complete -f -k -c git -n '__fish_git_using_command fixup' -a '(__git_fixup_commits)'
