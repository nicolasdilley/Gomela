#define lb_for382_0  -1
#define ub_for382_1  -1
#define lb_for296_2  -1
#define ub_for296_3  -1
#define lb_for165_4  -1
#define ub_for165_5  -1
#define lb_for190_6  -1
#define ub_for190_7  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example716246246/apiserver/apiserver.go
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
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
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
		Chandef errCh;
		run sync_monitor(errCh);
		Chandef workerDoneCh;
		run sync_monitor(workerDoneCh);
		run go_apiserverreplyStreamWorker(errCh,workerDoneCh);
		
		if
		:: true -> 
			
			if
			:: lb_for165_4 != -1 && ub_for165_5 != -1 -> 
								for(i : lb_for165_4.. ub_for165_5) {
for30:					
					if
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							
							if
							:: workerDoneCh.async_rcv?0;
							:: workerDoneCh.sync?0;
							fi;
							goto stop_process
						:: true -> 
							
							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							
							if
							:: workerDoneCh.async_rcv?0;
							:: workerDoneCh.sync?0;
							fi;
							goto stop_process
						fi
					:: true;
					fi;
					
					if
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							
							if
							:: workerDoneCh.async_rcv?0;
							:: workerDoneCh.sync?0;
							fi;
							goto stop_process
						:: true;
						fi
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for30:					
					if
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							
							if
							:: workerDoneCh.async_rcv?0;
							:: workerDoneCh.sync?0;
							fi;
							goto stop_process
						:: true -> 
							
							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							
							if
							:: workerDoneCh.async_rcv?0;
							:: workerDoneCh.sync?0;
							fi;
							goto stop_process
						fi
					:: true;
					fi;
					
					if
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							
							if
							:: workerDoneCh.async_rcv?0;
							:: workerDoneCh.sync?0;
							fi;
							goto stop_process
						:: true;
						fi
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for30_exit:
		:: true -> 
			
			if
			:: lb_for190_6 != -1 && ub_for190_7 != -1 -> 
								for(i : lb_for190_6.. ub_for190_7) {
for40:					
					if
					:: true -> 
						
						if
						:: errCh.async_send!0;
						:: errCh.sync!0 -> 
							errCh.sending?0
						fi;
						
						if
						:: workerDoneCh.async_rcv?0;
						:: workerDoneCh.sync?0;
						fi;
						goto stop_process
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for40:					
					if
					:: true -> 
						
						if
						:: errCh.async_send!0;
						:: errCh.sync!0 -> 
							errCh.sending?0
						fi;
						
						if
						:: workerDoneCh.async_rcv?0;
						:: workerDoneCh.sync?0;
						fi;
						goto stop_process
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for40_exit:
		:: true -> 
			
			if
			:: lb_for190_6 != -1 && ub_for190_7 != -1 -> 
								for(i : lb_for190_6.. ub_for190_7) {
for40:					
					if
					:: true -> 
						
						if
						:: errCh.async_send!0;
						:: errCh.sync!0 -> 
							errCh.sending?0
						fi;
						
						if
						:: workerDoneCh.async_rcv?0;
						:: workerDoneCh.sync?0;
						fi;
						goto stop_process
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for40:					
					if
					:: true -> 
						
						if
						:: errCh.async_send!0;
						:: errCh.sync!0 -> 
							errCh.sending?0
						fi;
						
						if
						:: workerDoneCh.async_rcv?0;
						:: workerDoneCh.sync?0;
						fi;
						goto stop_process
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for40_exit:
		fi;
		
		if
		:: true -> 
			
			if
			:: errCh.async_send!0;
			:: errCh.sync!0 -> 
				errCh.sending?0
			fi;
			
			if
			:: workerDoneCh.async_rcv?0;
			:: workerDoneCh.sync?0;
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: errCh.async_send!0;
		:: errCh.sync!0 -> 
			errCh.sending?0
		fi;
		
		if
		:: workerDoneCh.async_rcv?0;
		:: workerDoneCh.sync?0;
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			fi
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			fi
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi
stop_process:}

proctype go_apiserverreplyStreamWorker(Chandef errCh;Chandef workerDoneCh) {
	bool closed; 
	int i;
	Chandef receiveCh;
	Chandef receiveErrCh;
	run sync_monitor(receiveCh);
	run sync_monitor(receiveErrCh);
	run go_apiserverstreamReceiveWorker(receiveCh,receiveErrCh);
	do
	:: true -> 
for20:		do
		od
	od;
for20_exit:	workerDoneCh.closing!true;
stop_process:
}
proctype go_apiserverstreamReceiveWorker(Chandef receiveCh;Chandef receiveErrCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: receiveErrCh.async_send!0;
			:: receiveErrCh.sync!0 -> 
				receiveErrCh.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: receiveCh.async_send!0;
		:: receiveCh.sync!0 -> 
			receiveCh.sending?0
		fi
	od;
for10_exit:stop_process:
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

