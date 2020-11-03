#define newWritebackQueue_writers 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example601413756/store/storecache/wbq.go
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
	Chandef wbq_terminated;
	Chandef wbq_ready;
	Chandef wbq_request;
	Chandef wbq_retry;
	int i;
	Chandef wbq_flushRequest;
	Chandef wbq_done;
	Chandef wbq_die;
	int writers = newWritebackQueue_writers;
	bool state = false;
	
	if
	:: 20 > 0 -> 
		wbq_request.size = 20;
		run emptyChan(wbq_request)
	:: else -> 
		run sync_monitor(wbq_request)
	fi;
	
	if
	:: 20 > 0 -> 
		wbq_flushRequest.size = 20;
		run emptyChan(wbq_flushRequest)
	:: else -> 
		run sync_monitor(wbq_flushRequest)
	fi;
	
	if
	:: 20 > 0 -> 
		wbq_ready.size = 20;
		run emptyChan(wbq_ready)
	:: else -> 
		run sync_monitor(wbq_ready)
	fi;
	
	if
	:: 20 > 0 -> 
		wbq_done.size = 20;
		run emptyChan(wbq_done)
	:: else -> 
		run sync_monitor(wbq_done)
	fi;
	
	if
	:: 20 > 0 -> 
		wbq_retry.size = 20;
		run emptyChan(wbq_retry)
	:: else -> 
		run sync_monitor(wbq_retry)
	fi;
	run sync_monitor(wbq_die);
	run sync_monitor(wbq_terminated);
		for(i : 0.. writers-1) {
for10:
	};
for10_exit:	goto stop_process
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


