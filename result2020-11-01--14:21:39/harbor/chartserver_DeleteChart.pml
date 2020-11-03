#define DeleteChart_qSize 1
#define DeleteChart_allVersions 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example190001440/src/chartserver/handler_utility.go
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
	Chandef tokenQueue;
	int allVersions = DeleteChart_allVersions;
	Chandef errWrapper;
	bool state = false;
	Chandef errChan;
	int qSize = DeleteChart_qSize;
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
	:: qSize > 0 -> 
		tokenQueue.size = qSize;
		run emptyChan(tokenQueue)
	:: else -> 
		run sync_monitor(tokenQueue)
	fi;
	
	if
	:: 1 > 0 -> 
		errChan.size = 1;
		run emptyChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	
	if
	:: 0 != -1 && qSize-1 != -1 -> 
				for(i : 0.. qSize-1) {
for10:			
			if
			:: tokenQueue.async_send!0;
			:: tokenQueue.sync!0 -> 
				tokenQueue.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: tokenQueue.async_send!0;
			:: tokenQueue.sync!0 -> 
				tokenQueue.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: 1 > 0 -> 
		errWrapper.size = 1;
		run emptyChan(errWrapper)
	:: else -> 
		run sync_monitor(errWrapper)
	fi;
	run Anonymous0(tokenQueue,errChan,errWrapper);
		for(i : 0.. allVersions-1) {
for30:		
		if
		:: tokenQueue.async_rcv?0;
		:: tokenQueue.sync?0;
		fi;
		run Anonymous1(tokenQueue,errChan,errWrapper)
	};
	errChan.closing!true;
	
	if
	:: errWrapper.async_rcv?0;
	:: errWrapper.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef tokenQueue;Chandef errChan;Chandef errWrapper) {
	bool closed; 
	int i;
	bool state;
	do
	:: errChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: errChan.async_rcv?0;
			:: errChan.sync?0;
			fi
		fi
	od;
stop_process:	
	if
	:: true -> 
		
		if
		:: errWrapper.async_send!0;
		:: errWrapper.sync!0 -> 
			errWrapper.sending?0
		fi
	:: true;
	fi;
	errWrapper.closing!true
}
proctype Anonymous1(Chandef tokenQueue;Chandef errChan;Chandef errWrapper) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: errChan.async_send!0;
		:: errChan.sync!0 -> 
			errChan.sending?0
		fi
	:: true;
	fi;
stop_process:	
	if
	:: tokenQueue.async_send!0;
	:: tokenQueue.sync!0 -> 
		tokenQueue.sending?0
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


