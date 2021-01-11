#define updateMessageDispositions_partitions  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example266186811/pubsub/azuresb/azuresb.go
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
	Chandef sem;
	bool state = false;
	int i;
	int partitions = updateMessageDispositions_partitions;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 5 > 0 -> 
		sem.size = 5;
		run AsyncChan(sem)
	:: else -> 
		run sync_monitor(sem)
	fi;
		for(i : 0.. partitions-1) {
		for20: skip;
		

		if
		:: sem.async_send!0;
		:: sem.sync!0 -> 
			sem.sending?0
		fi;
		run go_Anonymous0(sem);
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: 0 != -2 && 5-1 != -3 -> 
				for(i : 0.. 5-1) {
			for30899: skip;
			

			if
			:: sem.async_send!0;
			:: sem.sync!0 -> 
				sem.sending?0
			fi;
			for30_end899: skip
		};
		for30_exit899: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: sem.async_send!0;
			:: sem.sync!0 -> 
				sem.sending?0
			fi;
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

proctype go_Anonymous0(Chandef sem) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	

	if
	:: sem.async_rcv?0;
	:: sem.sync?0;
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

