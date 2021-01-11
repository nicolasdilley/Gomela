
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example787360445/cmd/dlv/cmds/commands.go
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
	chan child_cmdswaitForDisconnectSignal0 = [0] of {int};
	Chandef disconnectChan;
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
	run sync_monitor(disconnectChan);
	run cmdswaitForDisconnectSignal(disconnectChan,child_cmdswaitForDisconnectSignal0);
	child_cmdswaitForDisconnectSignal0?0;
	goto stop_process
stop_process:skip
}

proctype cmdswaitForDisconnectSignal(Chandef disconnectChan;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef ch;
	

	if
	:: 1 > 0 -> 
		ch.size = 1;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	do
	:: ch.async_send!0 -> 
		break
	:: ch.sync!0 -> 
		ch.sending?0;
		break
	:: true -> 
		break
	od;
	

	if
	:: true -> 
		run go_Anonymous1(ch,disconnectChan);
		do
		:: disconnectChan.async_rcv?0 -> 
			break
		:: disconnectChan.sync?0 -> 
			break
		od
	:: true -> 
		do
		:: ch.async_rcv?0 -> 
			break
		:: ch.sync?0 -> 
			break
		:: disconnectChan.async_rcv?0 -> 
			break
		:: disconnectChan.sync?0 -> 
			break
		od
	:: true -> 
		do
		:: ch.async_rcv?0 -> 
			break
		:: ch.sync?0 -> 
			break
		:: disconnectChan.async_rcv?0 -> 
			break
		:: disconnectChan.sync?0 -> 
			break
		od
	fi;
	stop_process: skip;
	child!0
}
proctype go_Anonymous1(Chandef ch;Chandef disconnectChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for10: skip;
		do
		:: ch.async_rcv?0 -> 
			break
		:: ch.sync?0 -> 
			break
		od;
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

