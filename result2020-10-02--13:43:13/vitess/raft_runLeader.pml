
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example862180471/go/vt/orchestrator/external/raft/raft.go
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
	bool state = false;
	int r_leaderState_replState = 5;
	chan child_raftnewInflight0 = [0] of {int};
	int r_peers = 5;
	Chandef r_leaderState_commitCh;
	Chandef r_leaderState_stepDown;
	int r_leaderState_notify = 5;
	int i;
	
	if
	:: true -> 
		do
		:: true;
		:: true;
		od
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		r_leaderState_commitCh.size = 1;
		run emptyChan(r_leaderState_commitCh)
	:: else -> 
		run sync_monitor(r_leaderState_commitCh)
	fi;
	run raftnewInflight(r_leaderState_commitCh,child_raftnewInflight0);
	child_raftnewInflight0?0;
	
	if
	:: 1 > 0 -> 
		r_leaderState_stepDown.size = 1;
		run emptyChan(r_leaderState_stepDown)
	:: else -> 
		run sync_monitor(r_leaderState_stepDown)
	fi;
		for(i : 1.. r_peers) {
for30:
	};
		for(i : 1.. r_leaderState_replState) {
for10:
	};
		for(i : 1.. r_leaderState_notify) {
for20:
	};
	
	if
	:: true -> 
		do
		:: true;
		:: true -> 
			do
			:: true;
			:: true -> 
				break
			od
		od
	:: true;
	fi
stop_process:}

proctype raftnewInflight(Chandef commitCh;chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
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

