#define lb_for230_0  -1
#define ub_for230_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example003149851/services/retentionmgr/retention.go
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
	int t_jobsC = 5;
	int t_NumWorkers = 5;
	int i;
	
	if
	:: true -> 
		Chandef t_jobsC;
		
		if
		:: 65536 > 0 -> 
			t_jobsC.size = 65536;
			run emptyChan(t_jobsC)
		:: else -> 
			run sync_monitor(t_jobsC)
		fi;
		Chandef t_stopC;
		run sync_monitor(t_stopC);
				for(i : 0.. t_NumWorkers-1) {
for10:			run go_tretentionWorker(t_jobsC,t_jobsC)
		};
for10_exit:		
		if
		:: true -> 
			run Anonymous1(t_jobsC,t_stopC)
		:: true;
		fi
	:: true;
	fi
stop_process:}

proctype go_tretentionWorker(Chandef jobsC;int jobsC) {
	bool closed; 
	int i;
workerLoop:		do
	:: jobsC.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			jobsC.in?0;
			do
			:: true;
			:: true -> 
				goto workerLoop
			od;
			
			if
			:: true -> 
				do
				:: true -> 
for12:
				:: true -> 
					break
				od;
				
				if
				:: true -> 
iterateConsumers:										do
					:: true -> 
for13:
					:: true -> 
						break
					od
				:: true;
				fi
			fi
		fi
	od;
	do
	:: jobsC.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			jobsC.in?0
		fi
	od;
stop_process:
}
proctype Anonymous1(Chandef t_jobsC;Chandef t_stopC) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: true;
		:: true -> 
			goto stop_process
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for20_exit:stop_process:
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

