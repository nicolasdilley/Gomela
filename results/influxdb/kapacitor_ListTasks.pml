#define lb_for103_0  -1
#define ub_for103_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example284558253/chronograf/.kapacitor/kapa_client.go
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
	Wgdef gatherWg;
	Chandef optChan;
	int taskChan = 5;
	Chandef done;
	int optChan = 5;
	bool state = false;
	Chandef taskChan;
	Wgdef wg;
	int ListTaskWorkers = 5;
	int TaskGatherers = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(optChan);
	
	if
	:: 4 > 0 -> 
		taskChan.size = 4;
		run emptyChan(taskChan)
	:: else -> 
		run sync_monitor(taskChan)
	fi;
	run sync_monitor(done);
	run go_pgenerateKapacitorOptions(optChan,done);
	run wgMonitor(wg);
	wg.Add!ListTaskWorkers;
		for(i : 0.. ListTaskWorkers-1) {
for20:		run go_pfetchFromKapacitor(optChan,wg,taskChan,done,optChan)
	};
for20_exit:	run wgMonitor(gatherWg);
	gatherWg.Add!TaskGatherers;
	run Anonymous2(optChan,taskChan,done,wg,gatherWg);
	wg.Wait?0;
	taskChan.closing!true;
	gatherWg.Wait?0;
	goto stop_process
stop_process:}

proctype go_pgenerateKapacitorOptions(Chandef optChan;Chandef done) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: done.async_rcv?0 -> 
			optChan.closing!true;
			goto stop_process
		:: done.sync?0 -> 
			optChan.closing!true;
			goto stop_process
		:: optChan.async_send!0 -> 
			break
		:: optChan.sync!0 -> 
			optChan.sending?0;
			break
		od
	od;
for10_exit:stop_process:
}
proctype go_pfetchFromKapacitor(Chandef optChan;Wgdef wg;Chandef taskChan;Chandef done;int optChan) {
	bool closed; 
	int i;
	do
	:: optChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			optChan.in?0;
			
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
			:: taskChan.async_send!0;
			:: taskChan.sync!0 -> 
				taskChan.sending?0
			fi
		fi
	od;
	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Chandef optChan;Chandef taskChan;Chandef done;Wgdef wg;Wgdef gatherWg) {
	bool closed; 
	int i;
	do
	:: taskChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			taskChan.in?0
		fi
	od;
	gatherWg.Add!-1;
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

