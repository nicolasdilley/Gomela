#define lb_for63_0  -1
#define ub_for63_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example544083241/netinterface/interface.go
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
	int i;
	Chandef stop;
	Chandef notify;
	Wgdef wg;
	bool state = false;
	
	if
	:: 1024 > 0 -> 
		notify.size = 1024;
		run emptyChan(notify)
	:: else -> 
		run sync_monitor(notify)
	fi;
	
	if
	:: 1 > 0 -> 
		stop.size = 1;
		run emptyChan(stop)
	:: else -> 
		run sync_monitor(stop)
	fi;
	run wgMonitor(wg);
	run Anonymous0(notify,stop);
	goto stop_process
stop_process:}

proctype netinterfacemanageInterfaces(Chandef notify;Chandef stop;int ifaces;chan child) {
	bool closed; 
	int i;
		for(i : 1.. ifaces) {
for10:
	};
	
	if
	:: lb_for63_0 != -1 && ub_for63_1 != -1 -> 
				for(i : lb_for63_0.. ub_for63_1) {
for20:			do
			:: true -> 
				do
				:: true -> 
for21:					do
					:: true -> 
for22:												for(i : 1.. ifaces) {
for23:
						}
					:: true -> 
						break
					od
				:: true -> 
					break
				od;
				do
				:: true -> 
for24:					
					if
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: notify.async_send!0;
							:: notify.sync!0 -> 
								notify.sending?0
							fi
						:: true;
						fi
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: notify.async_send!0;
							:: notify.sync!0 -> 
								notify.sending?0
							fi
						:: true;
						fi
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: notify.async_send!0;
							:: notify.sync!0 -> 
								notify.sending?0
							fi
						:: true;
						fi
					fi
				:: true -> 
					break
				od
			:: stop.async_rcv?0 -> 
				break
			:: stop.sync?0 -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: true -> 
				do
				:: true -> 
for21:					do
					:: true -> 
for22:												for(i : 1.. ifaces) {
for23:
						}
					:: true -> 
						break
					od
				:: true -> 
					break
				od;
				do
				:: true -> 
for24:					
					if
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: notify.async_send!0;
							:: notify.sync!0 -> 
								notify.sending?0
							fi
						:: true;
						fi
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: notify.async_send!0;
							:: notify.sync!0 -> 
								notify.sending?0
							fi
						:: true;
						fi
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: notify.async_send!0;
							:: notify.sync!0 -> 
								notify.sending?0
							fi
						:: true;
						fi
					fi
				:: true -> 
					break
				od
			:: stop.async_rcv?0 -> 
				break
			:: stop.sync?0 -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	child!0;
stop_process:
}
proctype Anonymous0(Chandef notify;Chandef stop) {
	bool closed; 
	int i;
	chan child_netinterfacemanageInterfaces0 = [0] of {int};
	run netinterfacemanageInterfaces(notify,stop,ifaces,child_netinterfacemanageInterfaces0);
	child_netinterfacemanageInterfaces0?0;
	
	if
	:: true -> 
		
		if
		:: notify.async_send!0;
		:: notify.sync!0 -> 
			notify.sending?0
		fi
	:: true;
	fi;
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

