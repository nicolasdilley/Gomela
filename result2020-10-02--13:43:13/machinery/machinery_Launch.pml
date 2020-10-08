#define lb_for77_0  -1
#define ub_for77_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example722220022/v2/worker.go
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
	Chandef errorsChan;
	int i;
	chan child_workerLaunchAsync0 = [0] of {int};
	bool state = false;
	run sync_monitor(errorsChan);
	run workerLaunchAsync(errorsChan,child_workerLaunchAsync0);
	child_workerLaunchAsync0?0;
	
	if
	:: errorsChan.async_rcv?0;
	:: errorsChan.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype workerLaunchAsync(Chandef errorsChan;chan child) {
	bool closed; 
	int i;
	Wgdef signalWG;
	run wgMonitor(signalWG);
	run Anonymous1(sig,errorsChan,signalWG);
	
	if
	:: true -> 
		Chandef sig;
		
		if
		:: 1 > 0 -> 
			sig.size = 1;
			run emptyChan(sig)
		:: else -> 
			run sync_monitor(sig)
		fi;
		run Anonymous2(sig,errorsChan,signalWG)
	:: true;
	fi;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef sig;Chandef errorsChan;Wgdef signalWG) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			signalWG.Wait?0;
			
			if
			:: errorsChan.async_send!0;
			:: errorsChan.sync!0 -> 
				errorsChan.sending?0
			fi;
			goto stop_process
		:: true -> 
			signalWG.Wait?0;
			
			if
			:: errorsChan.async_send!0;
			:: errorsChan.sync!0 -> 
				errorsChan.sending?0
			fi;
			goto stop_process
		fi
	od;
for10_exit:stop_process:
}
proctype Anonymous2(Chandef sig;Chandef errorsChan;Wgdef signalWG) {
	bool closed; 
	int i;
	
	if
	:: errorsChan.async_send!0;
	:: errorsChan.sync!0 -> 
		errorsChan.sending?0
	fi;
	signalWG.Add!-1;
stop_process:
}
proctype Anonymous2(Chandef sig;Chandef errorsChan;Wgdef signalWG) {
	bool closed; 
	int i;
	do
	:: sig.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: sig.async_rcv?0;
			:: sig.sync?0;
			fi;
			
			if
			:: true -> 
				signalWG.Add!1;
				run Anonymous2(sig,errorsChan,signalWG)
			:: true -> 
				
				if
				:: errorsChan.async_send!0;
				:: errorsChan.sync!0 -> 
					errorsChan.sending?0
				fi
			:: true -> 
				
				if
				:: errorsChan.async_send!0;
				:: errorsChan.sync!0 -> 
					errorsChan.sending?0
				fi
			fi
		fi
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

