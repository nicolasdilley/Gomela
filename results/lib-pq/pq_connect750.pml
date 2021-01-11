
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example936332045/notify.go
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
	chan child_resync1 = [0] of {int};
	chan child_pqnewDialListenerConn0 = [0] of {int};
	Chandef notificationChan;
	bool state = false;
	int i;
	

	if
	:: 32 > 0 -> 
		notificationChan.size = 32;
		run AsyncChan(notificationChan)
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
	run resync(notificationChan,child_resync1);
	child_resync1?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype pqnewDialListenerConn(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef l_replyChan;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 2 > 0 -> 
		l_replyChan.size = 2;
		run AsyncChan(l_replyChan)
	:: else -> 
		run sync_monitor(l_replyChan)
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype resync(Chandef notificationChan;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef doneChan;
	run sync_monitor(doneChan);
	run go_Anonymous2(notificationChan,doneChan);
	do
	:: true -> 
		for20: skip;
		do
		:: notificationChan.async_rcv?0 -> 
			break
		:: notificationChan.sync?0 -> 
			break
		:: doneChan.async_rcv?0 -> 
			goto stop_process
		:: doneChan.sync?0 -> 
			goto stop_process
		od;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip;
	child!0
}
proctype go_Anonymous2(Chandef notificationChan;Chandef doneChan) {
	bool closed; 
	int i;
	bool state;
	int l_channels=3;
	

	if
	:: l_channels-1 != -3 -> 
				for(i : 0.. l_channels-1) {
			for10: skip;
			

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
						fi;
						for11: skip;
						for11_end: skip
					fi
				od;
				for11_exit: skip;
				

				if
				:: doneChan.async_send!0;
				:: doneChan.sync!0 -> 
					doneChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for10724: skip;
			

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
						fi;
						for11724: skip;
						for11_end724: skip
					fi
				od;
				for11_exit724: skip;
				

				if
				:: doneChan.async_send!0;
				:: doneChan.sync!0 -> 
					doneChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			for10_end724: skip
		:: true -> 
			break
		od;
		for10_exit724: skip
	fi;
	

	if
	:: doneChan.async_send!0;
	:: doneChan.sync!0 -> 
		doneChan.sending?0
	fi;
	stop_process: skip
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


