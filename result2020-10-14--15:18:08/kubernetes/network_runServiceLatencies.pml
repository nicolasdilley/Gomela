#define runServiceLatencies_total  60
#define runServiceLatencies_inParallel  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example603064843/test/e2e/network/service_latency.go
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
	Chandef errs;
	int inParallel = runServiceLatencies_inParallel;
	Chandef blocker;
	bool state = false;
	Chandef durations;
	int total = runServiceLatencies_total;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: total > 0 -> 
		errs.size = total;
		run emptyChan(errs)
	:: else -> 
		run sync_monitor(errs)
	fi;
	
	if
	:: total > 0 -> 
		durations.size = total;
		run emptyChan(durations)
	:: else -> 
		run sync_monitor(durations)
	fi;
	
	if
	:: inParallel > 0 -> 
		blocker.size = inParallel;
		run emptyChan(blocker)
	:: else -> 
		run sync_monitor(blocker)
	fi;
		for(i : 0.. total-1) {
for10:		run Anonymous0(errs,durations,blocker)
	};
for10_exit:	
	if
	:: 0 != -1 && total-1 != -1 -> 
				for(i : 0.. total-1) {
for20:			do
			:: errs.async_rcv?0 -> 
				break
			:: errs.sync?0 -> 
				break
			:: durations.async_rcv?0 -> 
				break
			:: durations.sync?0 -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: errs.async_rcv?0 -> 
				break
			:: errs.sync?0 -> 
				break
			:: durations.async_rcv?0 -> 
				break
			:: durations.sync?0 -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errs;Chandef durations;Chandef blocker) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: blocker.async_send!0;
	:: blocker.sync!0 -> 
		blocker.sending?0
	fi;
	
	if
	:: true -> 
		
		if
		:: errs.async_send!0;
		:: errs.sync!0 -> 
			errs.sending?0
		fi
	:: true -> 
		
		if
		:: durations.async_send!0;
		:: durations.sync!0 -> 
			durations.sending?0
		fi
	:: true -> 
		
		if
		:: durations.async_send!0;
		:: durations.sync!0 -> 
			durations.sending?0
		fi
	fi;
	
	if
	:: blocker.async_rcv?0;
	:: blocker.sync?0;
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

