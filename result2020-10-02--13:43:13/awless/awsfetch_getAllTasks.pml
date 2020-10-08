
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example582296028/aws/fetch/ecs_helpers.go
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
	Chandef tasksNamesc;
	int clusterArns = 5;
	Chandef tasksc;
	bool state = false;
	Wgdef wg;
	Wgdef tasksWG;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(tasksNamesc);
	run wgMonitor(wg);
		for(i : 1.. clusterArns) {
for10:		wg.Add!1;
		run Anonymous0(tasksNamesc,tasksc,wg,tasksWG);
		wg.Add!1;
		run Anonymous1(tasksNamesc,tasksc,wg,tasksWG)
	};
	run sync_monitor(tasksc);
	run wgMonitor(tasksWG);
	tasksWG.Add!1;
	run Anonymous2(tasksNamesc,tasksc,wg,tasksWG);
	run Anonymous4(tasksNamesc,tasksc,wg,tasksWG);
	do
	:: tasksc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: tasksc.async_rcv?0;
			:: tasksc.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef tasksNamesc;Chandef tasksc;Wgdef wg;Wgdef tasksWG) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: tasksNamesc.async_send!0;
		:: tasksNamesc.sync!0 -> 
			tasksNamesc.sending?0
		fi
	:: true;
	fi;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Chandef tasksNamesc;Chandef tasksc;Wgdef wg;Wgdef tasksWG) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: tasksNamesc.async_send!0;
		:: tasksNamesc.sync!0 -> 
			tasksNamesc.sending?0
		fi
	:: true;
	fi;
	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Chandef tasksNamesc;Chandef tasksc;Wgdef wg;Wgdef tasksWG) {
	bool closed; 
	int i;
	
	if
	:: tasksc.async_send!0;
	:: tasksc.sync!0 -> 
		tasksc.sending?0
	fi;
	tasksWG.Add!-1;
stop_process:
}
proctype Anonymous2(Chandef tasksNamesc;Chandef tasksc;Wgdef wg;Wgdef tasksWG) {
	bool closed; 
	int i;
	do
	:: tasksNamesc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: tasksNamesc.async_rcv?0;
			:: tasksNamesc.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: tasksc.async_send!0;
				:: tasksc.sync!0 -> 
					tasksc.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			tasksWG.Add!1;
			run Anonymous2(tasksNamesc,tasksc,wg,tasksWG)
		fi
	od;
	tasksWG.Add!-1;
stop_process:
}
proctype Anonymous4(Chandef tasksNamesc;Chandef tasksc;Wgdef wg;Wgdef tasksWG) {
	bool closed; 
	int i;
	wg.Wait?0;
	tasksNamesc.closing!true;
	tasksWG.Wait?0;
	tasksc.closing!true;
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

