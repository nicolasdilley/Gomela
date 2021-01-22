#define benchMakeWatches_streams  0
#define benchMakeWatches_watchStreams  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example061874643/tools/benchmark/cmd/watch.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef wc;
	Chandef keyc;
	int num_msgs = 0;
	bool state = false;
	int i;
	int watchStreams = benchMakeWatches_watchStreams;
	int streams = benchMakeWatches_streams;
	

	if
	:: watchStreams > 0 -> 
		keyc.size = watchStreams;
		run AsyncChan(keyc)
	:: else -> 
		run sync_monitor(keyc)
	fi;
	

	if
	:: streams > 0 -> 
		wc.size = streams;
		run AsyncChan(wc)
	:: else -> 
		run sync_monitor(wc)
	fi;
		for(i : 0.. streams-1) {
		for20: skip;
		run go_Anonymous0(keyc,wc);
		for20_end: skip
	};
	for20_exit: skip;
	run go_Anonymous1(keyc,wc,watchStreams)
stop_process:skip
}

proctype go_Anonymous0(Chandef keyc;Chandef wc) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int watchWatchesPerStream = -2;
	

	if
	:: 0 != -2 && watchWatchesPerStream-1 != -3 -> 
				for(i : 0.. watchWatchesPerStream-1) {
			for21142: skip;
			

			if
			:: keyc.async_rcv?state,num_msgs;
			:: keyc.sync?state,num_msgs;
			fi;
			for21_end142: skip
		};
		for21_exit142: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			

			if
			:: keyc.async_rcv?state,num_msgs;
			:: keyc.sync?state,num_msgs;
			fi;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	

	if
	:: wc.async_send!0;
	:: wc.sync!false,0 -> 
		wc.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef keyc;Chandef wc;int watchStreams) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && watchStreams * watchWatchesPerStream-1 != -3 -> 
				for(i : 0.. watchStreams * watchWatchesPerStream-1) {
			for30143: skip;
			

			if
			:: keyc.async_send!0;
			:: keyc.sync!false,0 -> 
				keyc.sending?state
			fi;
			for30_end143: skip
		};
		for30_exit143: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: keyc.async_send!0;
			:: keyc.sync!false,0 -> 
				keyc.sending?state
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	stop_process: skip;
	keyc.closing!true
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

