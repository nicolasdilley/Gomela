#define runServiceLatencies_total  3
#define runServiceLatencies_inParallel  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example122051410/test/e2e/network/service_latency.go
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
	Chandef blocker;
	Chandef durations;
	Chandef errs;
	int num_msgs = 0;
	bool state = false;
	int i;
	int inParallel = runServiceLatencies_inParallel;
	int total = runServiceLatencies_total;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: total > 0 -> 
		errs.size = total;
		run AsyncChan(errs)
	:: else -> 
		run sync_monitor(errs)
	fi;
	

	if
	:: total > 0 -> 
		durations.size = total;
		run AsyncChan(durations)
	:: else -> 
		run sync_monitor(durations)
	fi;
	

	if
	:: inParallel > 0 -> 
		blocker.size = inParallel;
		run AsyncChan(blocker)
	:: else -> 
		run sync_monitor(blocker)
	fi;
		for(i : 0.. total-1) {
		for10: skip;
		run go_Anonymous0(errs,durations,blocker);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && total-1 != -3 -> 
				for(i : 0.. total-1) {
			for20821: skip;
			do
			:: errs.async_rcv?state,num_msgs -> 
				break
			:: errs.sync?state,num_msgs -> 
				break
			:: durations.async_rcv?state,num_msgs -> 
				break
			:: durations.sync?state,num_msgs -> 
				break
			od;
			for20_end821: skip
		};
		for20_exit821: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			do
			:: errs.async_rcv?state,num_msgs -> 
				break
			:: errs.sync?state,num_msgs -> 
				break
			:: durations.async_rcv?state,num_msgs -> 
				break
			:: durations.sync?state,num_msgs -> 
				break
			od;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef errs;Chandef durations;Chandef blocker) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: blocker.async_send!0;
	:: blocker.sync!false,0 -> 
		blocker.sending?state
	fi;
	

	if
	:: true -> 
		

		if
		:: errs.async_send!0;
		:: errs.sync!false,0 -> 
			errs.sending?state
		fi
	:: true -> 
		

		if
		:: durations.async_send!0;
		:: durations.sync!false,0 -> 
			durations.sending?state
		fi
	fi;
	stop_process: skip;
	

	if
	:: blocker.async_rcv?state,num_msgs;
	:: blocker.sync?state,num_msgs;
	fi
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

