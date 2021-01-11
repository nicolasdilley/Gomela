
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example434979571/p2p/simulations/network.go
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
	Chandef events;
	Chandef done;
	Chandef allConnected;
	bool state = false;
	int i;
	int snap_Conns=3;
	run sync_monitor(allConnected);
	run sync_monitor(done);
	run sync_monitor(events);
	run go_Anonymous0(allConnected,done,events,snap_Conns);
	do
	:: allConnected.async_rcv?0 -> 
		break
	:: allConnected.sync?0 -> 
		break
	:: true -> 
		goto stop_process
	od;
	goto stop_process;
	done.closing!true
stop_process:skip
}

proctype go_Anonymous0(Chandef allConnected;Chandef done;Chandef events;int snap_Conns) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for20: skip;
		do
		:: events.async_rcv?0 -> 
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			

			if
			:: snap_Conns-1 != -3 -> 
								for(i : 0.. snap_Conns-1) {
					for21: skip;
					

					if
					:: true -> 
						

						if
						:: true -> 
							allConnected.closing!true;
							goto stop_process
						:: true;
						fi;
						break
					:: true;
					fi;
					for21_end: skip
				};
				for21_exit: skip
			:: else -> 
				do
				:: true -> 
					for211138: skip;
					

					if
					:: true -> 
						

						if
						:: true -> 
							allConnected.closing!true;
							goto stop_process
						:: true;
						fi;
						break
					:: true;
					fi;
					for21_end1138: skip
				:: true -> 
					break
				od;
				for21_exit1138: skip
			fi;
			break
		:: events.sync?0 -> 
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			

			if
			:: snap_Conns-1 != -3 -> 
								for(i : 0.. snap_Conns-1) {
					for211139: skip;
					

					if
					:: true -> 
						

						if
						:: true -> 
							allConnected.closing!true;
							goto stop_process
						:: true;
						fi;
						break
					:: true;
					fi;
					for21_end1139: skip
				};
				for21_exit1139: skip
			:: else -> 
				do
				:: true -> 
					for2111381139: skip;
					

					if
					:: true -> 
						

						if
						:: true -> 
							allConnected.closing!true;
							goto stop_process
						:: true;
						fi;
						break
					:: true;
					fi;
					for21_end11381139: skip
				:: true -> 
					break
				od;
				for21_exit11381139: skip
			fi;
			break
		:: done.async_rcv?0 -> 
			goto stop_process
		:: done.sync?0 -> 
			goto stop_process
		od;
		for20_end: skip
	od;
	for20_exit: skip;
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


