complete -c activate -e

function __fish_activate_complete
    for i in $argv[1]/*; test -f $i/bin/activate.fish; and string replace -r '.*/' '' "$i"\t"$argv[2]"; end
end

complete -c activate -xa '(__fish_activate_complete ~/.envs \'\')'
complete -c activate -xa '(__fish_activate_complete . local)'
