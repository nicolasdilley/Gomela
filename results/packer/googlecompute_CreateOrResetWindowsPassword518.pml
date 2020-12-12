
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example970072738/builder/googlecompute/driver_gce.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	int i;
	Chandef errCh;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		errCh.size = 1;
		run AsyncChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
	run go_createWindowsPassword(errCh);
	goto stop_process
stop_process:}

proctype go_createWindowsPassword(Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	int passwordResponses = -2;
	Chandef newErrCh;
	
	if
	:: true -> 
		
		if
		:: errCh.async_send!0;
		:: errCh.sync!0 -> 
			errCh.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errCh.async_send!0;
		:: errCh.sync!0 -> 
			errCh.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errCh.async_send!0;
		:: errCh.sync!0 -> 
			errCh.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		newErrCh.size = 1;
		run AsyncChan(newErrCh)
	:: else -> 
		run sync_monitor(newErrCh)
	fi;
	run go_googlecomputewaitForState(newErrCh);
	do
	:: newErrCh.async_rcv?0 -> 
		break
	:: newErrCh.sync?0 -> 
		break
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		
		if
		:: errCh.async_send!0;
		:: errCh.sync!0 -> 
			errCh.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for571_0 != -2 && ub_for571_1 != -2 -> 
				for(i : lb_for571_0.. ub_for571_1) {
for10:			
			if
			:: true -> 
								for(i : 0.. passwordResponses-1) {
for11:					
					if
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							goto stop_process
						:: true;
						fi;
						
						if
						:: true -> 
							
							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							goto stop_process
						:: true;
						fi;
						
						if
						:: errCh.async_send!0;
						:: errCh.sync!0 -> 
							errCh.sending?0
						fi;
						goto stop_process
					:: true;
					fi
				}
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
								for(i : 0.. passwordResponses-1) {
for11:					
					if
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							goto stop_process
						:: true;
						fi;
						
						if
						:: true -> 
							
							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							goto stop_process
						:: true;
						fi;
						
						if
						:: errCh.async_send!0;
						:: errCh.sync!0 -> 
							errCh.sending?0
						fi;
						goto stop_process
					:: true;
					fi
				}
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: errCh.async_send!0;
	:: errCh.sync!0 -> 
		errCh.sending?0
	fi;
	goto stop_process;
stop_process:
}
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
		  :: ch.sending!false;  // sending channel is open
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

