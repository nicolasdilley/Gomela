#define lb_for232_0  -1
#define ub_for232_1  -1
#define lb_for158_2  -1
#define ub_for158_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example029177523/archive/src/github.com/mitchellh/panicwrap/panicwrap.go
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
	Chandef panicCh;
	bool state = false;
	int stderr_r = 5;
	Chandef doneCh;
	Chandef sigCh;
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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(doneCh);
	run sync_monitor(panicCh);
	run go_panicwraptrackPanic(panicCh);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(sigCh);
	run Anonymous1(doneCh,panicCh,sigCh);
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: panicCh.async_rcv?0;
		:: panicCh.sync?0;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	
	if
	:: panicCh.async_rcv?0;
	:: panicCh.sync?0;
	fi;
	doneCh.closing!true
stop_process:}

proctype go_panicwraptrackPanic(Chandef result) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: result.async_send!0;
					:: result.sync!0 -> 
						result.sending?0
					fi
				:: true;
				fi;
				goto stop_process
			:: true;
			fi
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: result.async_send!0;
					:: result.sync!0 -> 
						result.sending?0
					fi
				:: true;
				fi;
				goto stop_process
			:: true;
			fi
		fi;
		
		if
		:: true -> 
			do
			:: true;
			:: true -> 
				break
			od
		:: true;
		fi;
				for(i : 1.. panicHeaders) {
for11:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	od;
for10_exit:	result.closing!true;
stop_process:
}
proctype Anonymous1(Chandef doneCh;Chandef panicCh;Chandef sigCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: doneCh.async_rcv?0 -> 
			goto stop_process
		:: doneCh.sync?0 -> 
			goto stop_process
		:: sigCh.async_rcv?0 -> 
			break
		:: sigCh.sync?0 -> 
			break
		od
	od;
for20_exit:stop_process:
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

