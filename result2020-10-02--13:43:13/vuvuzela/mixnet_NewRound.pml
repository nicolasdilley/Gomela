
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example196592854/mixnet/mixnet.go
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
	bool state = false;
	int i;
		for(i : 1.. servers) {
for10:
	};
		for(i : 1.. servers) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	
	if
	:: 1 > 0 -> 
		errs.size = 1;
		run emptyChan(errs)
	:: else -> 
		run sync_monitor(errs)
	fi;
		for(i : 1.. servers) {
for30:		run Anonymous0(errs)
	};
	
	if
	:: 0 != -1 && servers-1 != -1 -> 
				for(i : 0.. servers-1) {
for40:			
			if
			:: errs.async_rcv?0;
			:: errs.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for40:			
			if
			:: errs.async_rcv?0;
			:: errs.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for40_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. servers) {
for50:		run Anonymous1(errs)
	};
	
	if
	:: 0 != -1 && servers-1 != -1 -> 
				for(i : 0.. servers-1) {
for60:			
			if
			:: errs.async_rcv?0;
			:: errs.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for60:			
			if
			:: errs.async_rcv?0;
			:: errs.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for60_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errs) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: errs.async_send!0;
		:: errs.sync!0 -> 
			errs.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: errs.async_send!0;
	:: errs.sync!0 -> 
		errs.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef errs) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: errs.async_send!0;
		:: errs.sync!0 -> 
			errs.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: errs.async_send!0;
	:: errs.sync!0 -> 
		errs.sending?0
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

