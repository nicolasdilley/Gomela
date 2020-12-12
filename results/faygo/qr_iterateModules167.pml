
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example632921472/ext/barcode/qr/encoder.go
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
	Chandef result;
	int i;
	Chandef allPoints;
	bool state = false;
	run sync_monitor(result);
	run sync_monitor(allPoints);
	run Anonymous0(result,allPoints);
	run Anonymous1(result,allPoints);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef result;Chandef allPoints) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for175_0 != -2 && ub_for175_1 != -2 -> 
				for(i : lb_for175_0.. ub_for175_1) {
for10:			
			if
			:: true -> 
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true;
				fi
			:: true -> 
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true;
				fi
			:: true -> 
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true;
				fi
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true;
				fi
			:: true -> 
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true;
				fi
			:: true -> 
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: allPoints.async_send!0;
				:: allPoints.sync!0 -> 
					allPoints.sending?0
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true;
				fi
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	allPoints.closing!true;
stop_process:
}
proctype Anonymous1(Chandef result;Chandef allPoints) {
	bool closed; 
	int i;
	bool state;
	do
	:: allPoints.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: allPoints.async_rcv?0;
			:: allPoints.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: result.async_send!0;
				:: result.sync!0 -> 
					result.sending?0
				fi
			:: true;
			fi
		fi
	od;
	result.closing!true;
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

