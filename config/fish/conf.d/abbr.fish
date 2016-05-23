if not set -q abbr_initialized
  printf 'Initializing \e[33mabbr\e[0m ... '
  
  if not functions -q abbr
    function abbr -d temp
      set fish_user_abbreviations $fish_user_abbreviations $argv[2]
    end
  end

  set -U fish_user_abbreviations

  abbr -a gfi='git-fixup'
  abbr -a gfia='git add --all; git-fixup'
  abbr -a glol="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%aN>%Creset' --abbrev-commit --date-order"
  abbr -a glola="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%aN>%Creset' --abbrev-commit --all --date-order"

  abbr -a g='git'
  abbr -a ga='git add'
  abbr -a gaa='git add --all'
  abbr -a gapa='git add --patch'
  abbr -a gb='git branch'
  abbr -a gba='git branch -a'
  abbr -a gbl='git blame -b -w'
  abbr -a gbnm='git branch --no-merged'
  abbr -a gbr='git branch --remote'
  abbr -a gbs='git bisect'
  abbr -a gbsb='git bisect bad'
  abbr -a gbsg='git bisect good'
  abbr -a gbsr='git bisect reset'
  abbr -a gbss='git bisect start'
  abbr -a gc='git commit -v'
  abbr -a gc!='git commit -v --amend'
  abbr -a gca='git commit -v -a'
  abbr -a gca!='git commit -v -a --amend'
  abbr -a gcan!='git commit -v -a -s --no-edit --amend'
  abbr -a gcam='git commit -a -m'
  abbr -a gcb='git checkout -b'
  abbr -a gcf='git config --list'
  abbr -a gcl='git clone --recursive'
  abbr -a gclean='git clean -fd'
  abbr -a gpristine='git reset --hard; and git clean -dfx'
  abbr -a gcm='git checkout master'
  abbr -a gcmsg='git commit -m'
  abbr -a gco='git checkout'
  abbr -a gcount='git shortlog -sn'
  abbr -a gcp='git cherry-pick'
  abbr -a gcs='git commit -S'
  abbr -a gd='git diff'
  abbr -a gdca='git diff --cached'
  abbr -a gdct='git describe --tags `git rev-list --tags --max-count=1`'
  abbr -a gdt='git diff-tree --no-commit-id --name-only -r'
  abbr -a gdw='git diff --word-diff'
  abbr -a gf='git fetch'
  abbr -a gfa='git fetch --all --prune'
  abbr -a gfo='git fetch origin'
  abbr -a gg='git gui citool'
  abbr -a gga='git gui citool --amend'
  abbr -a ggpull='git pull origin (git_current_branch)'
  abbr -a ggpush='git push origin (git_current_branch)'
  abbr -a ggsup='git branch --set-upstream-to=origin/(git_current_branch)'
  abbr -a ggpur='ggu'
  abbr -a gignore='git update-index --assume-unchanged'
  abbr -a gignored='git ls-files -v | grep "^[[:lower:]]"'
  abbr -a git-svn-dcommit-push='git svn dcommit; and git push github master:svntrunk'
  abbr -a gk='\gitk --all --branches'
  abbr -a gke='\gitk --all (git log -g --pretty=format:%h)'
  abbr -a gl='git pull'
  abbr -a glg='git log --stat'
  abbr -a glgp='git log --stat -p'
  abbr -a glgg='git log --graph'
  abbr -a glgga='git log --graph --decorate --all'
  abbr -a glgm='git log --graph --max-count=10'
  abbr -a glo='git log --oneline --decorate'
  abbr -a glog='git log --oneline --decorate --graph'
  abbr -a glp="_git_log_prettily"
  abbr -a gm='git merge'
  abbr -a gmom='git merge origin/master'
  abbr -a gmt='git mergetool --no-prompt'
  abbr -a gmtvim='git mergetool --no-prompt --tool=vimdiff'
  abbr -a gmum='git merge upstream/master'
  abbr -a gp='git push'
  abbr -a gpd='git push --dry-run'
  abbr -a gpoat='git push origin --all; and git push origin --tags'
  abbr -a gpu='git push upstream'
  abbr -a gpv='git push -v'
  abbr -a gr='git remote'
  abbr -a gra='git remote add'
  abbr -a grb='git rebase'
  abbr -a grba='git rebase --abort'
  abbr -a grbc='git rebase --continue'
  abbr -a grbi='git rebase -i'
  abbr -a grbm='git rebase master'
  abbr -a grbs='git rebase --skip'
  abbr -a grh='git reset HEAD'
  abbr -a grhh='git reset HEAD --hard'
  abbr -a grmv='git remote rename'
  abbr -a grrm='git remote remove'
  abbr -a grset='git remote set-url'
  abbr -a grt='cd (git rev-parse --show-toplevel; or echo ".")'
  abbr -a gru='git reset --'
  abbr -a grup='git remote update'
  abbr -a grv='git remote -v'
  abbr -a gsb='git status -sb'
  abbr -a gsd='git svn dcommit'
  abbr -a gsi='git submodule init'
  abbr -a gsps='git show --pretty=short --show-signature'
  abbr -a gsr='git svn rebase'
  abbr -a gss='git status -s'
  abbr -a gst='git status'
  abbr -a gsta='git stash'
  abbr -a gstaa='git stash apply'
  abbr -a gstd='git stash drop'
  abbr -a gstl='git stash list'
  abbr -a gstp='git stash pop'
  abbr -a gsts='git stash show --text'
  abbr -a gsu='git submodule update'
  abbr -a gts='git tag -s'
  abbr -a gtv='git tag | sort -V'
  abbr -a gunignore='git update-index --no-assume-unchanged'
  abbr -a gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-"; and git reset HEAD~1'
  abbr -a gup='git pull --rebase'
  abbr -a gupv='git pull --rebase -v'
  abbr -a glum='git pull upstream master'
  abbr -a gwch='git whatchanged -p --abbrev-commit --pretty=medium'
  abbr -a gwip='git add -A; git rm (git ls-files --deleted) 2> /dev/null; git commit -m "--wip--"'

  if functions abbr | head -n1 | grep -q temp
    functions -e abbr
  end

  set -U abbr_initialized 1
  echo 'Done'
end

