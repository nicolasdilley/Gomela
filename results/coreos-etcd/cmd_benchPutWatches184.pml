#define benchPutWatches_wk_watches  0
#define benchPutWatches_clients  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example420310086/tools/benchmark/cmd/watch.go
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
	Chandef putreqc;
	bool state = false;
	int i;
	int clients = benchPutWatches_clients;
	int wk_watches = benchPutWatches_wk_watches;
	int watchPutTotal = -2;
	for20_exit: skip;
	

	if
	:: clients > 0 -> 
		putreqc.size = clients;
		run AsyncChan(putreqc)
	:: else -> 
		run sync_monitor(putreqc)
	fi;
	run go_Anonymous0(putreqc,watchPutTotal);
		for(i : 0.. clients-1) {
		for40: skip;
		run go_Anonymous1(putreqc);
		for40_end: skip
	};
	for40_exit: skip
stop_process:skip
}

proctype go_Anonymous0(Chandef putreqc;int watchPutTotal) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: 0 != -2 && watchPutTotal-1 != -3 -> 
				for(i : 0.. watchPutTotal-1) {
			for30144: skip;
			

			if
			:: putreqc.async_send!0;
			:: putreqc.sync!0 -> 
				putreqc.sending?0
			fi;
			for30_end144: skip
		};
		for30_exit144: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: putreqc.async_send!0;
			:: putreqc.sync!0 -> 
				putreqc.sending?0
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	stop_process: skip;
	putreqc.closing!true
}
proctype go_Anonymous1(Chandef putreqc) {
	bool closed; 
	int i;
	bool state;
	do
	:: putreqc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: putreqc.async_rcv?0;
			:: putreqc.sync?0;
			fi;
			for41: skip;
			for41_end: skip
		fi
	od;
	for41_exit: skip;
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

