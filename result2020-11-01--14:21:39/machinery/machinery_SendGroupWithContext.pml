#define SendGroupWithContext_group_Tasks 0
#define SendGroupWithContext_sendConcurrency 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example136809259/v1/server.go
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
	Chandef done;
	Chandef errorsChan;
	int sendConcurrency = SendGroupWithContext_sendConcurrency;
	Wgdef wg;
	Chandef pool;
	int group_Tasks = SendGroupWithContext_group_Tasks;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	wg.Add!group_Tasks;
	
	if
	:: group_Tasks * 2 > 0 -> 
		errorsChan.size = group_Tasks * 2;
		run emptyChan(errorsChan)
	:: else -> 
		run sync_monitor(errorsChan)
	fi;
		for(i : 0.. group_Tasks-1) {
for10:		
		if
		:: true -> 
			
			if
			:: errorsChan.async_send!0;
			:: errorsChan.sync!0 -> 
				errorsChan.sending?0
			fi
		:: true;
		fi
	};
	
	if
	:: sendConcurrency > 0 -> 
		pool.size = sendConcurrency;
		run emptyChan(pool)
	:: else -> 
		run sync_monitor(pool)
	fi;
	run Anonymous0(errorsChan,pool,done,wg);
		for(i : 0.. group_Tasks-1) {
for30:		
		if
		:: true -> 
			
			if
			:: pool.async_rcv?0;
			:: pool.sync?0;
			fi
		:: true;
		fi;
		run Anonymous1(errorsChan,pool,done,wg)
	};
	run sync_monitor(done);
	run Anonymous2(errorsChan,pool,done,wg);
	do
	:: errorsChan.async_rcv?0 -> 
		goto stop_process
	:: errorsChan.sync?0 -> 
		goto stop_process
	:: done.async_rcv?0 -> 
		goto stop_process
	:: done.sync?0 -> 
		goto stop_process
	od
stop_process:}

proctype Anonymous0(Chandef errorsChan;Chandef pool;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && sendConcurrency-1 != -1 -> 
				for(i : 0.. sendConcurrency-1) {
for20:			
			if
			:: pool.async_send!0;
			:: pool.sync!0 -> 
				pool.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: pool.async_send!0;
			:: pool.sync!0 -> 
				pool.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:stop_process:
}
proctype Anonymous1(Chandef errorsChan;Chandef pool;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: pool.async_send!0;
		:: pool.sync!0 -> 
			pool.sending?0
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errorsChan.async_send!0;
		:: errorsChan.sync!0 -> 
			errorsChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
stop_process:	wg.Add!-1
}
proctype Anonymous2(Chandef errorsChan;Chandef pool;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Wait?0;
	
	if
	:: done.async_send!0;
	:: done.sync!0 -> 
		done.sending?0
	fi;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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
	od
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


