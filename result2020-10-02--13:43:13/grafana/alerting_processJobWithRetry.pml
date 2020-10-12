#define lb_for125_0  -1
#define ub_for125_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example116963038/pkg/services/alerting/engine.go
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
	Chandef attemptChan;
	Chandef cancelChan;
	int setting_AlertingMaxAttempts = 5;
	bool state = false;
	
	if
	:: setting_AlertingMaxAttempts * 2 > 0 -> 
		cancelChan.size = setting_AlertingMaxAttempts * 2;
		run emptyChan(cancelChan)
	:: else -> 
		run sync_monitor(cancelChan)
	fi;
	
	if
	:: 1 > 0 -> 
		attemptChan.size = 1;
		run emptyChan(attemptChan)
	:: else -> 
		run sync_monitor(attemptChan)
	fi;
	
	if
	:: attemptChan.async_send!0;
	:: attemptChan.sync!0 -> 
		attemptChan.sending?0
	fi;
		for(i : lb_for125_0.. ub_for125_1) {
for10:		do
		:: true -> 
			do
			:: true -> 
				chan child_eendJob0 = [0] of {int};
				run eendJob(cancelChan,child_eendJob0);
				child_eendJob0?0;
				goto stop_process
			:: attemptChan.async_rcv?0 -> 
				chan child_eendJob1 = [0] of {int};
				run eendJob(cancelChan,child_eendJob1);
				child_eendJob1?0;
				goto stop_process
			:: attemptChan.sync?0 -> 
				chan child_eendJob1 = [0] of {int};
				run eendJob(cancelChan,child_eendJob1);
				child_eendJob1?0;
				goto stop_process
			od
		od
	};
for10_exit:
stop_process:}

proctype eendJob(Chandef cancelChan;chan child) {
	bool closed; 
	int i;
	cancelChan.closing!true;
	do
	:: cancelChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: cancelChan.async_rcv?0;
			:: cancelChan.sync?0;
			fi
		fi
	od;
	goto stop_process;
	child!0;
stop_process:
}
proctype go_eprocessJob(Chandef attemptChan;Chandef cancelChan) {
	bool closed; 
	int i;
	
	if
	:: cancelChan.async_send!0;
	:: cancelChan.sync!0 -> 
		cancelChan.sending?0
	fi;
	run Anonymous2(attemptChan,cancelChan);
stop_process:
}
proctype Anonymous2(Chandef attemptChan;Chandef cancelChan) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: attemptChan.async_send!0;
			:: attemptChan.sync!0 -> 
				attemptChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: cancelChan.async_send!0;
	:: cancelChan.sync!0 -> 
		cancelChan.sending?0
	fi;
	
	if
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true;
		fi
	:: true;
	fi;
	attemptChan.closing!true;
	
	if
	:: true -> 
		attemptChan.closing!true
	:: true;
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
