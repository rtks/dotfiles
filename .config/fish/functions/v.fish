function v
    set -l files (nvim --headless -c 'echo v:oldfiles | q' 2>&1 | string match -arg "'(.*?)'[,\]]" | string replace "''" "\'" | string match -v '*/tmp/*' | string match -v '*COMMIT_EDITMSG' | string match -vr '_(BASE|LOCAL|REMOTE)_' | string replace $HOME '~')
    if [ (count $files) -eq 1 ]
      nvim (string replace -r '^~' $HOME -- $files)
    else
      printf '%s\n' $files | fzf-tmux -m -1 -q "$argv[1]" | read -l sel
      and nvim (string replace -r '^~' $HOME -- $sel)
    end
end
