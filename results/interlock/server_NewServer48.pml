
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example000724142/server/server.go
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
	Chandef errChan;
	Chandef eventChan;
	Chandef restartChan;
	bool state = false;
	Chandef eventErrChan;
	Chandef recoverChan;
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
	run Anonymous3(errChan,eventErrChan,restartChan,recoverChan,eventChan);
	run Anonymous4(errChan,eventErrChan,restartChan,recoverChan,eventChan);
	
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
	bool state;
	do
	:: eventErrChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: eventErrChan.async_rcv?0;
			:: eventErrChan.sync?0;
			fi;
			
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
			fi;
			
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
proctype Anonymous2(Chandef errChan;Chandef eventErrChan;Chandef restartChan;Chandef recoverChan;Chandef eventChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: restartChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: restartChan.async_rcv?0;
			:: restartChan.sync?0;
			fi;
			
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
proctype Anonymous3(Chandef errChan;Chandef eventErrChan;Chandef restartChan;Chandef recoverChan;Chandef eventChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: eventChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: eventChan.async_rcv?0;
			:: eventChan.sync?0;
			fi;
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
proctype Anonymous4(Chandef errChan;Chandef eventErrChan;Chandef restartChan;Chandef recoverChan;Chandef eventChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for50:
	:: true -> 
		break
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

