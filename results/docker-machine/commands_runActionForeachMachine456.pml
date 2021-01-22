#define runActionForeachMachine_machines  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example737854991/commands/commands.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef errorChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int numConcurrentActions=0;
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
			for20684: skip;
			

			if
			:: errorChan.async_rcv?state,num_msgs;
			:: errorChan.sync?state,num_msgs;
			fi;
			for20_end684: skip
		};
		for20_exit684: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: errorChan.async_rcv?state,num_msgs;
			:: errorChan.sync?state,num_msgs;
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
	int num_msgs;
	

	if
	:: errorChan.async_send!0;
	:: errorChan.sync!false,0 -> 
		errorChan.sending?state
	fi;
	stop_process: skip
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}


