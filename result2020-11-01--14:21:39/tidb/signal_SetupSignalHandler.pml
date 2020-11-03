#define lb_for35_0  -1
#define ub_for35_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example816632275/util/signal/signal_posix.go
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
	Chandef usrDefSignalChan;
	int i;
	Chandef closeSignalChan;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		usrDefSignalChan.size = 1;
		run emptyChan(usrDefSignalChan)
	:: else -> 
		run sync_monitor(usrDefSignalChan)
	fi;
	do
	:: usrDefSignalChan!0 -> 
		break
	:: true -> 
		break
	od;
	run Anonymous0(usrDefSignalChan,closeSignalChan);
	
	if
	:: 1 > 0 -> 
		closeSignalChan.size = 1;
		run emptyChan(closeSignalChan)
	:: else -> 
		run sync_monitor(closeSignalChan)
	fi;
	do
	:: closeSignalChan!0 -> 
		break
	:: true -> 
		break
	od;
	run Anonymous1(usrDefSignalChan,closeSignalChan)
stop_process:}

proctype Anonymous0(Chandef usrDefSignalChan;Chandef closeSignalChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: usrDefSignalChan.async_rcv?0;
		:: usrDefSignalChan.sync?0;
		fi
	od;
for10_exit:stop_process:
}
proctype Anonymous1(Chandef usrDefSignalChan;Chandef closeSignalChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: closeSignalChan.async_rcv?0;
	:: closeSignalChan.sync?0;
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

