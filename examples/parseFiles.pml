#define files 10
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



init {
  Chandef ch;
  int i;
  bool state = false;

  if
  :: files > 0 ->
    ch.size = files;
    run emptyChan(ch)
  :: else ->
    run sync_monitor(ch)
  fi;
    for(i : 1.. files) {
for10:    run go_mainparseFile(ch)
  };
    for(i : 1.. files) {
for20:
    if
    :: ch.async_rcv?0;
    :: ch.sync?0;
    fi
  }
stop_process:}

proctype go_mainparseFile(Chandef ch) {
  bool closed;
  int i;

  if
  :: ch.async_send!0;
  :: ch.sync!0 ->
    ch.sending?0
  fi;
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

