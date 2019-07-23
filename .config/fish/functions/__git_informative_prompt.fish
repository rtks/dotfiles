function __git_informative_prompt
  __fish_git_prompt $argv
end

set -g __fish_git_prompt_show_informative_status 'yes'
set -g __fish_git_prompt_showcolorhints 'yes'
set -g __fish_git_prompt_showstashstate 'yes'
set -g __fish_git_prompt_char_cleanstate '✓'
set -g __fish_git_prompt_char_dirtystate '↔'
set -g __fish_git_prompt_char_invalidstate '×'
set -g __fish_git_prompt_char_stagedstate '✓'
set -g __fish_git_prompt_char_stashstate '■'
set -g __fish_git_prompt_char_untrackedfiles '…'
set -g __fish_git_prompt_char_upstream_ahead '⤴'
set -g __fish_git_prompt_char_upstream_behind '⤵'
