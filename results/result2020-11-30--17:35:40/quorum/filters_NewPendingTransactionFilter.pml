#define lb_for116_0  -1
#define ub_for116_1  -1

// /tmp/clone-example903492413/eth/filters/api.go
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
	Chandef pendingTxs;
	int i;
	chan child_api_eventsSubscribePendingTxs0 = [0] of {int};
	bool state = false;
	run sync_monitor(pendingTxs);
	run api_eventsSubscribePendingTxs(pendingTxs,child_api_eventsSubscribePendingTxs0);
	child_api_eventsSubscribePendingTxs0?0;
	run Anonymous1(pendingTxs);
	goto stop_process
stop_process:}

proctype api_eventsSubscribePendingTxs(Chandef hashes;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef sub_logs;
	Chandef sub_installed;
	Chandef sub_headers;
	Chandef sub_err;
	run sync_monitor(sub_logs);
	run sync_monitor(sub_headers);
	run sync_monitor(sub_installed);
	run sync_monitor(sub_err);
	goto stop_process;
stop_process:	child!0
}
proctype Anonymous1(Chandef pendingTxs) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: pendingTxs.async_rcv?0 -> 
			break
		:: pendingTxs.sync?0 -> 
			break
		od
	od;
for10_exit:stop_process:
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

