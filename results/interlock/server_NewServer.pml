#define lb_for113_0  -1
#define ub_for113_1  -1
#define lb_for123_2  -1
#define ub_for123_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example540834745/server/server.go
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
	Chandef restartChan;
	int t_C = 5;
	int errChan = 5;
	Chandef errChan;
	Chandef eventChan;
	int eventChan = 5;
	bool state = false;
	Chandef eventErrChan;
	Chandef recoverChan;
	int eventErrChan = 5;
	int restartChan = 5;
	int s_extensions = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(errChan);
	run sync_monitor(eventErrChan);
	run sync_monitor(restartChan);
	run sync_monitor(recoverChan);
	run sync_monitor(eventChan);
	run Anonymous0(errChan,eventErrChan,restartChan,recoverChan,eventChan);
	run Anonymous1(errChan,eventErrChan,restartChan,recoverChan,eventChan);
	run Anonymous2(errChan,eventErrChan,restartChan,recoverChan,eventChan);
	run Anonymous5(errChan,eventErrChan,restartChan,recoverChan,eventChan);
	run Anonymous6(errChan,eventErrChan,restartChan,recoverChan,eventChan);
	
	if
	:: restartChan.async_send!0;
	:: restartChan.sync!0 -> 
		restartChan.sending?0
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errChan;Chandef eventErrChan;Chandef restartChan;Chandef recoverChan;Chandef eventChan) {
	bool closed; 
	int i;
	do
	:: eventErrChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			eventErrChan.in?0;
			
			if
			:: restartChan.async_send!0;
			:: restartChan.sync!0 -> 
				restartChan.sending?0
			fi
		fi
	od;
stop_process:
}
proctype Anonymous1(Chandef errChan;Chandef eventErrChan;Chandef restartChan;Chandef recoverChan;Chandef eventChan) {
	bool closed; 
	int i;
	do
	:: errChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			errChan.in?0;
			
			if
			:: true -> 
				
				if
				:: restartChan.async_send!0;
				:: restartChan.sync!0 -> 
					restartChan.sending?0
				fi
			:: true;
			fi
		fi
	od;
stop_process:
}
proctype Anonymous2(Chandef ch;Chandef errChan;Chandef eventErrChan;Chandef restartChan;Chandef recoverChan;Chandef eventChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for31:		
		if
		:: ch.async_rcv?0;
		:: ch.sync?0;
		fi;
		
		if
		:: eventErrChan.async_send!0;
		:: eventErrChan.sync!0 -> 
			eventErrChan.sending?0
		fi
	od;
for31_exit:stop_process:
}
proctype Anonymous3(Chandef ch;Chandef errChan;Chandef eventErrChan;Chandef restartChan;Chandef recoverChan;Chandef eventChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for32:		
		if
		:: ch.async_rcv?0;
		:: ch.sync?0;
		fi;
		
		if
		:: eventChan.async_send!0;
		:: eventChan.sync!0 -> 
			eventChan.sending?0
		fi
	od;
for32_exit:stop_process:
}
proctype Anonymous2(Chandef errChan;Chandef eventErrChan;Chandef restartChan;Chandef recoverChan;Chandef eventChan) {
	bool closed; 
	int i;
	do
	:: restartChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			restartChan.in?0;
			
			if
			:: true -> 
				run Anonymous2(evtErrChan,errChan,eventErrChan,restartChan,recoverChan,eventChan);
				run Anonymous3(evtChan,errChan,eventErrChan,restartChan,recoverChan,eventChan);
				
				if
				:: true -> 
					
					if
					:: errChan.async_send!0;
					:: errChan.sync!0 -> 
						errChan.sending?0
					fi
				:: true;
				fi
			:: true -> 
				run Anonymous2(evtErrChan,errChan,eventErrChan,restartChan,recoverChan,eventChan);
				run Anonymous3(evtChan,errChan,eventErrChan,restartChan,recoverChan,eventChan);
				
				if
				:: true -> 
					
					if
					:: errChan.async_send!0;
					:: errChan.sync!0 -> 
						errChan.sending?0
					fi
				:: true;
				fi
			fi;
			
			if
			:: eventChan.async_send!0;
			:: eventChan.sync!0 -> 
				eventChan.sending?0
			fi
		fi
	od;
stop_process:
}
proctype Anonymous5(Chandef errChan;Chandef eventErrChan;Chandef restartChan;Chandef recoverChan;Chandef eventChan) {
	bool closed; 
	int i;
	do
	:: eventChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			eventChan.in?0;
			do
			:: true -> 
for41:				
				if
				:: true -> 
					
					if
					:: errChan.async_send!0;
					:: errChan.sync!0 -> 
						errChan.sending?0
					fi
				:: true;
				fi
			:: true -> 
				break
			od
		fi
	od;
stop_process:
}
proctype Anonymous6(Chandef errChan;Chandef eventErrChan;Chandef restartChan;Chandef recoverChan;Chandef eventChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for50:
	:: true -> 
		break
	od;
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

