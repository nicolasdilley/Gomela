#define multiSort_ts_Order  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example249574541/worker/sort.go
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
	Chandef och;
	bool state = false;
	int i;
	int ts_Order = multiSort_ts_Order;
	

	if
	:: ts_Order - 1 > 0 -> 
		och.size = ts_Order - 1;
		run AsyncChan(och)
	:: else -> 
		run sync_monitor(och)
	fi;
		for(i : 1.. ts_Order-1) {
		for30: skip;
		run go_fetchValues(och);
		for30_end: skip
	};
	for30_exit: skip;
	

	if
	:: 1 != -2 && ts_Order-1 != -3 -> 
				for(i : 1.. ts_Order-1) {
			for40573: skip;
			

			if
			:: och.async_rcv?0;
			:: och.sync?0;
			fi;
			

			if
			:: true -> 
				goto for40_end573
			:: true;
			fi;
			for40_end573: skip
		};
		for40_exit573: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			

			if
			:: och.async_rcv?0;
			:: och.sync?0;
			fi;
			

			if
			:: true -> 
				goto for40_end
			:: true;
			fi;
			for40_end: skip
		:: true -> 
			break
		od;
		for40_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_fetchValues(Chandef or) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: or.async_send!0;
	:: or.sync!0 -> 
		or.sending?0
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

