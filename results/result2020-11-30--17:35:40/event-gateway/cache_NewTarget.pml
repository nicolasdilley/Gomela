
// /tmp/clone-example319749996/internal/cache/target.go
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
	chan child_eventTypePathWatcherReact0 = [0] of {int};
	int i;
	chan child_subscriptionPathWatcherReact2 = [0] of {int};
	Chandef shutdown;
	chan child_functionPathWatcherReact1 = [0] of {int};
	chan child_corsPathWatcherReact3 = [0] of {int};
	bool state = false;
	run sync_monitor(shutdown);
	run eventTypePathWatcherReact(shutdown,child_eventTypePathWatcherReact0);
	child_eventTypePathWatcherReact0?0;
	run functionPathWatcherReact(shutdown,child_functionPathWatcherReact1);
	child_functionPathWatcherReact1?0;
	run subscriptionPathWatcherReact(shutdown,child_subscriptionPathWatcherReact2);
	child_subscriptionPathWatcherReact2?0;
	run corsPathWatcherReact(shutdown,child_corsPathWatcherReact3);
	child_corsPathWatcherReact3?0;
	goto stop_process
stop_process:}

proctype eventTypePathWatcherReact(Chandef shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef events;
	run sync_monitor(events);
	run Anonymous0(events,shutdown);
stop_process:	child!0
}
proctype functionPathWatcherReact(Chandef shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef events;
	run sync_monitor(events);
	run Anonymous1(events,shutdown);
stop_process:	child!0
}
proctype subscriptionPathWatcherReact(Chandef shutdown;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef events;
	run sync_monitor(events);
	run Anonymous2(events,shutdown);
stop_process:	child!0
}
proctype Anonymous3(Chandef events;Chandef shutdown) {
	bool closed; 
	int i;
	bool state;
	do
	:: events.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: events.async_rcv?0;
			:: events.sync?0;
			fi;
			

			if
			:: true -> 
				break
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

