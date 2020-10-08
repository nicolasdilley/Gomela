#define lb_for46_0  -1
#define ub_for46_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example610520499/client/events.go
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
	Chandef errs;
	Chandef messages;
	Chandef started;
	bool state = false;
	run sync_monitor(messages);
	
	if
	:: 1 > 0 -> 
		errs.size = 1;
		run emptyChan(errs)
	:: else -> 
		run sync_monitor(errs)
	fi;
	run sync_monitor(started);
	run Anonymous0(messages,errs,started);
	
	if
	:: started.async_rcv?0;
	:: started.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef messages;Chandef errs;Chandef started) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		started.closing!true;
		
		if
		:: errs.async_send!0;
		:: errs.sync!0 -> 
			errs.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		started.closing!true;
		
		if
		:: errs.async_send!0;
		:: errs.sync!0 -> 
			errs.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	started.closing!true;
	do
	:: true -> 
for10:		do
		:: true -> 
			
			if
			:: errs.async_send!0;
			:: errs.sync!0 -> 
				errs.sending?0
			fi;
			goto stop_process
		:: true -> 
			
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
			do
			:: messages.async_send!0 -> 
				break
			:: messages.sync!0 -> 
				messages.sending?0;
				break
			:: true -> 
				
				if
				:: errs.async_send!0;
				:: errs.sync!0 -> 
					errs.sending?0
				fi;
				goto stop_process
			od;
			break
		od
	od;
for10_exit:	errs.closing!true;
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

