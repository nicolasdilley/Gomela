#define pss 5
#define num_processes 2
#define found_size 2


// /Users/***/go/src/github.com/nicolasdilley/gomela/source/test/test.go
typedef Chandef {
  chan sync = [0] of {int};
  chan async_send = [0] of {int};
  chan async_rcv = [0] of {int};
  chan sending = [0] of {int};
  chan closing = [0] of {bool};
  chan is_closed = [0] of {bool};
  int size = 0;
  int num_msgs = 0;
}
typedef Wgdef {
  chan Add = [0] of {int};
  chan Wait = [0] of {int};
  int Counter = 0;
}



init {
  Chandef found;
  bool state = false;
  Wgdef wg;
  Chandef limitCh;
  int i;

  if
  :: true ->
    goto stop_process
  :: true;
  fi;
  run wgMonitor(wg);
  wg.Add!pss;


 if
  :: found_size > 0 ->
    found.size = found_size;
    run emptyChan(found)
  :: else ->
    run sync_monitor(found)
  fi;

  if
  :: num_processes > 0 ->
    limitCh.size = num_processes;
    run emptyChan(limitCh)
  :: else ->
    run sync_monitor(limitCh)
  fi;
    for(i : 0.. pss-1) {
for10:
    if
    :: limitCh.async_send!0;
    :: limitCh.sync!0 ->
      limitCh.sending?0
    fi;
    run Anonymous0(found,limitCh,wg)
  };
  run Anonymous1(found,limitCh,wg);
  do
  :: found.is_closed?state ->
    if
    :: state ->
      break
    :: else ->

      if
      :: found.async_rcv?0;
      :: found.sync?0;
      fi
    fi
  od;
  goto stop_process
stop_process:}

proctype Anonymous0(Chandef found;Chandef limitCh;Wgdef wg) {
  bool closed;
  int i;

  if
  :: found.async_send!0;
  :: found.sync!0 ->
    found.sending?0
  fi;

  if
  :: limitCh.async_rcv?0;
  :: limitCh.sync?0;
  fi;
  wg.Add!-1;
stop_process:
}
proctype Anonymous1(Chandef found;Chandef limitCh;Wgdef wg) {
  bool closed;
  int i;
  wg.Wait?0;
  found.closing!true;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
  bool closed;
  int i;
  do
  :: wg.Add?i ->
    wg.Counter = wg.Counter + i;
    assert(wg.Counter >= 0)
  :: wg.Counter == 0 ->
end:
    if
    :: wg.Add?i ->
      wg.Counter = wg.Counter + i;
      assert(wg.Counter >= 0)
    :: wg.Wait!0;
    fi
  od;
stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
   :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

