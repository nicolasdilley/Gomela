
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example038828150/peer/brontide.go
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
	Chandef msgChan;
	Chandef readErr;
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
	:: 1 > 0 -> 
		readErr.size = 1;
		run AsyncChan(readErr)
	:: else -> 
		run sync_monitor(readErr)
	fi;
	

	if
	:: 1 > 0 -> 
		msgChan.size = 1;
		run AsyncChan(msgChan)
	:: else -> 
		run sync_monitor(msgChan)
	fi;
	run go_Anonymous0(readErr,msgChan);
	do
	:: true -> 
		goto stop_process
	:: readErr.async_rcv?0 -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: readErr.sync?0 -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	od;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef readErr;Chandef msgChan) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: readErr.async_send!0;
		:: readErr.sync!0 -> 
			readErr.sending?0
		fi;
		

		if
		:: msgChan.async_send!0;
		:: msgChan.sync!0 -> 
			msgChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: readErr.async_send!0;
	:: readErr.sync!0 -> 
		readErr.sending?0
	fi;
	

	if
	:: msgChan.async_send!0;
	:: msgChan.sync!0 -> 
		msgChan.sending?0
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

