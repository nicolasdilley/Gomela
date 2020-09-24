#define lb_for415_0  -1
#define ub_for415_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example853213546/main.go
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
	Wgdef wg;
	bool state = false;
	int opts_ifaceRegex = 5;
	Chandef sigs;
	int opts_iface = 5;
	int i;
	
	if
	:: true -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			do
			:: true -> 
for20:				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true -> 
				break
			od
		:: true;
		fi
	:: true -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			do
			:: true -> 
for20:				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true -> 
				break
			od
		:: true;
		fi
	fi;
	
	if
	:: 1 > 0 -> 
		sigs.size = 1;
		run emptyChan(sigs)
	:: else -> 
		run sync_monitor(sigs)
	fi;
	run wgMonitor(wg);
	wg.Add!1;
	run Anonymous0(sigs);
	
	if
	:: true -> 
		wg.Wait?0
	:: true;
	fi;
	
	if
	:: true -> 
		wg.Wait?0
	:: true;
	fi;
	
	if
	:: true -> 
		wg.Wait?0
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			wg.Wait?0
		:: true;
		fi
	:: true;
	fi;
	wg.Add!1;
	run Anonymous2(sigs);
	
	if
	:: true -> 
		chan child_mainMonitorLease1 = [0] of {int};
		run mainMonitorLease(wg,child_mainMonitorLease1);
		child_mainMonitorLease1?0
	:: true;
	fi;
	wg.Wait?0
stop_process:}

proctype mainshutdownHandler(Chandef sigs;chan child) {
	bool closed; 
	int i;
	do
	:: true;
	:: sigs.async_rcv?0 -> 
		break
	:: sigs.sync?0 -> 
		break
	od;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef sigs) {
	bool closed; 
	int i;
	chan child_mainshutdownHandler0 = [0] of {int};
	run mainshutdownHandler(sigs,child_mainshutdownHandler0);
	child_mainshutdownHandler0?0;
stop_process:
}
proctype Anonymous2(Chandef sigs) {
	bool closed; 
	int i;
stop_process:
}
proctype mainMonitorLease(Wgdef wg;chan child) {
	bool closed; 
	int i;
	Chandef evts;
	run sync_monitor(evts);
	wg.Add!1;
	run Anonymous4(evts);
	do
	:: true -> 
for30:		do
		:: true;
		:: true -> 
			goto stop_process
		od
	od;
for30_exit:	child!0;
stop_process:
}
proctype Anonymous4(Chandef evts) {
	bool closed; 
	int i;
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

