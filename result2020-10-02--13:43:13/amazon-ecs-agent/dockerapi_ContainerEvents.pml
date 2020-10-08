#define lb_for862_0  -1
#define ub_for862_1  -1
#define lb_for98_2  -1
#define ub_for98_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example646408234/agent/dockerclient/dockerapi/docker_client.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Chandef changedContainers;
	Chandef events;
	bool state = false;
	Wgdef buffer_waitForEvent;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(events);
	run wgMonitor(buffer_waitForEvent);
	run Anonymous0(events,changedContainers);
	run go_bufferConsume(events);
	run sync_monitor(changedContainers);
	run go_dghandleContainerEvents(events,changedContainers);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef events;Chandef changedContainers) {
	bool closed; 
	int i;
		for(i : lb_for862_0.. ub_for862_1) {
for10:		do
		:: true -> 
			goto stop_process
		od
	};
for10_exit:stop_process:
}
proctype go_bufferConsume(Chandef in) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			
			if
			:: in.async_send!0;
			:: in.sync!0 -> 
				in.sending?0
			fi
		:: true -> 
			
			if
			:: in.async_send!0;
			:: in.sync!0 -> 
				in.sending?0
			fi
		fi
	od;
for20_exit:stop_process:
}
proctype go_dghandleContainerEvents(Chandef events;Chandef changedContainers) {
	bool closed; 
	int i;
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
				
				if
				:: changedContainers.async_send!0;
				:: changedContainers.sync!0 -> 
					changedContainers.sending?0
				fi
			:: true;
			:: true;
			:: true;
			:: true;
			:: true;
			:: true;
			:: true;
			fi;
			
			if
			:: changedContainers.async_send!0;
			:: changedContainers.sync!0 -> 
				changedContainers.sending?0
			fi
		fi
	od;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
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

