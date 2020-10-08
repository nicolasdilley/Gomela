
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example250238556/optimize/minimize.go
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
	int i;
	Chandef statsChan;
	Chandef results;
	int nTasks = 5;
	Chandef operations;
	Chandef workerChan;
	Chandef done;
	int tasks = 5;
	bool state = false;
	
	if
	:: nTasks > 0 -> 
		operations.size = nTasks;
		run emptyChan(operations)
	:: else -> 
		run sync_monitor(operations)
	fi;
	
	if
	:: nTasks > 0 -> 
		results.size = nTasks;
		run emptyChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
	run Anonymous0(operations,results,workerChan,statsChan,done);
	run sync_monitor(workerChan);
	run sync_monitor(statsChan);
	run sync_monitor(done);
		for(i : 0.. nTasks-1) {
for20:
	};
for20_exit:	do
	:: statsChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: statsChan.async_rcv?0;
			:: statsChan.sync?0;
			fi;
			

			if
			:: true;
			:: true -> 
				
				if
				:: true -> 
					results.closing!true
				:: true;
				fi
			:: true;
			:: true;
			:: true;
			fi;
			
			if
			:: true -> 
				do
				:: done.async_rcv?0 -> 
					break
				:: done.sync?0 -> 
					break
				:: true -> 
					
					if
					:: results.async_send!0;
					:: results.sync!0 -> 
						results.sending?0
					fi;
					done.closing!true;
					break
				od
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: results.async_send!0;
				:: results.sync!0 -> 
					results.sending?0
				fi
			:: true;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype methodRun(Chandef operation;Chandef result;chan child) {
	bool closed; 
	int i;
	operation.closing!true;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef operations;Chandef results;Chandef workerChan;Chandef statsChan;Chandef done) {
	bool closed; 
	int i;
	chan child_methodRun0 = [0] of {int};
	
	if
	:: 1 != -1 && tasks-1 != -1 -> 
				for(i : 1.. tasks-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	run methodRun(operations,results,child_methodRun0);
	child_methodRun0?0;
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

