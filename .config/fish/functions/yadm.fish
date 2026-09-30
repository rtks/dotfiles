function yadm --wraps yadm --description 'yadm enter の間だけ ~/.git に gitdir: を書く'
  if test "$argv[1]" != enter
    command yadm $argv
    return
  end

  set -l repo (command yadm introspect repo 2>/dev/null)
  set -l dotgit ~/.git
  # 既存の ~/.git は自分で作ったものではないので、書き換えも削除もしない
  if test -z "$repo"; or test -e $dotgit; or test -L $dotgit
    command yadm $argv
    return
  end

  echo "gitdir: $repo" >$dotgit
  command yadm $argv
  set -l code $status
  # シェル終了後（Ctrl-C などで抜けた場合も含む）に必ず片付ける
  command rm -f $dotgit
  return $code
end
