
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example683189665/weed/stats/stats.go
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
	Chandef Chan_BytesIn;
	Chandef Chan_AssignRequests;
	Chandef Chan_Connections;
	Chandef Chan_WriteRequests;
	int i;
	Chandef Chan_Requests;
	Chandef Chan_ReadRequests;
	Chandef Chan_DeleteRequests;
	Chandef Chan_BytesOut;
	bool state = false;
	
	if
	:: 100 > 0 -> 
		Chan_Connections.size = 100;
		run emptyChan(Chan_Connections)
	:: else -> 
		run sync_monitor(Chan_Connections)
	fi;
	
	if
	:: 100 > 0 -> 
		Chan_Requests.size = 100;
		run emptyChan(Chan_Requests)
	:: else -> 
		run sync_monitor(Chan_Requests)
	fi;
	
	if
	:: 100 > 0 -> 
		Chan_AssignRequests.size = 100;
		run emptyChan(Chan_AssignRequests)
	:: else -> 
		run sync_monitor(Chan_AssignRequests)
	fi;
	
	if
	:: 100 > 0 -> 
		Chan_ReadRequests.size = 100;
		run emptyChan(Chan_ReadRequests)
	:: else -> 
		run sync_monitor(Chan_ReadRequests)
	fi;
	
	if
	:: 100 > 0 -> 
		Chan_WriteRequests.size = 100;
		run emptyChan(Chan_WriteRequests)
	:: else -> 
		run sync_monitor(Chan_WriteRequests)
	fi;
	
	if
	:: 100 > 0 -> 
		Chan_DeleteRequests.size = 100;
		run emptyChan(Chan_DeleteRequests)
	:: else -> 
		run sync_monitor(Chan_DeleteRequests)
	fi;
	
	if
	:: 100 > 0 -> 
		Chan_BytesIn.size = 100;
		run emptyChan(Chan_BytesIn)
	:: else -> 
		run sync_monitor(Chan_BytesIn)
	fi;
	
	if
	:: 100 > 0 -> 
		Chan_BytesOut.size = 100;
		run emptyChan(Chan_BytesOut)
	:: else -> 
		run sync_monitor(Chan_BytesOut)
	fi
stop_process:}

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

