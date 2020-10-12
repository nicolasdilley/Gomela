
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example668405485/examples/maxconnect.go
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
	int size = 5;
	Chandef queue;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: size > 0 -> 
		queue.size = size;
		run emptyChan(queue)
	:: else -> 
		run sync_monitor(queue)
	fi;
		for(i : 0.. size-1) {
for10:		run Anonymous0(queue)
	};
for10_exit:	
	if
	:: 0 != -1 && size-1 != -1 -> 
				for(i : 0.. size-1) {
for20:			
			if
			:: queue.async_rcv?0;
			:: queue.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: queue.async_rcv?0;
			:: queue.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:
stop_process:}

proctype Anonymous0(Chandef queue) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: 0 != -1 && 10-1 != -1 -> 
						for(i : 0.. 10-1) {
for11:				
				if
				:: true -> 
					
					if
					:: queue.async_send!0;
					:: queue.sync!0 -> 
						queue.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for11:				
				if
				:: true -> 
					
					if
					:: queue.async_send!0;
					:: queue.sync!0 -> 
						queue.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for11_exit:
	:: true -> 
		
		if
		:: 0 != -1 && 10-1 != -1 -> 
						for(i : 0.. 10-1) {
for11:				
				if
				:: true -> 
					
					if
					:: queue.async_send!0;
					:: queue.sync!0 -> 
						queue.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for11:				
				if
				:: true -> 
					
					if
					:: queue.async_send!0;
					:: queue.sync!0 -> 
						queue.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for11_exit:
	fi;
	
	if
	:: queue.async_send!0;
	:: queue.sync!0 -> 
		queue.sending?0
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
