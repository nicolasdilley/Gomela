// /Users/redfloyd/go/src/github.com/nicolasdilley/gomela/source/test/test.go

#define a_size 1
#define b_size 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example025933326/cmd/influx_inspect/buildtsi/buildtsi.go
typedef Chandef {
  chan sync = [0] of {int};
  chan sending = [0] of {int};
  chan send = [0] of {int};
  chan rcv = [0] of {int};
  chan closing = [0] of {bool};
  chan is_closed = [0] of {bool};
  int size = 0;
  int num_msgs = 0;
}

init {
  int i;
  Chandef a;
  if
  :: a_size != 0 ->
    a.size = a_size;
    run emptyChan(a)
  :: else ->
    run sync_monitor(a)
  fi;

  Chandef b;


  if
  :: b_size != 0 ->
    b.size = b_size;
    run emptyChan(b)
  :: else ->
    run sync_monitor(b)
  fi;

  run Anonymous0(a,b);

  // Modelling send
    if
    :: a.send!0;
    :: a.sync!0 ->
      a.sending?0
    printf("sent a sync")
    fi;
    if
    :: a.send!0;
    printf("sent a async")
    :: a.sync!0 ->
      a.sending?0
    printf("sent a sync")
    fi;
    if
    :: a.send!0;
    printf("sent a async")
    :: a.sync!0 ->
      a.sending?0
    printf("sent a sync")
    fi;

//  }
stop_process:}

proctype Anonymous0(Chandef a;Chandef b) {
  bool closed;
  int i;

  do
  :: a.rcv?0  ->
    printf("receive a async");
    break
  :: b.rcv?0 ->
    printf("receive b async");
    break
  :: b.sync?0 ->
    printf("receive b sync");
    break
  od
stop_process:
}

/*
* Promela chan model
 */

proctype neitherChan(Chandef ch) {

 end: if
  :: ch.send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending "channel is open"
     run neitherChan(ch)
  :: ch.sending!false ->  // sending "channel is open"
     run neitherChan(ch)
  fi;
}
proctype fullChan(Chandef ch) {
  end: if
  :: ch.rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending "channel is open"
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
  fi;
}
proctype emptyChan(Chandef ch) {
 end: if
  :: ch.send?0 -> // a message has been received
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
    run emptyChan(ch) // sending "channel is open"
  :: ch.sending!false ->
    run emptyChan(ch) // sending "channel is open"
  fi;
}

proctype closedChan(Chandef ch) {
  end: if
    :: ch.send?0-> // cannot send on closed channel
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


proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
  od;
stop_process:
}
