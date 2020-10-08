#define lb_for81_0  -1
#define ub_for81_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example343935019/modules/graceful/manager_unix.go
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
	Chandef g_shutdown;
	int i;
	Chandef g_done;
	Chandef g_terminate;
	Chandef g_hammer;
	Chandef startupDone;
	bool state = false;
	run sync_monitor(g_terminate);
	run sync_monitor(g_shutdown);
	run sync_monitor(g_hammer);
	run sync_monitor(g_done);
	run sync_monitor(startupDone);
	run Anonymous0(g_terminate,g_shutdown,g_hammer,g_done,startupDone);
	
	if
	:: true -> 
		run Anonymous1(g_terminate,g_shutdown,g_hammer,g_done,startupDone)
	:: true;
	fi
stop_process:}

proctype Anonymous0(Chandef g_terminate;Chandef g_shutdown;Chandef g_hammer;Chandef g_done;Chandef startupDone) {
	bool closed; 
	int i;
	startupDone.closing!true;
stop_process:
}
proctype Anonymous1(Chandef g_terminate;Chandef g_shutdown;Chandef g_hammer;Chandef g_done;Chandef startupDone) {
	bool closed; 
	int i;
	do
	:: startupDone.async_rcv?0 -> 
		goto stop_process
	:: startupDone.sync?0 -> 
		goto stop_process
	:: true -> 
		do
		:: true -> 
for10:
		od;
for10_exit:		goto stop_process
	:: true;
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

