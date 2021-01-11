#define drainNode_pods  3
#define drainNode_daemonSetPods  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example835455615/cluster-autoscaler/core/scale_down.go
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
	Chandef daemonSetConfirmations;
	Chandef confirmations;
	bool state = false;
	int i;
	int daemonSetPods = drainNode_daemonSetPods;
	int pods = drainNode_pods;
	

	if
	:: pods > 0 -> 
		confirmations.size = pods;
		run AsyncChan(confirmations)
	:: else -> 
		run sync_monitor(confirmations)
	fi;
	

	if
	:: daemonSetPods > 0 -> 
		daemonSetConfirmations.size = daemonSetPods;
		run AsyncChan(daemonSetConfirmations)
	:: else -> 
		run sync_monitor(daemonSetConfirmations)
	fi;
		for(i : 0.. pods-1) {
		for10: skip;
		run go_Anonymous0(confirmations,daemonSetConfirmations);
		for10_end: skip
	};
	for10_exit: skip;
		for(i : 0.. daemonSetPods-1) {
		for20: skip;
		run go_Anonymous1(confirmations,daemonSetConfirmations);
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: 0 != -2 && pods + daemonSetPods-1 != -3 -> 
				for(i : 0.. pods + daemonSetPods-1) {
			for302268: skip;
			do
			:: confirmations.async_rcv?0 -> 
				break
			:: confirmations.sync?0 -> 
				break
			:: daemonSetConfirmations.async_rcv?0 -> 
				break
			:: daemonSetConfirmations.sync?0 -> 
				break
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			od;
			for30_end2268: skip
		};
		for30_exit2268: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			do
			:: confirmations.async_rcv?0 -> 
				break
			:: confirmations.sync?0 -> 
				break
			:: daemonSetConfirmations.async_rcv?0 -> 
				break
			:: daemonSetConfirmations.sync?0 -> 
				break
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			od;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef confirmations;Chandef daemonSetConfirmations) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: confirmations.async_send!0;
	:: confirmations.sync!0 -> 
		confirmations.sending?0
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef confirmations;Chandef daemonSetConfirmations) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: daemonSetConfirmations.async_send!0;
	:: daemonSetConfirmations.sync!0 -> 
		daemonSetConfirmations.sending?0
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

