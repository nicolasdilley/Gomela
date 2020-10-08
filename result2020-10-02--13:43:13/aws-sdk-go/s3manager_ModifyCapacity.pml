
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example050395616/service/s3/s3manager/pool.go
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
	Chandef p_capacityChange;
	int newAllocs = 5;
	Chandef p_slices;
	bool state = false;
	Chandef p_allocations;
	int p_max = 5;
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
	:: p_max > 0 -> 
		p_capacityChange.size = p_max;
		run emptyChan(p_capacityChange)
	:: else -> 
		run sync_monitor(p_capacityChange)
	fi;
	
	if
	:: p_max > 0 -> 
		p_allocations.size = p_max;
		run emptyChan(p_allocations)
	:: else -> 
		run sync_monitor(p_allocations)
	fi;
	
	if
	:: 0 != -1 && newAllocs-1 != -1 -> 
				for(i : 0.. newAllocs-1) {
for10:			
			if
			:: p_allocations.async_send!0;
			:: p_allocations.sync!0 -> 
				p_allocations.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: p_allocations.async_send!0;
			:: p_allocations.sync!0 -> 
				p_allocations.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: p_max > 0 -> 
		p_slices.size = p_max;
		run emptyChan(p_slices)
	:: else -> 
		run sync_monitor(p_slices)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for20:		do
		:: p_slices.async_send!0 -> 
			break
		:: p_slices.sync!0 -> 
			p_slices.sending?0;
			break
		:: true -> 
			break
		od
	:: true -> 
		break
	od
stop_process:}

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

