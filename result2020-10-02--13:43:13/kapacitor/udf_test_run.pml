#define lb_for110_0  -1
#define ub_for110_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example382278456/udf/test/test_udf.go
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
	Chandef readErrC;
	int i;
	Chandef writeErrC;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		readErrC.size = 1;
		run emptyChan(readErrC)
	:: else -> 
		run sync_monitor(readErrC)
	fi;
	
	if
	:: 1 > 0 -> 
		writeErrC.size = 1;
		run emptyChan(writeErrC)
	:: else -> 
		run sync_monitor(writeErrC)
	fi;
	run Anonymous0(readErrC,writeErrC);
	run Anonymous1(readErrC,writeErrC);
	
	if
	:: lb_for110_0 != -1 && ub_for110_1 != -1 -> 
				for(i : lb_for110_0.. ub_for110_1) {
for10:			do
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			od
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

proctype Anonymous0(Chandef readErrC;Chandef writeErrC) {
	bool closed; 
	int i;
	
	if
	:: readErrC.async_send!0;
	:: readErrC.sync!0 -> 
		readErrC.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef readErrC;Chandef writeErrC) {
	bool closed; 
	int i;
	
	if
	:: writeErrC.async_send!0;
	:: writeErrC.sync!0 -> 
		writeErrC.sending?0
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
