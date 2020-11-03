#define main_filePaths 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example603443140/main.go
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
	Chandef waitForCommand;
	Chandef signalChan;
	int i;
	Chandef waitForFileChange;
	int filePaths = main_filePaths;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		signalChan.size = 1;
		run emptyChan(signalChan)
	:: else -> 
		run sync_monitor(signalChan)
	fi;
	do
	:: signalChan!0 -> 
		break
	:: true -> 
		break
	od;
	run Anonymous0(signalChan,waitForFileChange,waitForCommand);
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		fi
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(waitForFileChange);
	run sync_monitor(waitForCommand);
	run Anonymous1(waitForFileChange,signalChan,waitForCommand);
	run Anonymous2(waitForCommand,signalChan,waitForFileChange);
	
	if
	:: waitForCommand.async_rcv?0;
	:: waitForCommand.sync?0;
	fi;
	
	if
	:: waitForFileChange.async_rcv?0;
	:: waitForFileChange.sync?0;
	fi;
		for(i : 0.. filePaths-1) {
for10:
	}
stop_process:}

proctype Anonymous0(Chandef signalChan;Chandef waitForFileChange;Chandef waitForCommand) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: signalChan.async_rcv?0;
	:: signalChan.sync?0;
	fi;
stop_process:
}
proctype Anonymous1(Chandef doneChan;Chandef signalChan;Chandef waitForCommand) {
	bool closed; 
	int i;
	bool state;
stop_process:	
	if
	:: doneChan.async_send!0;
	:: doneChan.sync!0 -> 
		doneChan.sending?0
	fi
}
proctype Anonymous2(Chandef doneChan;Chandef signalChan;Chandef waitForFileChange) {
	bool closed; 
	int i;
	bool state;
stop_process:	
	if
	:: doneChan.async_send!0;
	:: doneChan.sync!0 -> 
		doneChan.sending?0
	fi
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


