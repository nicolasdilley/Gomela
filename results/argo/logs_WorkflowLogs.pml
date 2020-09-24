#define lb_for167_0  -1
#define ub_for167_1  -1
#define lb_for204_2  -1
#define ub_for204_3  -1
#define lb_for267_4  -1
#define ub_for267_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example257172985/util/logs/workflow-logger.go
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
	Chandef unsortedEntries;
	bool state = false;
	int list_Items = 5;
	Wgdef wg;
	Chandef doneSorting;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	
	if
	:: 128 > 0 -> 
		unsortedEntries.size = 128;
		run emptyChan(unsortedEntries)
	:: else -> 
		run sync_monitor(unsortedEntries)
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
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		Chandef stopWatchingPods;
		run sync_monitor(stopWatchingPods);
		wg.Add!1;
		run Anonymous0(unsortedEntries,stopWatchingPods,doneSorting,wg);
		wg.Add!1;
		run Anonymous1(unsortedEntries,stopWatchingPods,doneSorting,wg)
	fi;
	run sync_monitor(doneSorting);
	run Anonymous2(unsortedEntries,stopWatchingPods,doneSorting,wg);
	wg.Wait?0;
	unsortedEntries.closing!true;
	
	if
	:: doneSorting.async_rcv?0;
	:: doneSorting.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef unsortedEntries;Chandef stopWatchingPods;Chandef doneSorting;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:	stopWatchingPods.closing!true;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Chandef unsortedEntries;Chandef stopWatchingPods;Chandef doneSorting;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		do
		:: stopWatchingPods.async_rcv?0 -> 
			goto stop_process
		:: stopWatchingPods.sync?0 -> 
			goto stop_process
		od
	od;
for30_exit:	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Chandef unsortedEntries;Chandef stopWatchingPods;Chandef doneSorting;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for40:		do
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		od
	od;
for40_exit:	doneSorting.closing!true;
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

