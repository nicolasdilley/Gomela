
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example978188784/core/monitor/monitor.go
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
	int i;
	Chandef revisions;
	Chandef errc;
	Chandef pairs;
	bool state = false;
	run sync_monitor(errc);
	run sync_monitor(revisions);
	run sync_monitor(pairs);
	run Anonymous0(errc,revisions,pairs);
	run Anonymous1(errc,revisions,pairs);
	do
	:: pairs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: pairs.async_rcv?0;
			:: pairs.sync?0;
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
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
	
	if
	:: errc.async_rcv?0;
	:: errc.sync?0;
	fi;
	
	if
	:: errc.async_rcv?0;
	:: errc.sync?0;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errc;Chandef revisions;Chandef pairs) {
	bool closed; 
	int i;
	
	if
	:: errc.async_send!0;
	:: errc.sync!0 -> 
		errc.sending?0
	fi;
stop_process:
}
proctype monitorRevisionPairs(Chandef revisions;Chandef pairs;chan child) {
	bool closed; 
	int i;
	do
	:: revisions.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: revisions.async_rcv?0;
			:: revisions.sync?0;
			fi;
			do
			:: true -> 
				goto stop_process
			:: pairs.async_send!0 -> 
				break
			:: pairs.sync!0 -> 
				pairs.sending?0;
				break
			od
		fi
	od;
	goto stop_process;
	pairs.closing!true;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef errc;Chandef revisions;Chandef pairs) {
	bool closed; 
	int i;
	chan child_monitorRevisionPairs0 = [0] of {int};
	run monitorRevisionPairs(revisions,pairs,child_monitorRevisionPairs0);
	child_monitorRevisionPairs0?0;
	
	if
	:: errc.async_send!0;
	:: errc.sync!0 -> 
		errc.sending?0
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

