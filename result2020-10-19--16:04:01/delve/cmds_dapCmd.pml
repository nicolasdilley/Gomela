#define lb_for636_0  -1
#define ub_for636_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example902149894/cmd/dlv/cmds/commands.go
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
	chan child_cmdswaitForDisconnectSignal0 = [0] of {int};
	Chandef disconnectChan;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(disconnectChan);
	run cmdswaitForDisconnectSignal(disconnectChan,child_cmdswaitForDisconnectSignal0);
	child_cmdswaitForDisconnectSignal0?0;
	goto stop_process
stop_process:}

proctype cmdswaitForDisconnectSignal(Chandef disconnectChan;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef ch;
	
	if
	:: 1 > 0 -> 
		ch.size = 1;
		run emptyChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	
	if
	:: true -> 
		run Anonymous1(ch,disconnectChan);
		do
		:: disconnectChan.async_rcv?0 -> 
			break
		:: disconnectChan.sync?0 -> 
			break
		od
	:: true -> 
		do
		:: ch.async_rcv?0 -> 
			break
		:: ch.sync?0 -> 
			break
		:: disconnectChan.async_rcv?0 -> 
			break
		:: disconnectChan.sync?0 -> 
			break
		od
	:: true -> 
		do
		:: ch.async_rcv?0 -> 
			break
		:: ch.sync?0 -> 
			break
		:: disconnectChan.async_rcv?0 -> 
			break
		:: disconnectChan.sync?0 -> 
			break
		od
	fi;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef ch;Chandef disconnectChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: ch.async_rcv?0 -> 
			break
		:: ch.sync?0 -> 
			break
		od
	od;
for10_exit:stop_process:
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

