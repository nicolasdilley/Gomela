#define lb_for729_0  -1
#define ub_for729_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example653423462/notify.go
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
	chan child_pqnewDialListenerConn0 = [0] of {int};
	Chandef notificationChan;
	chan child_lresync1 = [0] of {int};
	bool state = false;
	
	if
	:: 32 > 0 -> 
		notificationChan.size = 32;
		run emptyChan(notificationChan)
	:: else -> 
		run sync_monitor(notificationChan)
	fi;
	run pqnewDialListenerConn(notificationChan,child_pqnewDialListenerConn0);
	child_pqnewDialListenerConn0?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run lresync(notificationChan,child_lresync1);
	child_lresync1?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype pqnewDialListenerConn(Chandef c;chan child) {
	bool closed; 
	int i;
	Chandef l_replyChan;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 2 > 0 -> 
		l_replyChan.size = 2;
		run emptyChan(l_replyChan)
	:: else -> 
		run sync_monitor(l_replyChan)
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype lresync(Chandef notificationChan;chan child) {
	bool closed; 
	int i;
	Chandef doneChan;
	run sync_monitor(doneChan);
	run Anonymous2(notificationChan,doneChan);
	do
	:: true -> 
for20:		do
		od
	od;
for20_exit:	child!0;
stop_process:
}
proctype Anonymous2(Chandef notificationChan;Chandef doneChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: doneChan.async_send!0;
			:: doneChan.sync!0 -> 
				doneChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			do
			:: notificationChan.is_closed?state -> 
				if
				:: state -> 
					break
				:: else -> 
					
					if
					:: notificationChan.async_rcv?0;
					:: notificationChan.sync?0;
					fi
				fi
			od;
			
			if
			:: doneChan.async_send!0;
			:: doneChan.sync!0 -> 
				doneChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	:: true -> 
		break
	od;
	
	if
	:: doneChan.async_send!0;
	:: doneChan.sync!0 -> 
		doneChan.sending?0
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

