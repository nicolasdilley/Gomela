
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example075292065/pkg/blobserver/encrypt/meta.go
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
	Chandef stopEnumerate;
	Chandef metac;
	int i;
	Chandef gate;
	Chandef enumErrc;
	bool state = false;
	
	if
	:: 16 > 0 -> 
		metac.size = 16;
		run emptyChan(metac)
	:: else -> 
		run sync_monitor(metac)
	fi;
	
	if
	:: 5 > 0 -> 
		gate.size = 5;
		run emptyChan(gate)
	:: else -> 
		run sync_monitor(gate)
	fi;
	run sync_monitor(stopEnumerate);
	
	if
	:: 1 > 0 -> 
		enumErrc.size = 1;
		run emptyChan(enumErrc)
	:: else -> 
		run sync_monitor(enumErrc)
	fi;
	run Anonymous0(metac,gate,stopEnumerate,enumErrc);
	do
	:: metac.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: metac.async_rcv?0;
			:: metac.sync?0;
			fi;
			
			if
			:: true -> 
				stopEnumerate.closing!true;
				run Anonymous1(metac,gate,stopEnumerate,enumErrc);
				goto stop_process
			:: true;
			fi
		fi
	od;
	
	if
	:: enumErrc.async_rcv?0;
	:: enumErrc.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef metac;Chandef gate;Chandef stopEnumerate;Chandef enumErrc) {
	bool closed; 
	int i;
	bool state;
	Wgdef wg;
	run wgMonitor(wg);
	
	if
	:: enumErrc.async_send!0;
	:: enumErrc.sync!0 -> 
		enumErrc.sending?0
	fi;
	wg.Wait?0;
	metac.closing!true;
stop_process:
}
proctype Anonymous1(Chandef metac;Chandef gate;Chandef stopEnumerate;Chandef enumErrc) {
	bool closed; 
	int i;
	bool state;
	do
	:: metac.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: metac.async_rcv?0;
			:: metac.sync?0;
			fi
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

