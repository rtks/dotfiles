function git-fixup -d "Fixup commit"
  set MAX_LOG_COUNT 30
  if [ (count $argv) = 0 ]
    git commit --fixup HEAD
  else
    git commit --fixup $argv
  end
end
