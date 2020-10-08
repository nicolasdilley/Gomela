
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example811888897/store/tikv/2pc.go
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
	Chandef exitCh;
	Chandef ch;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: batches > 0 -> 
		ch.size = batches;
		run emptyChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run sync_monitor(exitCh);
	run go_batchExestartWorker(exitCh,ch,batches);
	
	if
	:: 0 != -1 && batches-1 != -1 -> 
				for(i : 0.. batches-1) {
for20:			
			if
			:: ch.async_rcv?0;
			:: ch.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: ch.async_rcv?0;
			:: ch.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	exitCh.closing!true;
	goto stop_process
stop_process:}

proctype go_batchExestartWorker(Chandef exitCh;Chandef ch;int batches) {
	bool closed; 
	int i;
		for(i : 1.. batches) {
for10:		chan child_batchExe_rateLimitergetToken0 = [0] of {int};
		run batchExe_rateLimitergetToken(exitCh,child_batchExe_rateLimitergetToken0);
		child_batchExe_rateLimitergetToken0?0;
		
		if
		:: true -> 
			run Anonymous2(exitCh,ch)
		:: true -> 
			break
		:: true -> 
			break
		fi
	};
stop_process:
}
proctype batchExe_rateLimitergetToken(Chandef done;chan child) {
	bool closed; 
	int i;
	do
	:: done.async_rcv?0 -> 
		goto stop_process
	:: done.sync?0 -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od;
	child!0;
stop_process:
}
proctype Anonymous2(Chandef exitCh;Chandef ch) {
	bool closed; 
	int i;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
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

