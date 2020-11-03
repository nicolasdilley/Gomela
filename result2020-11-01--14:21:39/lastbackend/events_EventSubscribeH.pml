#define lb_for77_0  -1
#define ub_for77_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example975140189/pkg/api/http/events/handlers.go
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
	chan child_socketNewSocket0 = [0] of {int};
	Chandef leave;
	chan child_envs_Get___GetMonitor__Subscribe1 = [0] of {int};
	Chandef done;
	Chandef event;
	Chandef es;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		done.size = 1;
		run emptyChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	run sync_monitor(leave);
	run sync_monitor(event);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run socketNewSocket(leave,event,child_socketNewSocket0);
	child_socketNewSocket0?0;
	run sync_monitor(es);
	run Anonymous1(done,leave,event,es);
	run envs_Get___GetMonitor__Subscribe(es,done,child_envs_Get___GetMonitor__Subscribe1);
	child_envs_Get___GetMonitor__Subscribe1?0
stop_process:}

proctype socketNewSocket(Chandef leave;Chandef event;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef s_write;
	Chandef s_pong;
	Chandef s_ping;
	Chandef s_close;
	run sync_monitor(s_write);
	run sync_monitor(s_ping);
	run sync_monitor(s_pong);
	run sync_monitor(s_close);
	goto stop_process;
stop_process:	child!0
}
proctype Anonymous1(Chandef done;Chandef leave;Chandef event;Chandef es) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: leave.async_rcv?0 -> 
			
			if
			:: done.async_send!0;
			:: done.sync!0 -> 
				done.sending?0
			fi;
			goto stop_process
		:: leave.sync?0 -> 
			
			if
			:: done.async_send!0;
			:: done.sync!0 -> 
				done.sending?0
			fi;
			goto stop_process
		:: es.async_rcv?0 -> 
			break
		:: es.sync?0 -> 
			break
		od
	od;
for10_exit:stop_process:
}
proctype envs_Get___GetMonitor__Subscribe(Chandef subscriber;Chandef done;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: done.async_rcv?0;
	:: done.sync?0;
	fi;
stop_process:	child!0
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

