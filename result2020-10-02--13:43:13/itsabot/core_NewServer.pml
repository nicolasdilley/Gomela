
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example152763180/core/boot.go
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
	Chandef evtChan;
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0(evtChan);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(evtChan);
	run go_coresendEventsTick(evtChan);
	run go_coresendEvents(evtChan);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef evtChan) {
	bool closed; 
	int i;
stop_process:
}
proctype go_coresendEventsTick(Chandef evtChan) {
	bool closed; 
	int i;
	run Anonymous2();
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. evts) {
for10:		
		if
		:: evtChan.async_send!0;
		:: evtChan.sync!0 -> 
			evtChan.sending?0
		fi
	};
stop_process:
}
proctype Anonymous2() {
	bool closed; 
	int i;
	do
	od;
stop_process:
}
proctype go_coresendEvents(Chandef evtChan) {
	bool closed; 
	int i;
	do
	od;
stop_process:
}
proctype coresendEventsTick(Chandef evtChan;chan child) {
	bool closed; 
	int i;
	run Anonymous5();
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for20:		
		if
		:: evtChan.async_send!0;
		:: evtChan.sync!0 -> 
			evtChan.sending?0
		fi
	:: true -> 
		break
	od;
	child!0;
stop_process:
}
proctype Anonymous5() {
	bool closed; 
	int i;
	do
	od;
stop_process:
}
proctype coresendEvents(Chandef evtChan;chan child) {
	bool closed; 
	int i;
	do
	od;
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
