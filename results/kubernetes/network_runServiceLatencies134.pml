#define runServiceLatencies_total  ??
#define runServiceLatencies_inParallel  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example354285826/test/e2e/network/service_latency.go
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
	Chandef errs;
	int inParallel = runServiceLatencies_inParallel;
	Chandef blocker;
	bool state = false;
	Chandef durations;
	int total = runServiceLatencies_total;
	int i;
	
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
for10_exit:	
	if
	:: 0 != -2 && total-1 != -3 -> 
				for(i : 0.. total-1) {
for20:			do
			:: errs.async_rcv?0 -> 
				break
			:: errs.sync?0 -> 
				break
			:: durations.async_rcv?0 -> 
				break
			:: durations.sync?0 -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: errs.async_rcv?0 -> 
				break
			:: errs.sync?0 -> 
				break
			:: durations.async_rcv?0 -> 
				break
			:: durations.sync?0 -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	
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
stop_process:}

proctype Anonymous0(Chandef errs;Chandef durations;Chandef blocker) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: blocker.async_send!0;
	:: blocker.sync!0 -> 
		blocker.sending?0
	fi;
	
	if
	:: true -> 
		
		if
		:: errs.async_send!0;
		:: errs.sync!0 -> 
			errs.sending?0
		fi
	:: true -> 
		
		if
		:: durations.async_send!0;
		:: durations.sync!0 -> 
			durations.sending?0
		fi
	:: true -> 
		
		if
		:: durations.async_send!0;
		:: durations.sync!0 -> 
			durations.sending?0
		fi
	fi;
stop_process:	
	if
	:: blocker.async_rcv?0;
	:: blocker.sync?0;
	fi
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

