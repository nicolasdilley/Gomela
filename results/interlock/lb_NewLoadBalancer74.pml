
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example000724142/ext/lb/lb.go
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
	Chandef lbUpdateChan;
	Chandef errChan;
	Chandef proxyNetworkCleanupChan;
	bool state = false;
	run sync_monitor(errChan);
	run Anonymous0(errChan,lbUpdateChan,proxyNetworkCleanupChan);
	run sync_monitor(lbUpdateChan);
	run sync_monitor(proxyNetworkCleanupChan);
	
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
	run Anonymous1(errChan,lbUpdateChan,proxyNetworkCleanupChan);
	run Anonymous2(errChan,lbUpdateChan,proxyNetworkCleanupChan);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errChan;Chandef lbUpdateChan;Chandef proxyNetworkCleanupChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: errChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: errChan.async_rcv?0;
			:: errChan.sync?0;
			fi
		fi
	od;
stop_process:
}
proctype Anonymous1(Chandef errChan;Chandef lbUpdateChan;Chandef proxyNetworkCleanupChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		
		if
		:: proxyNetworkCleanupChan.async_rcv?0;
		:: proxyNetworkCleanupChan.sync?0;
		fi;
		do
		:: true -> 
for21:			do
			:: true -> 
for22:				
				if
				:: true -> 
					
					if
					:: 0 != -2 && retries-1 != -3 -> 
												for(i : 0.. retries-1) {
for23:							
							if
							:: true -> 
								break
							:: true;
							fi
						}
					:: else -> 
						do
						:: true -> 
for23:							
							if
							:: true -> 
								break
							:: true;
							fi
						:: true -> 
							break
						od
					fi;
for23_exit:
				:: true;
				fi
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	od;
for20_exit:stop_process:
}
proctype Anonymous2(Chandef errChan;Chandef lbUpdateChan;Chandef proxyNetworkCleanupChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: lbUpdateChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: lbUpdateChan.async_rcv?0;
			:: lbUpdateChan.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi
			:: true;
			fi;
			do
			:: true -> 
for31:				do
				:: true -> 
for32:
				:: true -> 
					break
				od
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi
			:: true;
			fi
		fi
	od;
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

