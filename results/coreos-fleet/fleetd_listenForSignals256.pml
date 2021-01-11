#define listenForSignals_sigmap  3
#define ub_for263_1  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example207195478/fleetd/fleetd.go
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
	Chandef sigchan;
	bool state = false;
	int i;
	int sigmap = listenForSignals_sigmap;
	

	if
	:: 1 > 0 -> 
		sigchan.size = 1;
		run AsyncChan(sigchan)
	:: else -> 
		run sync_monitor(sigchan)
	fi;
	

	if
	:: sigmap-1 != -3 -> 
				for(i : 0.. sigmap-1) {
			for10: skip;
			do
			:: sigchan.async_send!0 -> 
				break
			:: sigchan.sync!0 -> 
				sigchan.sending?0;
				break
			:: true -> 
				break
			od;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for101217: skip;
			do
			:: sigchan.async_send!0 -> 
				break
			:: sigchan.sync!0 -> 
				sigchan.sending?0;
				break
			:: true -> 
				break
			od;
			for10_end1217: skip
		:: true -> 
			break
		od;
		for10_exit1217: skip
	fi;
	

	if
	:: 0 != -2 && ub_for263_1 != -2 -> 
				for(i : 0.. ub_for263_1) {
			for201218: skip;
			

			if
			:: sigchan.async_rcv?0;
			:: sigchan.sync?0;
			fi;
			for20_end1218: skip
		};
		for20_exit1218: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: sigchan.async_rcv?0;
			:: sigchan.sync?0;
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi
stop_process:skip
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

