
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example516331819/cinterop/server.go
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
	Chandef connectionChan;
	Chandef exitChan;
	bool state = false;
	int i;
	run sync_monitor(exitChan);
	run sync_monitor(connectionChan);
	run go_messageOnCloseAndRun(exitChan);
	run go_listenAccept(connectionChan);
	do
	:: true -> 
		for20: skip;
		do
		:: exitChan.async_rcv?0 -> 
			goto stop_process
		:: exitChan.sync?0 -> 
			goto stop_process
		:: connectionChan.async_rcv?0 -> 
			break
		:: connectionChan.sync?0 -> 
			break
		od;
		for20_end: skip
	od;
	for20_exit: skip
stop_process:skip
}

proctype go_messageOnCloseAndRun(Chandef exitChan) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: exitChan.async_send!0;
	:: exitChan.sync!0 -> 
		exitChan.sending?0
	fi;
	stop_process: skip
}
proctype go_listenAccept(Chandef newConnection) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: newConnection.async_send!0;
			:: newConnection.sync!0 -> 
				newConnection.sending?0
			fi
		:: true -> 
			

			if
			:: newConnection.async_send!0;
			:: newConnection.sync!0 -> 
				newConnection.sending?0
			fi
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
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

