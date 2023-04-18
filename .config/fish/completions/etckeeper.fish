complete -c etckeeper -x

complete -c etckeeper -n '__fish_use_subcommand' -x -a init -d 'This initialises and sets up a git, mercurial, bazaar, or darcs repository.'
complete -c etckeeper -n '__fish_use_subcommand' -x -a commit -d 'Commits all changes in /etc to the repository. A commit message can be specified.'
complete -c etckeeper -n '__fish_use_subcommand' -x -a pre-commit -d 'This is called as a pre-commit hook. It stores metadata and does sanity checks.'
complete -c etckeeper -n '__fish_use_subcommand' -x -a pre-install -d "This is called by apt's DPkg::Pre-Install-Pkgs hook, or by equivalent hooks of other package managers."
complete -c etckeeper -n '__fish_use_subcommand' -x -a post-install -d "This is called by apt's DPkg::Post-Invoke hook, or by equivalent hooks of other package managers."
complete -c etckeeper -n '__fish_use_subcommand' -x -a unclean -d 'This returns true if the directory contains uncommitted changes.'
complete -c etckeeper -n '__fish_use_subcommand' -x -a update-ignore -d 'This updates the VCS ignore file. Content outside a "managed by etckeeper" block is not touched.'
complete -c etckeeper -n '__fish_use_subcommand' -x -a vcs -d 'You can use this to run any subcommand of the VCS that etckeeper is configured to run.'
complete -c etckeeper -n '__fish_seen_subcommand_from vcs' -x -a '(set -l t (commandline -opc) (commandline -ct); __fish_complete_subcommand --commandline "git $t[3..]")'
complete -c etckeeper -n '__fish_use_subcommand' -x -a uninit -d "This command DESTROYS DATA! It is the inverse of the init command, removing VCS information and etckeeper's own bookkeeping information from the directory."
