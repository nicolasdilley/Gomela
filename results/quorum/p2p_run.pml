#define lb_for270_0  -1
#define ub_for270_1  -1
#define lb_for217_2  -1
#define ub_for217_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example244624373/p2p/peer.go
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
	Chandef readErr;
	Chandef writeStart;
	int i;
	Chandef writeErr;
	chan child_pstartProtocols0 = [0] of {int};
	bool state = false;
	
	if
	:: 1 > 0 -> 
		writeStart.size = 1;
		run emptyChan(writeStart)
	:: else -> 
		run sync_monitor(writeStart)
	fi;
	
	if
	:: 1 > 0 -> 
		writeErr.size = 1;
		run emptyChan(writeErr)
	:: else -> 
		run sync_monitor(writeErr)
	fi;
	
	if
	:: 1 > 0 -> 
		readErr.size = 1;
		run emptyChan(readErr)
	:: else -> 
		run sync_monitor(readErr)
	fi;
	run go_preadLoop(readErr);
	
	if
	:: writeStart.async_send!0;
	:: writeStart.sync!0 -> 
		writeStart.sending?0
	fi;
	run pstartProtocols(writeStart,writeErr,child_pstartProtocols0);
	child_pstartProtocols0?0;
loop:		do
	:: true -> 
for30:		do
		od
	od;
for30_exit:;
	goto stop_process
stop_process:}

proctype go_preadLoop(Chandef errc) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: errc.async_send!0;
			:: errc.sync!0 -> 
				errc.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: errc.async_send!0;
			:: errc.sync!0 -> 
				errc.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	od;
for10_exit:stop_process:
}
proctype pstartProtocols(Chandef writeStart;Chandef writeErr;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		run Anonymous2(writeStart,writeErr)
	:: true -> 
		break
	od;
	child!0;
stop_process:
}
proctype Anonymous2(Chandef writeStart;Chandef writeErr) {
	bool closed; 
	int i;
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

