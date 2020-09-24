#define lb_for93_0  -1
#define ub_for93_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example526575092/internal/cache/target.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
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
	Chandef events;
	run sync_monitor(events);
	run go_wwatchRoot(events,shutdown);
	run Anonymous2(events,shutdown);
	child!0;
stop_process:
}
proctype go_wwatchRoot(Chandef outgoingEvents;Chandef shutdown) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: shutdown.async_rcv?0 -> 
			goto stop_process
		:: shutdown.sync?0 -> 
			goto stop_process
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for10_exit:stop_process:
}
proctype Anonymous2(Chandef events;Chandef shutdown) {
	bool closed; 
	int i;
	do
	:: events.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			events.in?0;
			

			if
			:: true;
			:: true;
			:: true;
			fi
		fi
	od;
stop_process:
}
proctype functionPathWatcherReact(Chandef shutdown;chan child) {
	bool closed; 
	int i;
	Chandef events;
	run sync_monitor(events);
	run Anonymous4(outgoingEvents,shutdown);
	child!0;
stop_process:
}
proctype Anonymous4(Chandef outgoingEvents;Chandef shutdown) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		

		if
		:: true;
		:: true;
		:: true;
		fi
	:: true -> 
		break
	od;
stop_process:
}
proctype subscriptionPathWatcherReact(Chandef shutdown;chan child) {
	bool closed; 
	int i;
	Chandef events;
	run sync_monitor(events);
	run Anonymous6(outgoingEvents,shutdown);
	child!0;
stop_process:
}
proctype Anonymous6(Chandef outgoingEvents;Chandef shutdown) {
	bool closed; 
	int i;
	do
	:: true -> 
for40:		

		if
		:: true;
		:: true;
		:: true;
		fi
	:: true -> 
		break
	od;
stop_process:
}
proctype corsPathWatcherReact(Chandef shutdown;chan child) {
	bool closed; 
	int i;
	Chandef events;
	run sync_monitor(events);
	run Anonymous8(outgoingEvents,shutdown);
	child!0;
stop_process:
}
proctype Anonymous8(Chandef outgoingEvents;Chandef shutdown) {
	bool closed; 
	int i;
	do
	:: true -> 
for50:		

		if
		:: true;
		:: true;
		:: true;
		fi
	:: true -> 
		break
	od;
stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

