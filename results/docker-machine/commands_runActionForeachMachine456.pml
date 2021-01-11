#define runActionForeachMachine_machines  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example406528255/commands/commands.go
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
	Chandef errorChan;
	bool state = false;
	int i;
	int numConcurrentActions=1;
	int machines = runActionForeachMachine_machines;
	run sync_monitor(errorChan);
		for(i : 0.. machines-1) {
		for10: skip;
		run go_machineCommand(errorChan);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && numConcurrentActions-1 != -3 -> 
				for(i : 0.. numConcurrentActions-1) {
			for20661: skip;
			

			if
			:: errorChan.async_rcv?0;
			:: errorChan.sync?0;
			fi;
			for20_end661: skip
		};
		for20_exit661: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: errorChan.async_rcv?0;
			:: errorChan.sync?0;
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	errorChan.closing!true;
	goto stop_process
stop_process:skip
}

proctype go_machineCommand(Chandef errorChan) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: errorChan.async_send!0;
	:: errorChan.sync!0 -> 
		errorChan.sending?0
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


