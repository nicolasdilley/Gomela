
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example908187661/actor/pushaction/apply.go
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
	Chandef eventStream;
	int i;
	Chandef errorStream;
	Chandef configStream;
	Chandef warningsStream;
	int PushRetries = 5;
	bool state = false;
	run sync_monitor(configStream);
	run sync_monitor(eventStream);
	run sync_monitor(warningsStream);
	run sync_monitor(errorStream);
	run Anonymous0(configStream,eventStream,warningsStream,errorStream);
	goto stop_process
stop_process:}

proctype actorUploadDroplet(Chandef eventStream;chan child) {
	bool closed; 
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
	:: eventStream.async_send!0;
	:: eventStream.sync!0 -> 
		eventStream.sending?0
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: eventStream.async_send!0;
	:: eventStream.sync!0 -> 
		eventStream.sending?0
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype actorUploadPackageWithArchive(Chandef eventStream;chan child) {
	bool closed; 
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
	:: eventStream.async_send!0;
	:: eventStream.sync!0 -> 
		eventStream.sending?0
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: eventStream.async_send!0;
	:: eventStream.sync!0 -> 
		eventStream.sending?0
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef configStream;Chandef eventStream;Chandef warningsStream;Chandef errorStream) {
	bool closed; 
	int i;
	
	if
	:: eventStream.async_send!0;
	:: eventStream.sync!0 -> 
		eventStream.sending?0
	fi;
	
	if
	:: warningsStream.async_send!0;
	:: warningsStream.sync!0 -> 
		warningsStream.sending?0
	fi;
	
	if
	:: true -> 
		
		if
		:: errorStream.async_send!0;
		:: errorStream.sync!0 -> 
			errorStream.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: eventStream.async_send!0;
	:: eventStream.sync!0 -> 
		eventStream.sending?0
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: eventStream.async_send!0;
			:: eventStream.sync!0 -> 
				eventStream.sending?0
			fi;
			
			if
			:: warningsStream.async_send!0;
			:: warningsStream.sync!0 -> 
				warningsStream.sending?0
			fi;
			
			if
			:: true -> 
				
				if
				:: errorStream.async_send!0;
				:: errorStream.sync!0 -> 
					errorStream.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true -> 
		
		if
		:: eventStream.async_send!0;
		:: eventStream.sync!0 -> 
			eventStream.sending?0
		fi;
		
		if
		:: warningsStream.async_send!0;
		:: warningsStream.sync!0 -> 
			warningsStream.sending?0
		fi;
		
		if
		:: true -> 
			
			if
			:: errorStream.async_send!0;
			:: errorStream.sync!0 -> 
				errorStream.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: eventStream.async_send!0;
			:: eventStream.sync!0 -> 
				eventStream.sending?0
			fi
		:: true;
		fi;
		
		if
		:: warningsStream.async_send!0;
		:: warningsStream.sync!0 -> 
			warningsStream.sending?0
		fi;
		
		if
		:: true -> 
			
			if
			:: errorStream.async_send!0;
			:: errorStream.sync!0 -> 
				errorStream.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: eventStream.async_send!0;
			:: eventStream.sync!0 -> 
				eventStream.sending?0
			fi
		:: true;
		fi
	:: true -> 
		
		if
		:: eventStream.async_send!0;
		:: eventStream.sync!0 -> 
			eventStream.sending?0
		fi;
		
		if
		:: warningsStream.async_send!0;
		:: warningsStream.sync!0 -> 
			warningsStream.sending?0
		fi;
		
		if
		:: true -> 
			
			if
			:: errorStream.async_send!0;
			:: errorStream.sync!0 -> 
				errorStream.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: eventStream.async_send!0;
			:: eventStream.sync!0 -> 
				eventStream.sending?0
			fi
		:: true;
		fi;
		
		if
		:: warningsStream.async_send!0;
		:: warningsStream.sync!0 -> 
			warningsStream.sending?0
		fi;
		
		if
		:: true -> 
			
			if
			:: errorStream.async_send!0;
			:: errorStream.sync!0 -> 
				errorStream.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: eventStream.async_send!0;
			:: eventStream.sync!0 -> 
				eventStream.sending?0
			fi
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		
		if
		:: eventStream.async_send!0;
		:: eventStream.sync!0 -> 
			eventStream.sending?0
		fi;
		
		if
		:: warningsStream.async_send!0;
		:: warningsStream.sync!0 -> 
			warningsStream.sending?0
		fi;
		
		if
		:: true -> 
			
			if
			:: errorStream.async_send!0;
			:: errorStream.sync!0 -> 
				errorStream.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: eventStream.async_send!0;
		:: eventStream.sync!0 -> 
			eventStream.sending?0
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: 0 != -1 && PushRetries-1 != -1 -> 
						for(i : 0.. PushRetries-1) {
for10:				chan child_actorUploadDroplet0 = [0] of {int};
				run actorUploadDroplet(eventStream,child_actorUploadDroplet0);
				child_actorUploadDroplet0?0;
				
				if
				:: warningsStream.async_send!0;
				:: warningsStream.sync!0 -> 
					warningsStream.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: eventStream.async_send!0;
					:: eventStream.sync!0 -> 
						eventStream.sending?0
					fi
				:: true -> 
					break
				:: true -> 
					break
				fi
			}
		:: else -> 
			do
			:: true -> 
for10:				chan child_actorUploadDroplet0 = [0] of {int};
				run actorUploadDroplet(eventStream,child_actorUploadDroplet0);
				child_actorUploadDroplet0?0;
				
				if
				:: warningsStream.async_send!0;
				:: warningsStream.sync!0 -> 
					warningsStream.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: eventStream.async_send!0;
					:: eventStream.sync!0 -> 
						eventStream.sending?0
					fi
				:: true -> 
					break
				:: true -> 
					break
				fi
			:: true -> 
				break
			od
		fi;
for10_exit:		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errorStream.async_send!0;
				:: errorStream.sync!0 -> 
					errorStream.sending?0
				fi
			:: true -> 
				
				if
				:: errorStream.async_send!0;
				:: errorStream.sync!0 -> 
					errorStream.sending?0
				fi
			:: true -> 
				
				if
				:: errorStream.async_send!0;
				:: errorStream.sync!0 -> 
					errorStream.sending?0
				fi
			fi;
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: eventStream.async_send!0;
			:: eventStream.sync!0 -> 
				eventStream.sending?0
			fi;
			
			if
			:: warningsStream.async_send!0;
			:: warningsStream.sync!0 -> 
				warningsStream.sending?0
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: errorStream.async_send!0;
					:: errorStream.sync!0 -> 
						errorStream.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				
				if
				:: eventStream.async_send!0;
				:: eventStream.sync!0 -> 
					eventStream.sending?0
				fi;
				
				if
				:: 0 != -1 && PushRetries-1 != -1 -> 
										for(i : 0.. PushRetries-1) {
for20:						chan child_actorUploadPackageWithArchive1 = [0] of {int};
						run actorUploadPackageWithArchive(eventStream,child_actorUploadPackageWithArchive1);
						child_actorUploadPackageWithArchive1?0;
						
						if
						:: warningsStream.async_send!0;
						:: warningsStream.sync!0 -> 
							warningsStream.sending?0
						fi;
						
						if
						:: true -> 
							
							if
							:: eventStream.async_send!0;
							:: eventStream.sync!0 -> 
								eventStream.sending?0
							fi
						:: true -> 
							break
						:: true -> 
							break
						fi
					}
				:: else -> 
					do
					:: true -> 
for20:						chan child_actorUploadPackageWithArchive1 = [0] of {int};
						run actorUploadPackageWithArchive(eventStream,child_actorUploadPackageWithArchive1);
						child_actorUploadPackageWithArchive1?0;
						
						if
						:: warningsStream.async_send!0;
						:: warningsStream.sync!0 -> 
							warningsStream.sending?0
						fi;
						
						if
						:: true -> 
							
							if
							:: eventStream.async_send!0;
							:: eventStream.sync!0 -> 
								eventStream.sending?0
							fi
						:: true -> 
							break
						:: true -> 
							break
						fi
					:: true -> 
						break
					od
				fi;
for20_exit:				
				if
				:: true -> 
					
					if
					:: true -> 
						
						if
						:: errorStream.async_send!0;
						:: errorStream.sync!0 -> 
							errorStream.sending?0
						fi
					:: true -> 
						
						if
						:: errorStream.async_send!0;
						:: errorStream.sync!0 -> 
							errorStream.sending?0
						fi
					:: true -> 
						
						if
						:: errorStream.async_send!0;
						:: errorStream.sync!0 -> 
							errorStream.sending?0
						fi
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: eventStream.async_send!0;
				:: eventStream.sync!0 -> 
					eventStream.sending?0
				fi;
				
				if
				:: warningsStream.async_send!0;
				:: warningsStream.sync!0 -> 
					warningsStream.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: errorStream.async_send!0;
					:: errorStream.sync!0 -> 
						errorStream.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: eventStream.async_send!0;
				:: eventStream.sync!0 -> 
					eventStream.sending?0
				fi;
				
				if
				:: warningsStream.async_send!0;
				:: warningsStream.sync!0 -> 
					warningsStream.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: errorStream.async_send!0;
					:: errorStream.sync!0 -> 
						errorStream.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			fi
		fi
	fi;
	
	if
	:: configStream.async_send!0;
	:: configStream.sync!0 -> 
		configStream.sending?0
	fi;
	
	if
	:: eventStream.async_send!0;
	:: eventStream.sync!0 -> 
		eventStream.sending?0
	fi;
	configStream.closing!true;
	eventStream.closing!true;
	warningsStream.closing!true;
	errorStream.closing!true;
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

