#define config_GetMatch_DeferredQueueSize  5
#define config_GetMatch_InputQueueSize  5
#define config_GetMatch_CallQueueSize  5
#define config_GetMatch_JoinAttemptQueueSize  5
#define lb_for176_4  -1
#define ub_for176_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example489184064/server/match_handler.go
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
	Chandef mh_inputCh;
	int i;
	Chandef mh_joinAttemptCh;
	Chandef deferredCh;
	Chandef mh_callCh;
	Chandef mh_stopCh;
	bool state = false;
	
	if
	:: config_GetMatch_DeferredQueueSize > 0 -> 
		deferredCh.size = config_GetMatch_DeferredQueueSize;
		run emptyChan(deferredCh)
	:: else -> 
		run sync_monitor(deferredCh)
	fi;
	
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
	
	if
	:: config_GetMatch_InputQueueSize > 0 -> 
		mh_inputCh.size = config_GetMatch_InputQueueSize;
		run emptyChan(mh_inputCh)
	:: else -> 
		run sync_monitor(mh_inputCh)
	fi;
	
	if
	:: config_GetMatch_CallQueueSize > 0 -> 
		mh_callCh.size = config_GetMatch_CallQueueSize;
		run emptyChan(mh_callCh)
	:: else -> 
		run sync_monitor(mh_callCh)
	fi;
	
	if
	:: config_GetMatch_JoinAttemptQueueSize > 0 -> 
		mh_joinAttemptCh.size = config_GetMatch_JoinAttemptQueueSize;
		run emptyChan(mh_joinAttemptCh)
	:: else -> 
		run sync_monitor(mh_joinAttemptCh)
	fi;
	run sync_monitor(mh_stopCh);
	run Anonymous0(deferredCh);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef deferredCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
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

