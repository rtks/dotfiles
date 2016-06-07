function git-fixup
  set MAX_LOG_COUNT 30
  if [ (count $argv) = 0 ]
    git commit --fixup HEAD
  else
    if echo $argv[1] | grep '^[0-9]*-[a-f0-9]*$' > /dev/null
      git commit --fixup (echo $argv[1] | cut -d- -f2)
    else
      git commit --fixup $argv
    end
  end
end
