function git
    set -l subcommand "git-$argv[1]"
    if functions -q $subcommand
        set -e argv[1]
        eval $subcommand $opts $argv
    else
        command git $opts $argv
    end
end