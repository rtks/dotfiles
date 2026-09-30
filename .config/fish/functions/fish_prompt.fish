set --global __fish_prompt_result __fish_prompt_result_$fish_pid

function __fish_prompt_repaint --on-signal USR1
  if set -q __fish_prompt_queued
    commandline --function repaint
  end
end

function __fish_prompt_exit --on-event fish_exit
  set -q $__fish_prompt_result && set -e $__fish_prompt_result
  for i in (set -Un | string match -r '^__fish_prompt_result_\d+$')
    if not kill -s 0 (string match -r '\d+$' $i) &>/dev/null
      set -e $i
    end
  end
end

if not type -q starship

  function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus

    if contains PWD $__fish_prompt_trigger
      set -l git_root (command git --no-optional-locks rev-parse --show-toplevel 2>/dev/null)

      if set --query git_root[1]
        if [ "$git_root[1]" != "$__fish_prompt_git_root" ]
          set -g __fish_prompt_git_info ' (…)'
          set -g __fish_prompt_git_root $git_root[1]
        end
      else
        set -e __fish_prompt_git_root
      end

      set -l git_base (string replace --all --regex -- "^.*/" "" "$git_root")
      set -g __fish_prompt_pwd (
        string replace --ignore-case -- ~ \~ $PWD |
        string replace -- "/$git_base/" /:/ |
        string replace --regex --all -- "(\.?[^/]{1})[^/]*/" "\$1/" |
        string replace -- : "$git_base"
      )
    end

    if set -q __fish_prompt_git_root
      if set -q __fish_prompt_queued
        for i in (seq 100)
          if set -q $__fish_prompt_result
            break
          end
          sleep 0.01
        end
        set -g __fish_prompt_git_info $$__fish_prompt_result
        set -e $__fish_prompt_result
        set -e __fish_prompt_queued
      else
        set -g __fish_prompt_queued
        set __fish_prompt_git_info (set_color $fish_color_autosuggestion; string replace -r -a '\\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]' '' $__fish_prompt_git_info)
        fish -P -c "
          set -x GIT_OPTIONAL_LOCKS 0
          set __fish_git_prompt_show_informative_status 'yes'
          set __fish_git_prompt_showcolorhints 'yes'
          set __fish_git_prompt_showstashstate 'yes'
          set __fish_git_prompt_showuntrackedfiles 'yes'
          set __fish_git_prompt_char_cleanstate '✓'
          set __fish_git_prompt_char_dirtystate '+'
          set __fish_git_prompt_char_invalidstate '×'
          set __fish_git_prompt_char_stagedstate '✓'
          set __fish_git_prompt_char_stashstate '≡'
          set __fish_git_prompt_char_untrackedfiles '…'
          set __fish_git_prompt_char_upstream_ahead '⤴'
          set __fish_git_prompt_char_upstream_behind '⤵'
          set -U $__fish_prompt_result (fish_git_prompt)
          kill -s USR1 $fish_pid 2>/dev/null
          for i in (seq 10)
            if not set -q $__fish_prompt_result
              break
            end
            sleep 0.1
            kill -s USR1 $fish_pid 2>/dev/null
          end" &
        disown
      end
    else
      set -g __fish_prompt_git_info ''
    end

    __fish_prompt_extra

    # Hostname
    if set -q SSH_CONNECTED; or set -q SSH_CONNECTION
      if not set -q TMUX; and not set -q VSCODE_SHELL_INTEGRATION
        echo -n (prompt_hostname)' '
      end
    end

    # PWD
    set_color $fish_color_cwd
    if not test -w .
      echo -n ''
    end
    echo -n $__fish_prompt_pwd
    set_color normal

    # Git
    echo -n $__fish_prompt_git_info
    echo -n ' '

    # Duration
    set -l duration $CMD_DURATION
    if test $duration -ge 5000
      set -l ss (math -s0 $duration / 10 % 100)
      set -l s (math -s0 $duration / 1000 % 60)
      set -l m (math -s0 $duration / 60000 % 60)
      set -l h (math -s0 $duration / 3600000 % 24)
      set -l d (math -s0 $duration / 86400000)
      set_color yellow
      if test $d -gt 0
        echo -sn $d "d"
      end
      if test $h -gt 0
        echo -sn $h "h"
      end
      if test $m -gt 0
        echo -sn $m "m"
      end
      if test $duration -ge 3600000
        echo -sn $s "s "
      else
        printf '%d.%02ds ' $s $ss
      end
    end
    set_color normal

    # Job Count
    set -l job_count (count (jobs))
    if test $job_count -gt 0
      echo -n "+"$job_count" "
    end

    # Exit code
    for i in $last_pipestatus
      if test $i -ne 0
        set_color $fish_color_error
        if [ (count $last_pipestatus) -eq 1 ]
          switch $last_pipestatus
            case 1
              echo -n "ERROR"
            case 2
              echo -n "USAGE"
            case 126
              echo -n "NOPERM"
            case 127
              echo -n "NOTFOUND"
            case 128 + 1
              echo -n "SIGHUP"
            case 128 + 2
              echo -n "SIGINT"
            case 128 + 3
              echo -n "SIGQUIT"
            case 128 + 4
              echo -n "SIGILL"
            case 128 + 5
              echo -n "SIGTRAP"
            case 128 + 6
              echo -n "SIGIOT"
            case 128 + 7
              echo -n "SIGBUS"
            case 128 + 8
              echo -n "SIGFPE"
            case 128 + 9
              echo -n "SIGKILL"
            case 128 + 10
              echo -n "SIGUSR1"
            case 128 + 11
              echo -n "SIGSEGV"
            case 128 + 12
              echo -n "SIGUSR2"
            case 128 + 13
              echo -n "SIGPIPE"
            case 128 + 14
              echo -n "SIGALRM"
            case 128 + 15
              echo -n "SIGTERM"
            case 128 + 16
              echo -n "SIGSTKFLT"
            case 128 + 17
              echo -n "SIGCHLD"
            case 128 + 18
              echo -n "SIGCONT"
            case 128 + 19
              echo -n "SIGSTOP"
            case 128 + 20
              echo -n "SIGTSTP"
            case 128 + 21
              echo -n "SIGTTIN"
            case 128 + 22
              echo -n "SIGTTOU"
            case '*'
              echo -n $last_pipestatus
          end
        else
          echo -n $last_pipestatus
        end
        break
      end
    end

    echo -n '> '
    set_color normal
  end

  function __fish_prompt_pwd_changed --on-variable PWD
    set -ga __fish_prompt_trigger PWD
  end

  __fish_prompt_pwd_changed

  function __fish_prompt_path_changed --on-variable PATH
    set -ga __fish_prompt_trigger PATH
  end

  function __fish_prompt_preexec --on-event fish_preexec
    set -e __fish_prompt_trigger
  end

  function __fish_prompt_extra
    if ! set -q __fish_prompt_trigger
      return
    end

    set -l line ''

    # Current Git author
    if command git --no-optional-locks rev-parse 2>/dev/null
      set line $line(set_color yellow)
      set line $line"Git "
      set line $line(set_color normal)
      set line $line(command git --no-optional-locks config user.name)" <"(command git --no-optional-locks config user.email)"> "
      function __fish_prompt_pwd_get
        echo (ls {$__fish_prompt_git_root,./}/$argv[1] 2>/dev/null)[1]
      end
    else
      function __fish_prompt_pwd_get
        echo $argv[1]
      end
    end

    # Current Rust version
    type -q rustc
    and begin
      test -f (__fish_prompt_pwd_get Cargo.toml)
      or test (count *.rs) -gt 0
    end
    and begin
      set line $line(set_color yellow)
      set line $line"Rust "
      set line $line(set_color normal)
      set line $line(echo (string split "(" -- (rustc --version))[1] | string replace "rustc " "")
    end

    # Current Python version
    begin
      type -q python
      or type -q python3
    end
    and begin
      set -q VIRTUAL_ENV
      or test -f requirements.txt
      or test -f .python-version
      or test -f pyproject.toml
      or test -f Pipfile
      or test (count *.py) -gt 0
    end
    and begin
      set line $line(set_color yellow)
      set line $line"Python "
      set line $line(set_color normal)
      if type -q python
        set line $line(python --version 2>&1 | string replace "Python " "")
      else
        set line $line(python3 --version 2>&1 | string replace "Python " "")
      end
    end

    # Current version of package in current directory
    type -q cargo
    and test -f (__fish_prompt_pwd_get Cargo.toml)
    and set -l package_ver (string trim -c "'\" " (string split = (cat (__fish_prompt_pwd_get Cargo.toml) | string match -r "version\s*=.*")[1] | string split =)[-1])
    and test -n "$package_ver"
    and begin
      set line $line(set_color yellow)
      set line $line"Package "
      set line $line(set_color normal)
      set line $line$package_ver
    end

    if [ -z "$line" ]
      return
    end

    echo $line
    set_color normal
  end

else

  starship init --print-full-init fish | source
  function starship_transient_prompt_func
    echo -n '> '
  end
  #enable_transience
  functions -c fish_prompt fish_prompt_starship
  functions -e fish_prompt
  functions -e fish_right_prompt

  function __fish_prompt_cmd_finished --on-event fish_postexec
    set -g STARSHIP_CMD_PIPESTATUS $pipestatus
    set -g STARSHIP_CMD_STATUS $status
  end

  function fish_prompt --description 'Write out the prompt'
    switch "$fish_key_bindings"
        case fish_hybrid_key_bindings fish_vi_key_bindings
            set STARSHIP_KEYMAP "$fish_bind_mode"
        case '*'
            set STARSHIP_KEYMAP insert
    end
    # Account for changes in variable name between v2.7 and v3.0
    set STARSHIP_DURATION "$CMD_DURATION$cmd_duration"
    set STARSHIP_JOBS (count (jobs -p))

    if test "$TRANSIENT" = "1"
      fish_prompt_starship
      return
    end

    if contains PWD $__fish_prompt_trigger
      __fish_prompt_vcs_detect
    end

    # git と jj のどちらで作業しているかを毎回判定し、git なら snapshot しない
    set -l jj_mode (__fish_prompt_jj_mode; and echo 1)
    if test "$jj_mode" != "$__fish_prompt_jj_mode"
      # モードが切り替わったら jj 情報と user 表示を作り直す
      set -g __fish_prompt_jj_mode $jj_mode
      set -g __fish_prompt_jj_info '…'
      set -ga __fish_prompt_trigger VCS
    end

    set -lx FISH_PROMPT_GIT ''
    if set -q __fish_prompt_git_root; or set -q __fish_prompt_jj_root
      if set -q __fish_prompt_queued
        for i in (string split '' (string repeat -n 100 x))
          set -q $__fish_prompt_result; and break
          sleep 0.01
        end
        set -l result $$__fish_prompt_result
        set -g __fish_prompt_git_info $result[1]
        set -g __fish_prompt_jj_info (__fish_prompt_jj_format $result[2])
        set -e $__fish_prompt_result
        set -e __fish_prompt_queued
      else
        set -g __fish_prompt_queued 1
        set __fish_prompt_git_info (set_color $fish_color_autosuggestion; string replace -r -a '\\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]' '' $__fish_prompt_git_info)
        if test -n "$__fish_prompt_jj_info"
          set __fish_prompt_jj_info (set_color $fish_color_autosuggestion; string replace -r -a '\\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]' '' $__fish_prompt_jj_info)
        end
        set -l snapshot_cmd true
        set -l jj_cmd true
        set -l git_cmd 'STARSHIP_CONFIG=~/.config/starship_git.toml starship prompt'
        if set -q jj_mode[1]
          # jj-starship は snapshot しないため、git status と jj-starship の前に working copy の変更を @ へ取り込む
          type -q jj; and set snapshot_cmd 'jj util snapshot --quiet &>/dev/null'
          set jj_cmd 'jj-starship --no-color --no-jj-prefix'
          # 非 colocated の jj repo では、外側にある git repo の status を混ぜない
          set -q __fish_prompt_jj_colocated; or set git_cmd true
        end
        # 結果は [git status, jj-starship] の2要素で返す
        fish -P -c "
          $snapshot_cmd
          set -U $__fish_prompt_result \"\$($git_cmd)\" \"\$($jj_cmd)\"
          kill -s USR1 $fish_pid 2>/dev/null
          for i in 1 2 3 4 5 6 7 8 9 10
            set -q $__fish_prompt_result; or break
            sleep 0.1
            kill -s USR1 $fish_pid 2>/dev/null
          end" &
        disown
      end
      set FISH_PROMPT_GIT $__fish_prompt_git_info
    else
      set -e FISH_PROMPT_GIT
    end

    set -l profile
    set -lx FISH_PROMPT_JJ ''
    if set -q jj_mode[1]
      set FISH_PROMPT_JJ $__fish_prompt_jj_info
      set profile --profile jj
    else
      set -e FISH_PROMPT_JJ
    end

    set -lx FISH_PROMPT_EXTRA ''
    if set -q __fish_prompt_trigger
      set -l jj_root_for_extra
      set -q jj_mode[1]; and set jj_root_for_extra $__fish_prompt_jj_root
      set FISH_PROMPT_EXTRA (FISH_PROMPT_JJ_ROOT="$jj_root_for_extra" STARSHIP_CONFIG=~/.config/starship_extra.toml starship prompt | string replace -a \e'[J' '')
    end
    if test -z "$FISH_PROMPT_EXTRA"
      set -e FISH_PROMPT_EXTRA
    end
    starship prompt $profile --terminal-width="$COLUMNS" --status=$STARSHIP_CMD_STATUS --pipestatus="$STARSHIP_CMD_PIPESTATUS" --keymap=$STARSHIP_KEYMAP --cmd-duration=$STARSHIP_DURATION --jobs=$STARSHIP_JOBS
  end

  # PWD 変更時に、外部コマンドを使わず親ディレクトリをたどって git root・jj root・git dir・colocated かどうかを求める
  # $PWD は path resolve した物理パスにして、git rev-parse と同じ基準で比較する
  function __fish_prompt_vcs_detect
    set -l git_root
    set -l jj_root
    set -l dir (path resolve $PWD)
    while true
      # .git は通常 repo ではディレクトリ、worktree や submodule ではファイル
      if not set -q git_root[1]; and test -f $dir/.git -o -e $dir/.git/HEAD
        set git_root $dir
      end
      not set -q jj_root[1]; and test -d $dir/.jj; and set jj_root $dir
      test "$dir" = /; and break
      set dir (path dirname $dir)
    end

    set -l git_dirs (__fish_prompt_git_dirs_of $git_root/.git)
    if set -q git_dirs[2]
      test "$git_root" != "$__fish_prompt_git_root"; and set -g __fish_prompt_git_info '…'
      set -g __fish_prompt_git_root $git_root
      # worktree では HEAD や rebase-merge が worktree 固有の git dir にある
      set -g __fish_prompt_git_dir $git_dirs[1]
      set -g __fish_prompt_git_common_dir $git_dirs[2]
    else
      set git_root
      set -e __fish_prompt_git_root __fish_prompt_git_dir __fish_prompt_git_common_dir
    end

    # jj-starship が無い環境や、git repo と入れ子で git のほうが近い場合は jj repo として扱わない
    type -q jj-starship; or set jj_root
    set -q git_root[1]; and string match -q -- "$jj_root/*" $git_root; and set jj_root
    # secondary workspace では .jj/repo がファイルで、main repo の .jj/repo へのパスが入る
    set -l repo $jj_root/.jj/repo
    test -f "$repo"; and set repo (__fish_prompt_read_path $repo)
    # store/git_target の指す git dir が開けない repo は jj からも使えないので、jj repo として扱わない
    set -l store (__fish_prompt_git_dirs_of (__fish_prompt_read_path $repo/store/git_target))
    set -q store[2]; or set jj_root

    set -e __fish_prompt_jj_colocated
    if set -q jj_root[1]
      if test "$jj_root" != "$__fish_prompt_jj_root"
        set -g __fish_prompt_jj_info '…'
        set -g __fish_prompt_git_info ''
        set -g __fish_prompt_jj_root $jj_root
      end
      set -g __fish_prompt_jj_repo $repo
      # jj の is_colocated_git_workspace と同じく、workspace root 直下の .git の common dir が store/git_target のものと一致すれば colocated
      set -l ws (__fish_prompt_git_dirs_of $jj_root/.git)
      test "$ws[2]" = "$store[2]"; and set -g __fish_prompt_jj_colocated 1
    else
      set -e __fish_prompt_jj_root __fish_prompt_jj_repo
    end
  end

  # ファイル先頭行のパス（prefix があれば外す）を物理パスで返す。相対パスはファイルのあるディレクトリ基準
  function __fish_prompt_read_path --argument-names f prefix
    test -r "$f"; and read -l p < $f; and set p (string replace -rf -- "^$prefix" '' $p); and test -n "$p"; or return 1
    string match -q '/*' -- $p; or set p (path dirname $f)/$p
    path resolve $p
  end

  # .git（ファイルなら gitdir: を辿る）や git dir から [git dir, common dir] の物理パスを返す（worktree では commondir が共通の git dir を指す）
  function __fish_prompt_git_dirs_of --argument-names p
    test -f "$p"; and set p (__fish_prompt_read_path $p 'gitdir: ')
    test -d "$p"; or return 1
    set -l common (__fish_prompt_read_path $p/commondir); or set common $p
    path resolve $p $common
  end

  # HEAD が jj の @- のいずれかなら 0 を返す（結果は HEAD と op heads をキーにキャッシュする）
  function __fish_prompt_jj_at_parent --argument-names head
    type -q jj; or return 1
    set -l key $head $__fish_prompt_jj_repo/op_heads/heads/*
    if test "$key" != "$__fish_prompt_jj_parents_key"
      set -g __fish_prompt_jj_parents_key $key
      set -g __fish_prompt_jj_parents (jj -R $__fish_prompt_jj_root log --ignore-working-copy --no-graph -r @- -T 'commit_id ++ "\n"' 2>/dev/null)
    end
    contains -- $head $__fish_prompt_jj_parents
  end

  # いま jj で作業しているなら 0、git で作業しているなら 1 を返す
  # colocated では jj が HEAD を @- に detach するので、HEAD の状態で操作中のツールを判別する
  # - git の rebase/merge/cherry-pick/revert/bisect の途中なら git
  # - HEAD が refs/heads/* の存在するブランチを指すなら git（jj は @- が root のとき refs/jj/root を置く）
  # - HEAD が未作成のブランチ（jj git init 直後）なら、@- が root のときだけ jj
  # - detached なら、HEAD が @- に含まれるときだけ jj（git checkout <commit> などは git）
  # 非 colocated の jj repo は git の HEAD が無関係なので常に jj
  function __fish_prompt_jj_mode
    set -q __fish_prompt_jj_root; or return 1
    set -q __fish_prompt_jj_colocated; or return 0
    set -l git_dir $__fish_prompt_git_dir
    set -l common $__fish_prompt_git_common_dir
    path filter -q $git_dir/{rebase-merge,rebase-apply,sequencer,MERGE_HEAD,CHERRY_PICK_HEAD,REVERT_HEAD,BISECT_START}; and return 1
    read -l head < $git_dir/HEAD 2>/dev/null; or return 0
    if set -l ref (string replace -rf '^ref: ' '' -- $head)
      string match -q 'refs/jj/*' -- $ref; and return 0
      test -e $common/$ref; and return 1
      test -r $common/packed-refs; and contains -- $ref (string replace -rf '^\S+ ' '' < $common/packed-refs); and return 1
      __fish_prompt_jj_at_parent 0000000000000000000000000000000000000000
    else
      __fish_prompt_jj_at_parent $head
    end
  end

  # jj-starship の出力（`id (bookmarks) [status]`）を git_branch/git_commit/git_status に近い表記へ整形する
  function __fish_prompt_jj_format
    string match -rq '^(?<jj_id>\S+)(?: \((?<jj_bm>.*)\))?(?: \[(?<jj_st>.*)\])?$' -- $argv[1]
    or return
    set_color green
    printf '%s(%s)' (string replace -a ', ' ',' -- "$jj_bm") $jj_id
    for c in (string split '' -- $jj_st)
      switch $c
        case '!'
          set_color --bold red
        case '∅'
          set_color yellow
        case '⇡'
          set_color cyan
          set c '⤴'
        case '*'
          set_color red
      end
      echo -n $c
      set_color normal
    end
    set_color normal
  end

  function __fish_prompt_pwd_changed --on-variable PWD
    set -ga __fish_prompt_trigger PWD
  end

  __fish_prompt_pwd_changed

  function __fish_prompt_path_changed --on-variable PATH
    set -ga __fish_prompt_trigger PATH
  end

  function __fish_prompt_docker_context_changed --on-variable DOCKER_CONTEXT
    set -ga __fish_prompt_trigger DOCKER_CONTEXT
  end

  function __fish_prompt_preexec --on-event fish_preexec
    set -e __fish_prompt_trigger
  end
end
