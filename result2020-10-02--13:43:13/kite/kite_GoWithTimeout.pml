
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example908076392/client.go
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
	Chandef responseChan;
	int i;
	chan child_csendMethod2 = [0] of {int};
	bool state = false;
	
	if
	:: 1 > 0 -> 
		responseChan.size = 1;
		run emptyChan(responseChan)
	:: else -> 
		run sync_monitor(responseChan)
	fi;
	run csendMethod(responseChan,child_csendMethod0);
	child_csendMethod2?0;
	goto stop_process
stop_process:}

proctype csendMethod(Chandef responseChan;chan child) {
	bool closed; 
	int i;
	Chandef removeCallback;
	chan child_cmakeResponseCallback0 = [0] of {int};
	Chandef doneChan;
	chan child_kitesendCallbackID1 = [0] of {int};
	
	if
	:: 1 > 0 -> 
		removeCallback.size = 1;
		run emptyChan(removeCallback)
	:: else -> 
		run sync_monitor(removeCallback)
	fi;
	
	if
	:: 1 > 0 -> 
		doneChan.size = 1;
		run emptyChan(doneChan)
	:: else -> 
		run sync_monitor(doneChan)
	fi;
	run cmakeResponseCallback(doneChan,removeCallback,child_cmakeResponseCallback0);
	child_cmakeResponseCallback0?0;
	
	if
	:: true -> 
		
		if
		:: responseChan.async_send!0;
		:: responseChan.sync!0 -> 
			responseChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	run Anonymous2(removeCallback,doneChan,responseChan);
	run kitesendCallbackID(removeCallback,callbacks,child_kitesendCallbackID1);
	child_kitesendCallbackID1?0;
	child!0;
stop_process:
}
proctype cmakeResponseCallback(Chandef doneChan;Chandef removeCallback;chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous2(Chandef removeCallback;Chandef doneChan;Chandef responseChan) {
	bool closed; 
	int i;
	do
	:: true -> 
		
		if
		:: responseChan.async_send!0;
		:: responseChan.sync!0 -> 
			responseChan.sending?0
		fi
	:: true -> 
		
		if
		:: responseChan.async_send!0;
		:: responseChan.sync!0 -> 
			responseChan.sending?0
		fi;
		
		if
		:: removeCallback.async_rcv?0;
		:: removeCallback.sync?0;
		fi
	od;
stop_process:
}
proctype kitesendCallbackID(Chandef ch;int callbacks;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi;
		goto stop_process
	:: true -> 
		break
	od;
	ch.closing!true;
	child!0;
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

