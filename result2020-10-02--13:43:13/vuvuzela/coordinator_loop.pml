
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example196592854/coordinator/server.go
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
	Chandef flights;
	int i;
	int numInFlight = 5;
	bool state = false;
	
	if
	:: numInFlight > 0 -> 
		flights.size = numInFlight;
		run emptyChan(flights)
	:: else -> 
		run sync_monitor(flights)
	fi;
	
	if
	:: 0 != -1 && numInFlight-1 != -1 -> 
				for(i : 0.. numInFlight-1) {
for10:			
			if
			:: flights.async_send!0;
			:: flights.sync!0 -> 
				flights.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: flights.async_send!0;
			:: flights.sync!0 -> 
				flights.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	do
	:: flights.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: flights.async_rcv?0;
			:: flights.sync?0;
			fi;
			
			if
			:: true -> 
				run Anonymous0(flights)
			:: true;
			fi;
			run Anonymous1(flights)
		fi
	od
stop_process:}

proctype Anonymous0(Chandef flights) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1(Chandef flights) {
	bool closed; 
	int i;
	
	if
	:: flights.async_send!0;
	:: flights.sync!0 -> 
		flights.sending?0
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
