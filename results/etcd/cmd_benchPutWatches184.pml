#define benchPutWatches_wk_watches  ??
#define benchPutWatches_clients  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example388592302/tools/benchmark/cmd/watch.go
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
	int clients = benchPutWatches_clients;
	Chandef putreqc;
	bool state = false;
	int wk_watches = benchPutWatches_wk_watches;
	int i;
for10_exit:	
	if
	:: clients > 0 -> 
		putreqc.size = clients;
		run AsyncChan(putreqc)
	:: else -> 
		run sync_monitor(putreqc)
	fi;
	run Anonymous1(putreqc)
stop_process:}

proctype Anonymous0(Chandef putreqc) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous1(Chandef putreqc) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -2 && watchPutTotal-1 != -3 -> 
				for(i : 0.. watchPutTotal-1) {
for30:			
			if
			:: putreqc.async_send!0;
			:: putreqc.sync!0 -> 
				putreqc.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: putreqc.async_send!0;
			:: putreqc.sync!0 -> 
				putreqc.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:stop_process:	putreqc.closing!true
}
proctype Anonymous2(Chandef putreqc) {
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
			fi
		fi
	od;
stop_process:
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

