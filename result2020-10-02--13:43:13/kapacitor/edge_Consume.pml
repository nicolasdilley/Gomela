#define lb_for156_0  -1
#define ub_for156_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example382278456/edge/consumer.go
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
	Chandef firstErr;
	Chandef errC;
	int c_ins = 5;
	bool state = false;
	
	if
	:: c_ins > 0 -> 
		errC.size = c_ins;
		run emptyChan(errC)
	:: else -> 
		run sync_monitor(errC)
	fi;
		for(i : 1.. c_ins) {
for10:		run Anonymous0(errC,firstErr)
	};
	
	if
	:: 1 > 0 -> 
		firstErr.size = 1;
		run emptyChan(firstErr)
	:: else -> 
		run sync_monitor(firstErr)
	fi;
	run Anonymous1(errC,firstErr);
LOOP:		do
	:: true -> 
for30:		do
		od
	od;
for30_exit:;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errC;Chandef firstErr) {
	bool closed; 
	int i;
	
	if
	:: errC.async_send!0;
	:: errC.sync!0 -> 
		errC.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef errC;Chandef firstErr) {
	bool closed; 
	int i;
		for(i : 1.. c_ins) {
for20:		
		if
		:: errC.async_rcv?0;
		:: errC.sync?0;
		fi;
		
		if
		:: true -> 
			
			if
			:: firstErr.async_send!0;
			:: firstErr.sync!0 -> 
				firstErr.sending?0
			fi
		:: true;
		fi
	};
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

