#define StartConsuming_concurrency  60
#define lb_for102_1  -1
#define ub_for102_2  -1
#define lb_for135_3  -1
#define ub_for135_4  -1
#define lb_for260_5  -1
#define ub_for260_6  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example846698130/v1/brokers/redis/redis.go
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
	Chandef pool;
	bool state = false;
	int concurrency = StartConsuming_concurrency;
	Chandef deliveries;
	chan child_bconsume0 = [0] of {int};
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: concurrency > 0 -> 
		deliveries.size = concurrency;
		run emptyChan(deliveries)
	:: else -> 
		run sync_monitor(deliveries)
	fi;
	
	if
	:: concurrency > 0 -> 
		pool.size = concurrency;
		run emptyChan(pool)
	:: else -> 
		run sync_monitor(pool)
	fi;
	
	if
	:: 0 != -1 && concurrency-1 != -1 -> 
				for(i : 0.. concurrency-1) {
for10:			
			if
			:: pool.async_send!0;
			:: pool.sync!0 -> 
				pool.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: pool.async_send!0;
			:: pool.sync!0 -> 
				pool.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	run Anonymous0(deliveries,pool);
	run Anonymous1(deliveries,pool);
	run bconsume(deliveries,concurrency,child_bconsume0);
	child_bconsume0?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef deliveries;Chandef pool) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		do
		:: pool.async_rcv?0 -> 
			do
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: deliveries.async_send!0;
					:: deliveries.sync!0 -> 
						deliveries.sending?0
					fi
				:: true;
				fi
			:: true;
			fi;
			
			if
			:: pool.async_send!0;
			:: pool.sync!0 -> 
				pool.sending?0
			fi;
			break
		:: pool.sync?0 -> 
			do
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: deliveries.async_send!0;
					:: deliveries.sync!0 -> 
						deliveries.sending?0
					fi
				:: true;
				fi
			:: true;
			fi;
			
			if
			:: pool.async_send!0;
			:: pool.sync!0 -> 
				pool.sending?0
			fi;
			break
		od
	od;
for20_exit:stop_process:
}
proctype Anonymous1(Chandef deliveries;Chandef pool) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for30:		do
		:: true -> 
			break
		od
	od;
for30_exit:stop_process:
}
proctype bconsume(Chandef deliveries;int concurrency;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef errorsChan;
	Chandef pool;
	
	if
	:: concurrency * 2 > 0 -> 
		errorsChan.size = concurrency * 2;
		run emptyChan(errorsChan)
	:: else -> 
		run sync_monitor(errorsChan)
	fi;
	
	if
	:: concurrency > 0 -> 
		pool.size = concurrency;
		run emptyChan(pool)
	:: else -> 
		run sync_monitor(pool)
	fi;
	run Anonymous3(errorsChan,pool,deliveries);
		for(i : lb_for260_5.. ub_for260_6) {
for50:		do
		:: errorsChan.async_rcv?0 -> 
			goto stop_process
		:: errorsChan.sync?0 -> 
			goto stop_process
		:: deliveries.async_rcv?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: pool.async_rcv?0;
				:: pool.sync?0;
				fi
			:: true;
			fi;
			run Anonymous4(errorsChan,pool,deliveries);
			break
		:: deliveries.sync?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: pool.async_rcv?0;
				:: pool.sync?0;
				fi
			:: true;
			fi;
			run Anonymous4(errorsChan,pool,deliveries);
			break
		od
	};
for50_exit:	child!0;
stop_process:
}
proctype Anonymous3(Chandef errorsChan;Chandef pool;Chandef deliveries) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && concurrency-1 != -1 -> 
				for(i : 0.. concurrency-1) {
for40:			
			if
			:: pool.async_send!0;
			:: pool.sync!0 -> 
				pool.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for40:			
			if
			:: pool.async_send!0;
			:: pool.sync!0 -> 
				pool.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for40_exit:stop_process:
}
proctype Anonymous4(Chandef errorsChan;Chandef pool;Chandef deliveries) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: errorsChan.async_send!0;
		:: errorsChan.sync!0 -> 
			errorsChan.sending?0
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: pool.async_send!0;
		:: pool.sync!0 -> 
			pool.sending?0
		fi
	:: true;
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

