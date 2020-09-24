#define lb_for156_0  -1
#define ub_for156_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example076315280/components/engine/pkg/filenotify/poller.go
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
	Chandef chClose;
	bool state = false;
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(chClose);
	run go_wwatch(chClose);
	goto stop_process
stop_process:}

proctype go_wwatch(Chandef chClose) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true;
		:: chClose.async_rcv?0 -> 
			goto stop_process
		:: chClose.sync?0 -> 
			goto stop_process
		od;
		
		if
		:: true -> 
			
			if
			:: true -> 
				chan child_wsendEvent0 = [0] of {int};
				run wsendEvent(chClose,child_wsendEvent0);
				child_wsendEvent0?0;
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			chan child_wsendErr1 = [0] of {int};
			run wsendErr(chClose,child_wsendErr1);
			child_wsendErr1?0;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			chan child_wsendEvent2 = [0] of {int};
			run wsendEvent(chClose,child_wsendEvent2);
			child_wsendEvent2?0;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			chan child_wsendEvent3 = [0] of {int};
			run wsendEvent(chClose,child_wsendEvent3);
			child_wsendEvent3?0;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			chan child_wsendEvent4 = [0] of {int};
			run wsendEvent(chClose,child_wsendEvent4);
			child_wsendEvent4?0;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	od;
for10_exit:stop_process:
}
proctype wsendEvent(Chandef chClose;chan child) {
	bool closed; 
	int i;
	do
	:: true;
	:: chClose.async_rcv?0 -> 
		goto stop_process
	:: chClose.sync?0 -> 
		goto stop_process
	od;
	goto stop_process;
	child!0;
stop_process:
}
proctype wsendErr(Chandef chClose;chan child) {
	bool closed; 
	int i;
	do
	:: true;
	:: chClose.async_rcv?0 -> 
		goto stop_process
	:: chClose.sync?0 -> 
		goto stop_process
	od;
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

