
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example661427707/storage/cache/subtree_cache.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int want = 5;
	Chandef workTokens;
	int subtrees = 5;
	Chandef ch;
	Wgdef wg;
	int s_populateConcurrency = 5;
	int i;
		for(i : 1.. ids) {
for10:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. want) {
for20:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: want > 0 -> 
		ch.size = want;
		run emptyChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	
	if
	:: s_populateConcurrency > 0 -> 
		workTokens.size = s_populateConcurrency;
		run emptyChan(workTokens)
	:: else -> 
		run sync_monitor(workTokens)
	fi;
	
	if
	:: 0 != -1 && s_populateConcurrency-1 != -1 -> 
				for(i : 0.. s_populateConcurrency-1) {
for30:			
			if
			:: workTokens.async_send!0;
			:: workTokens.sync!0 -> 
				workTokens.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: workTokens.async_send!0;
			:: workTokens.sync!0 -> 
				workTokens.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	run wgMonitor(wg);
		for(i : 1.. subtrees) {
for40:		wg.Add!1;
		run Anonymous0(ch,workTokens)
	};
	run Anonymous1(ch,workTokens);
	do
	:: ch.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: ch.async_rcv?0;
			:: ch.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
		for(i : 1.. want) {
for60:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef ch;Chandef workTokens) {
	bool closed; 
	int i;
	
	if
	:: workTokens.async_rcv?0;
	:: workTokens.sync?0;
	fi;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	
	if
	:: workTokens.async_send!0;
	:: workTokens.sync!0 -> 
		workTokens.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef ch;Chandef workTokens) {
	bool closed; 
	int i;
	ch.closing!true;
	workTokens.closing!true;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od;
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

