function __run_async
  set -l command $argv[1]
  set -l callback $argv[2]

  fish -c 'set -U _async_job_result_$fish_pid (eval '$command')' &
  set -l pid (jobs --last --pid)
  #disown $pid
  set -l async_job_result _async_job_result_$pid

  function _async_job_$pid -v $async_job_result -V async_job_result -V callback
    functions -e (status current-function)
    eval "$callback \"$$async_job_result\""
    set -e $async_job_result
  end
end

function _async_on_exit --on-event fish_exit
  set -l fish_pids (pgrep -f fish)
  set -U -n | sed -En 's/(_async_job_result_([0-9]+))/\1 \2/p' | while read -l varname pid
    if not contains "$pid" fish_pids
      set -e $varname
    end
  end
end
