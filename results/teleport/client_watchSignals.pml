#define lb_for517_0  -1
#define ub_for517_1  -1
#define lb_for529_2  -1
#define ub_for529_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example077224997/lib/client/session.go
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
	int i;
	Chandef ctrlCSignal;
	Chandef exitSignals;
	Chandef ctrlZSignal;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		exitSignals.size = 1;
		run emptyChan(exitSignals)
	:: else -> 
		run sync_monitor(exitSignals)
	fi;
	run Anonymous0(exitSignals,ctrlCSignal,ctrlZSignal);
	
	if
	:: 1 > 0 -> 
		ctrlCSignal.size = 1;
		run emptyChan(ctrlCSignal)
	:: else -> 
		run sync_monitor(ctrlCSignal)
	fi;
	run Anonymous1(exitSignals,ctrlCSignal,ctrlZSignal);
	
	if
	:: 1 > 0 -> 
		ctrlZSignal.size = 1;
		run emptyChan(ctrlZSignal)
	:: else -> 
		run sync_monitor(ctrlZSignal)
	fi;
	run Anonymous2(exitSignals,ctrlCSignal,ctrlZSignal)
stop_process:}

proctype Anonymous0(Chandef exitSignals;Chandef ctrlCSignal;Chandef ctrlZSignal) {
	bool closed; 
	int i;
	
	if
	:: exitSignals.async_rcv?0;
	:: exitSignals.sync?0;
	fi;
stop_process:
}
proctype Anonymous1(Chandef exitSignals;Chandef ctrlCSignal;Chandef ctrlZSignal) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: ctrlCSignal.async_rcv?0;
		:: ctrlCSignal.sync?0;
		fi
	od;
for10_exit:stop_process:
}
proctype Anonymous2(Chandef exitSignals;Chandef ctrlCSignal;Chandef ctrlZSignal) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		
		if
		:: ctrlZSignal.async_rcv?0;
		:: ctrlZSignal.sync?0;
		fi
	od;
for20_exit:stop_process:
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

