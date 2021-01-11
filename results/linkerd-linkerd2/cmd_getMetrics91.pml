#define getMetrics_pods  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example794499626/cli/cmd/metrics_diagnostics_util.go
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
	Chandef resultChan;
	bool state = false;
	int i;
	int pods = getMetrics_pods;
	run sync_monitor(resultChan);
		for(i : 0.. pods-1) {
		for10: skip;
		run go_Anonymous0(resultChan);
		for10_end: skip
	};
	for10_exit: skip;
	do
	:: true -> 
		for20: skip;
		do
		:: resultChan.async_rcv?0 -> 
			break
		:: resultChan.sync?0 -> 
			break
		:: true -> 
			goto for20_exit
		od;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		for20_end: skip
	od;
	for20_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef resultChan) {
	bool closed; 
	int i;
	bool state;
	int containers=3;
	

	if
	:: true -> 
		

		if
		:: resultChan.async_send!0;
		:: resultChan.sync!0 -> 
			resultChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: containers-1 != -3 -> 
				for(i : 0.. containers-1) {
			for11: skip;
			

			if
			:: resultChan.async_send!0;
			:: resultChan.sync!0 -> 
				resultChan.sending?0
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for111284: skip;
			

			if
			:: resultChan.async_send!0;
			:: resultChan.sync!0 -> 
				resultChan.sending?0
			fi;
			for11_end1284: skip
		:: true -> 
			break
		od;
		for11_exit1284: skip
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


