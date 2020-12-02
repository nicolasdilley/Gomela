#define Watch_types_DefaultEventChanSize  0

// /tmp/clone-example746219978/src/storage/stream/event/watch.go
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
	bool state = false;
	int types_DefaultEventChanSize = Watch_types_DefaultEventChanSize;
	Chandef eventChan;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: types_DefaultEventChanSize > 0 -> 
		eventChan.size = types_DefaultEventChanSize;
		run AsyncChan(eventChan)
	:: else -> 
		run sync_monitor(eventChan)
	fi;
	run go_eloopWatch(eventChan);
	goto stop_process
stop_process:}

proctype go_eloopWatch(Chandef eventChan) {
	bool closed; 
	int i;
	bool state;
	chan child_esetCleaner0 = [0] of {int};
	run esetCleaner(eventChan,child_esetCleaner0);
	child_esetCleaner0?0;
	do
	:: true -> 
for10:		do
		:: true -> 
			break
		od;
		
		if
		:: lb_for114_3 != -2 && ub_for114_4 != -2 -> 
						for(i : lb_for114_3.. ub_for114_4) {
for11:				do
				:: true -> 
					break
				od;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: eventChan.async_send!0;
				:: eventChan.sync!0 -> 
					eventChan.sending?0
				fi
			}
		:: else -> 
			do
			:: true -> 
for11:				do
				:: true -> 
					break
				od;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: eventChan.async_send!0;
				:: eventChan.sync!0 -> 
					eventChan.sending?0
				fi
			:: true -> 
				break
			od
		fi;
for11_exit:
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

