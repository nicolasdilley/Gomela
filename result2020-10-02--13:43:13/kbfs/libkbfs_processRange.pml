
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example273188399/libkbfs/md_ops.go
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
	Chandef irmdChan;
	bool state = false;
	int irmds = 5;
	Chandef rmdsChan;
	int numWorkers = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: rmdses > 0 -> 
		rmdsChan.size = rmdses;
		run emptyChan(rmdsChan)
	:: else -> 
		run sync_monitor(rmdsChan)
	fi;
	
	if
	:: rmdses > 0 -> 
		irmdChan.size = rmdses;
		run emptyChan(irmdChan)
	:: else -> 
		run sync_monitor(irmdChan)
	fi;
	
	if
	:: 0 != -1 && numWorkers-1 != -1 -> 
				for(i : 0.. numWorkers-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:		for(i : 1.. rmdses) {
for20:		
		if
		:: rmdsChan.async_send!0;
		:: rmdsChan.sync!0 -> 
			rmdsChan.sending?0
		fi
	};
	rmdsChan.closing!true;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	irmdChan.closing!true;
	do
	:: irmdChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: irmdChan.async_rcv?0;
			:: irmdChan.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		fi
	od;
		for(i : 1.. irmds) {
for40:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	};
	goto stop_process
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
