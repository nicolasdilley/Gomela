
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example434979571/p2p/nat/natupnp.go
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
	Chandef found;
	bool state = false;
	int i;
	int cap12618=0;
	

	if
	:: 2 > 0 -> 
		found.size = 2;
		run AsyncChan(found)
	:: else -> 
		run sync_monitor(found)
	fi;
	run go_discover(found);
	run go_discover(found);
	

	if
	:: 0 != -2 && cap12618-1 != -3 -> 
				for(i : 0.. cap12618-1) {
			for201162: skip;
			

			if
			:: found.async_rcv?0;
			:: found.sync?0;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end1162: skip
		};
		for20_exit1162: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: found.async_rcv?0;
			:: found.sync?0;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_discover(Chandef out) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: out.async_send!0;
		:: out.sync!0 -> 
			out.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: out.async_send!0;
		:: out.sync!0 -> 
			out.sending?0
		fi
	:: true;
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


