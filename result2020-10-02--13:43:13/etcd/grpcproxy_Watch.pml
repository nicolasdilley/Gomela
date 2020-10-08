
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example152234228/proxy/grpcproxy/watch.go
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
	Chandef stopc;
	Chandef wps_watchCh;
	int i;
	do
	:: true -> 
		do
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od
	:: true -> 
		break
	od;
	
	if
	:: 1024 > 0 -> 
		wps_watchCh.size = 1024;
		run emptyChan(wps_watchCh)
	:: else -> 
		run sync_monitor(wps_watchCh)
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: 3 > 0 -> 
		stopc.size = 3;
		run emptyChan(stopc)
	:: else -> 
		run sync_monitor(stopc)
	fi;
	run Anonymous0(stopc);
	run Anonymous1(stopc);
	run Anonymous2(stopc);
	
	if
	:: stopc.async_rcv?0;
	:: stopc.sync?0;
	fi;
	run Anonymous3(stopc);
	do
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od
stop_process:}

proctype Anonymous0(Chandef stopc) {
	bool closed; 
	int i;
	
	if
	:: stopc.async_send!0;
	:: stopc.sync!0 -> 
		stopc.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef stopc) {
	bool closed; 
	int i;
	
	if
	:: stopc.async_send!0;
	:: stopc.sync!0 -> 
		stopc.sending?0
	fi;
stop_process:
}
proctype Anonymous2(Chandef stopc) {
	bool closed; 
	int i;
	do
	:: true;
	:: true;
	:: true;
	od;
	
	if
	:: stopc.async_send!0;
	:: stopc.sync!0 -> 
		stopc.sending?0
	fi;
stop_process:
}
proctype Anonymous3(Chandef stopc) {
	bool closed; 
	int i;
	
	if
	:: stopc.async_rcv?0;
	:: stopc.sync?0;
	fi;
	
	if
	:: stopc.async_rcv?0;
	:: stopc.sync?0;
	fi;
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

