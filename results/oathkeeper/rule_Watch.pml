#define lb_for220_0  -1
#define ub_for220_1  -1
#define not_found_268  5
#define replace  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example308246419/rule/fetcher_default.go
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
	bool state = false;
	chan child_fwatch5 = [0] of {int};
	Chandef events;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(events);
	run fwatch(events,child_fwatch0);
	child_fwatch5?0;
	events.closing!true;
	goto stop_process
stop_process:}

proctype fwatch(Chandef events;chan child) {
	bool closed; 
	int i;
	chan child_fenqueueEvent0 = [0] of {int};
	chan child_fenqueueEvent1 = [0] of {int};
	run fenqueueEvent(events,child_fenqueueEvent0);
	child_fenqueueEvent0?0;
	run fenqueueEvent(events,child_fenqueueEvent1);
	child_fenqueueEvent1?0;
	do
	:: true -> 
for10:		do
		od
	od;
for10_exit:	child!0;
stop_process:
}
proctype fenqueueEvent(Chandef events;chan child) {
	bool closed; 
	int i;
	run Anonymous2(events);
	child!0;
stop_process:
}
proctype Anonymous2(Chandef events) {
	bool closed; 
	int i;
	
	if
	:: events.async_send!0;
	:: events.sync!0 -> 
		events.sending?0
	fi;
stop_process:
}
proctype fconfigUpdate(Chandef events;int replace;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for12:
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
		for(i : 1.. replace) {
for13:		chan child_fenqueueEvent3 = [0] of {int};
		run fenqueueEvent(events,child_fenqueueEvent3);
		child_fenqueueEvent3?0
	};
	goto stop_process;
	child!0;
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

