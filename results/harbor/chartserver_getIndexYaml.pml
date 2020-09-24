#define initialItemCount  5
#define namespaces  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example936923273/src/chartserver/handler_repo.go
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
	int mergedIndexFile_PublicKeys = 5;
	Chandef mergeDone;
	Chandef resultChan;
	int initialItemCount = 5;
	int i;
	Chandef errorChan;
	Chandef workerPool;
	int resultChan = 5;
	int hash = 5;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		resultChan.size = 1;
		run emptyChan(resultChan)
	:: else -> 
		run sync_monitor(resultChan)
	fi;
	
	if
	:: 1 > 0 -> 
		errorChan.size = 1;
		run emptyChan(errorChan)
	:: else -> 
		run sync_monitor(errorChan)
	fi;
	
	if
	:: 1 > 0 -> 
		mergeDone.size = 1;
		run emptyChan(mergeDone)
	:: else -> 
		run sync_monitor(mergeDone)
	fi;
	
	if
	:: initialItemCount > 0 -> 
		workerPool.size = initialItemCount;
		run emptyChan(workerPool)
	:: else -> 
		run sync_monitor(workerPool)
	fi;
	
	if
	:: 0 != -1 && initialItemCount-1 != -1 -> 
				for(i : 0.. initialItemCount-1) {
for10:			
			if
			:: workerPool.async_send!0;
			:: workerPool.sync!0 -> 
				workerPool.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: workerPool.async_send!0;
			:: workerPool.sync!0 -> 
				workerPool.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	run Anonymous0(resultChan,errorChan,mergeDone,workerPool);
LOOP:			for(i : 1.. namespaces) {
for30:		do
		:: true -> 
			break
		od;
		
		if
		:: workerPool.async_rcv?0;
		:: workerPool.sync?0;
		fi;
		run Anonymous1(resultChan,errorChan,mergeDone,workerPool)
	};
	resultChan.closing!true;
	
	if
	:: mergeDone.async_rcv?0;
	:: mergeDone.sync?0;
	fi;
	
	if
	:: true -> 
		
		if
		:: errorChan.async_rcv?0;
		:: errorChan.sync?0;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for40:
	:: true -> 
		break
	od;
	do
	:: true -> 
for50:
	:: true -> 
		break
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef resultChan;Chandef errorChan;Chandef mergeDone;Chandef workerPool) {
	bool closed; 
	int i;
	do
	:: resultChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			resultChan.in?0
		fi
	od;
	
	if
	:: mergeDone.async_send!0;
	:: mergeDone.sync!0 -> 
		mergeDone.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef resultChan;Chandef errorChan;Chandef mergeDone;Chandef workerPool) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: errorChan.async_send!0;
			:: errorChan.sync!0 -> 
				errorChan.sending?0
			fi
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: resultChan.async_send!0;
	:: resultChan.sync!0 -> 
		resultChan.sending?0
	fi;
	
	if
	:: workerPool.async_send!0;
	:: workerPool.sync!0 -> 
		workerPool.sending?0
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

