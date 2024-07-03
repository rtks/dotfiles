function git
    set -l subcommand "git-$argv[1]"
    if functions -q $subcommand
        set -e argv[1]
        eval $subcommand $opts $argv
    else if command git rev-parse --git-dir >/dev/null 2>&1;
            and test "$argv[1]" = "push";
            and test -z "$(command git config --get --local user.name)";
            and test "$(command git config --get user.name)" != "rtks"
        echo "Git username is not yet set. Set up a username and email with"
        echo "  git config --local user.name rtks"
        echo "  git config --local user.email rtks@users.noreply.github.com"
        echo "Or, without setting them, continue with"
        echo "  command git $argv"
    else
        command git $opts $argv
    end
end
