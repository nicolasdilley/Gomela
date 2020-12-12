
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example882693109/src/server/pkg/collection/collection.go
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
	int i;
	Chandef done;
	Chandef eventCh;
	chan child_MakeWatcher0 = [0] of {int};
	bool state = false;
	run sync_monitor(eventCh);
	run sync_monitor(done);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0(eventCh,done);
	run MakeWatcher(eventCh,done,child_MakeWatcher0);
	child_MakeWatcher0?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef eventCh;Chandef done) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: done.async_rcv?0 -> 
			goto stop_process
		:: done.sync?0 -> 
			goto stop_process
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: eventCh.async_send!0;
		:: eventCh.sync!0 -> 
			eventCh.sending?0
		fi
	od;
for10_exit:stop_process:	
	if
	:: true -> 
		
		if
		:: eventCh.async_send!0;
		:: eventCh.sync!0 -> 
			eventCh.sending?0
		fi
	:: true;
	fi;
	eventCh.closing!true
}
proctype MakeWatcher(Chandef eventCh;Chandef done;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
stop_process:	child!0
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

