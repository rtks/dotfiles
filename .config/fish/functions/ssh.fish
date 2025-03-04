function ssh
  if [ (count $argv) = 1 ]; and contains "$argv" (cat ~/.ssh/config | string match -rg  '^Host.*\s([^\s]*)_\\*')
    command ssh "$argv"_fish
  else
    command ssh $argv
  end
end
