#define RefreshTopologyInstances_instances  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example245190199/go/vt/orchestrator/inst/instance_topology_dao.go
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
	Chandef barrier;
	bool state = false;
	int i;
	int instances = RefreshTopologyInstances_instances;
	run sync_monitor(barrier);
		for(i : 0.. instances-1) {
		for10: skip;
		run go_Anonymous0(barrier);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: instances-1 != -3 -> 
				for(i : 0.. instances-1) {
			for20: skip;
			

			if
			:: barrier.async_rcv?0;
			:: barrier.sync?0;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20428: skip;
			

			if
			:: barrier.async_rcv?0;
			:: barrier.sync?0;
			fi;
			for20_end428: skip
		:: true -> 
			break
		od;
		for20_exit428: skip
	fi
stop_process:skip
}

proctype go_Anonymous0(Chandef barrier) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	

	if
	:: barrier.async_send!0;
	:: barrier.sync!0 -> 
		barrier.sending?0
	fi
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

