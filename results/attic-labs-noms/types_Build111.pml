#define ub_for138_0  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example955070127/go/types/graph_builder.go
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
	Chandef graphOpChan;
	bool state = false;
	int i;
	

	if
	:: 512 > 0 -> 
		graphOpChan.size = 512;
		run AsyncChan(graphOpChan)
	:: else -> 
		run sync_monitor(graphOpChan)
	fi;
	run go_Anonymous0(graphOpChan);
	do
	:: graphOpChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: graphOpChan.async_rcv?0;
			:: graphOpChan.sync?0;
			fi;
			for20: skip;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef graphOpChan) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: 0 != -2 && ub_for138_0 != -2 -> 
				for(i : 0.. ub_for138_0) {
			for10410: skip;
			

			if
			:: graphOpChan.async_send!0;
			:: graphOpChan.sync!0 -> 
				graphOpChan.sending?0
			fi;
			for10_end410: skip
		};
		for10_exit410: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: graphOpChan.async_send!0;
			:: graphOpChan.sync!0 -> 
				graphOpChan.sending?0
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	graphOpChan.closing!true;
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

