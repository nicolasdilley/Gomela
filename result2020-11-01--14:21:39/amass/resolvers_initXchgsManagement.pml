
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example081156577/resolvers/resolver_state.go
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
	Chandef xchgsChs_AddRequest;
	Chandef xchgsChs_AddTimeout;
	Chandef xchgsChs_Done;
	Chandef xchgsChs_UpdateTimeout;
	int i;
	Chandef xchgsChs_GetID;
	Chandef xchgsChs_DelTimeout;
	Chandef xchgsChs_AllTimeoutIDs;
	Chandef xchgsChs_PullRequest;
	bool state = false;
	
	if
	:: 2 > 0 -> 
		xchgsChs_Done.size = 2;
		run emptyChan(xchgsChs_Done)
	:: else -> 
		run sync_monitor(xchgsChs_Done)
	fi;
	
	if
	:: 10 > 0 -> 
		xchgsChs_GetID.size = 10;
		run emptyChan(xchgsChs_GetID)
	:: else -> 
		run sync_monitor(xchgsChs_GetID)
	fi;
	
	if
	:: 10 > 0 -> 
		xchgsChs_AddTimeout.size = 10;
		run emptyChan(xchgsChs_AddTimeout)
	:: else -> 
		run sync_monitor(xchgsChs_AddTimeout)
	fi;
	
	if
	:: 10 > 0 -> 
		xchgsChs_DelTimeout.size = 10;
		run emptyChan(xchgsChs_DelTimeout)
	:: else -> 
		run sync_monitor(xchgsChs_DelTimeout)
	fi;
	
	if
	:: 10 > 0 -> 
		xchgsChs_UpdateTimeout.size = 10;
		run emptyChan(xchgsChs_UpdateTimeout)
	:: else -> 
		run sync_monitor(xchgsChs_UpdateTimeout)
	fi;
	
	if
	:: 10 > 0 -> 
		xchgsChs_AllTimeoutIDs.size = 10;
		run emptyChan(xchgsChs_AllTimeoutIDs)
	:: else -> 
		run sync_monitor(xchgsChs_AllTimeoutIDs)
	fi;
	
	if
	:: 10 > 0 -> 
		xchgsChs_AddRequest.size = 10;
		run emptyChan(xchgsChs_AddRequest)
	:: else -> 
		run sync_monitor(xchgsChs_AddRequest)
	fi;
	
	if
	:: 10 > 0 -> 
		xchgsChs_PullRequest.size = 10;
		run emptyChan(xchgsChs_PullRequest)
	:: else -> 
		run sync_monitor(xchgsChs_PullRequest)
	fi;
	goto stop_process
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

