#define leaseKeepaliveFunc_clients  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example420310086/tools/benchmark/cmd/lease.go
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
	Chandef requests;
	bool state = false;
	int i;
	int clients = leaseKeepaliveFunc_clients;
	run sync_monitor(requests);
		for(i : 0.. clients-1) {
		for10: skip;
		run go_Anonymous0(requests);
		for10_end: skip
	};
	for10_exit: skip;
	run go_Anonymous1(requests)
stop_process:skip
}

proctype go_Anonymous0(Chandef requests) {
	bool closed; 
	int i;
	bool state;
	do
	:: requests.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: requests.async_rcv?0;
			:: requests.sync?0;
			fi;
			for11: skip;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
	stop_process: skip
}
proctype go_Anonymous1(Chandef requests) {
	bool closed; 
	int i;
	bool state;
	int leaseKeepaliveTotal = -2;
	

	if
	:: 0 != -2 && leaseKeepaliveTotal-1 != -3 -> 
				for(i : 0.. leaseKeepaliveTotal-1) {
			for20137: skip;
			

			if
			:: requests.async_send!0;
			:: requests.sync!0 -> 
				requests.sending?0
			fi;
			for20_end137: skip
		};
		for20_exit137: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: requests.async_send!0;
			:: requests.sync!0 -> 
				requests.sending?0
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	requests.closing!true;
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

