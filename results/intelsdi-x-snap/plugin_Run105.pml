#define ub_for124_0  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example954442152/control/plugin/execution.go
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
	Chandef doneChan;
	bool state = false;
	int i;
	run sync_monitor(doneChan);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run go_Anonymous0(doneChan);
	do
	:: doneChan.async_rcv?0 -> 
		break
	:: doneChan.sync?0 -> 
		break
	:: true -> 
		break
	od;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef doneChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for10: skip;
		

		if
		:: 0 != -2 && ub_for124_0 != -2 -> 
						for(i : 0.. ub_for124_0) {
				for111529: skip;
				

				if
				:: true -> 
					doneChan.closing!true
				fi;
				for11_end1529: skip
			};
			for11_exit1529: skip
		:: else -> 
			do
			:: true -> 
				for11: skip;
				

				if
				:: true -> 
					doneChan.closing!true
				fi;
				for11_end: skip
			:: true -> 
				break
			od;
			for11_exit: skip
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				break
			:: true;
			fi;
			goto for11_end
		:: true;
		fi;
		break;
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

