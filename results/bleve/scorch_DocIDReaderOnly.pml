
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example774409785/index/scorch/snapshot_index.go
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
	chan child_inewDocIDReader0 = [0] of {int};
	Chandef results;
	int i_segment = 5;
	bool state = false;
	run sync_monitor(results);
	do
	:: true -> 
for10:		run Anonymous0(results)
	:: true -> 
		break
	od;
	run inewDocIDReader(results,child_inewDocIDReader0);
	child_inewDocIDReader0?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef results) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: results.async_send!0;
		:: results.sync!0 -> 
			results.sending?0
		fi
	:: true -> 
		
		if
		:: results.async_send!0;
		:: results.sync!0 -> 
			results.sending?0
		fi
	:: true -> 
		
		if
		:: results.async_send!0;
		:: results.sync!0 -> 
			results.sending?0
		fi
	fi;
stop_process:
}
proctype inewDocIDReader(Chandef results;chan child) {
	bool closed; 
	int i;
	
	if
	:: 0 != -1 && i_segment-1 != -1 -> 
				for(i : 0.. i_segment-1) {
for20:			
			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

