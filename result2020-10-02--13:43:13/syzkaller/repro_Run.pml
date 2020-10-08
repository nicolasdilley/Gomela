#define lb_for166_0  -1
#define ub_for166_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example617981797/pkg/repro/repro.go
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
	Chandef ctx_bootRequests;
	bool state = false;
	int maxTry = 5;
	Chandef ctx_instances;
	Wgdef wg;
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
	:: true;
	:: true;
	:: true;
	fi;
	
	if
	:: vmIndexes > 0 -> 
		ctx_instances.size = vmIndexes;
		run emptyChan(ctx_instances)
	:: else -> 
		run sync_monitor(ctx_instances)
	fi;
	
	if
	:: vmIndexes > 0 -> 
		ctx_bootRequests.size = vmIndexes;
		run emptyChan(ctx_bootRequests)
	:: else -> 
		run sync_monitor(ctx_bootRequests)
	fi;
	run wgMonitor(wg);
	wg.Add!vmIndexes;
		for(i : 1.. vmIndexes) {
for10:		
		if
		:: ctx_bootRequests.async_send!0;
		:: ctx_bootRequests.sync!0 -> 
			ctx_bootRequests.sending?0
		fi;
		run Anonymous0(wg)
	};
	run Anonymous1(wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: lb_for166_0 != -1 && ub_for166_1 != -1 -> 
						for(i : lb_for166_0.. ub_for166_1) {
for30:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for30:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for30_exit:
	:: true;
	fi;
	goto stop_process;
	ctx_bootRequests.closing!true;
	do
	:: ctx_instances.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: ctx_instances.async_rcv?0;
			:: ctx_instances.sync?0;
			fi
		fi
	od
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		
		if
		:: 0 != -1 && maxTry-1 != -1 -> 
						for(i : 0.. maxTry-1) {
for12:				do
				:: true;
				:: true -> 
					break
				od;
				break
			}
		:: else -> 
			do
			:: true -> 
for12:				do
				:: true;
				:: true -> 
					break
				od;
				break
			:: true -> 
				break
			od
		fi;
for12_exit:		
		if
		:: true -> 
			break
		:: true;
		fi
	:: true -> 
		break
	od;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	wg.Wait?0;
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

