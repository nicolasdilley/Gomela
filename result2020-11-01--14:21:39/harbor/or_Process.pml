#define Process_result_processed 0
#define Process_p_evaluators 0
#define Process_selectors 1
#define Process_processedCandidates 0
#define Process_cl 0
#define lb_for94_5  -1
#define ub_for94_6  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example190001440/src/pkg/retention/policy/alg/or/processor.go
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
	int selectors = Process_selectors;
	Chandef errChan;
	bool state = false;
	int result_processed = Process_result_processed;
	int cl = Process_cl;
	Chandef resChan;
	Chandef done;
	int p_evaluators = Process_p_evaluators;
	int processedCandidates = Process_processedCandidates;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		resChan.size = 1;
		run emptyChan(resChan)
	:: else -> 
		run sync_monitor(resChan)
	fi;
	
	if
	:: 1 > 0 -> 
		errChan.size = 1;
		run emptyChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	
	if
	:: 1 > 0 -> 
		done.size = 1;
		run emptyChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	run Anonymous0(resChan,errChan,done);
		for(i : 0.. p_evaluators-1) {
for20:		run Anonymous1(resChan,errChan,done)
	};
	resChan.closing!true;
	
	if
	:: done.async_rcv?0;
	:: done.sync?0;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. processedCandidates-1) {
for30:		
		if
		:: true -> 
						for(i : 0.. cl-1) {
for31:
			}
		:: true;
		fi
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef resChan;Chandef errChan;Chandef done) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: resChan.async_rcv?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
						for(i : 0.. result_processed-1) {
for11:
			};
			break
		:: resChan.sync?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
						for(i : 0.. result_processed-1) {
for11:
			};
			break
		:: errChan.async_rcv?0 -> 
			break
		:: errChan.sync?0 -> 
			break
		od
	od;
for10_exit:stop_process:	
	if
	:: done.async_send!0;
	:: done.sync!0 -> 
		done.sending?0
	fi
}
proctype Anonymous1(Chandef resChan;Chandef errChan;Chandef done) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
				for(i : 0.. selectors-1) {
for21:			
			if
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		}
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errChan.async_send!0;
		:: errChan.sync!0 -> 
			errChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: resChan.async_send!0;
	:: resChan.sync!0 -> 
		resChan.sending?0
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


