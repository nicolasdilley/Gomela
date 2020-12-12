
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example491159710/pkg/dockerclient/shell.go
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
	Chandef containerHealthy;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		containerHealthy.size = 1;
		run AsyncChan(containerHealthy)
	:: else -> 
		run sync_monitor(containerHealthy)
	fi;
	
	if
	:: true -> 
		Chandef timeoutChan;
		
		if
		:: 1 > 0 -> 
			timeoutChan.size = 1;
			run AsyncChan(timeoutChan)
		:: else -> 
			run sync_monitor(timeoutChan)
		fi
	fi;
	run Anonymous0(containerHealthy,timeoutChan);
	do
	:: containerHealthy.async_rcv?0 -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: containerHealthy.sync?0 -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: timeoutChan.async_rcv?0 -> 
		goto stop_process
	:: timeoutChan.sync?0 -> 
		goto stop_process
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef containerHealthy;Chandef timeoutChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for392_0 != -2 && ub_for392_1 != -2 -> 
				for(i : lb_for392_0.. ub_for392_1) {
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!0 -> 
						containerHealthy.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!0 -> 
						containerHealthy.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!0 -> 
						containerHealthy.sending?0
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
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!0 -> 
						containerHealthy.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!0 -> 
						containerHealthy.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!0 -> 
						containerHealthy.sending?0
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
for10_exit:stop_process:
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

