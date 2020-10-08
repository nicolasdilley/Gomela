#define lb_for49_0  -1
#define ub_for49_1  -1
#define lb_for73_2  -1
#define ub_for73_3  -1
#define lb_for228_4  -1
#define ub_for228_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example544083241/anycast/anycast.go
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
	Chandef notify;
	int i;
	Chandef stop;
	int dummies = 5;
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

proctype anycastdoAdvertiseRoutes(Chandef notify;Chandef stop;int peers;int netblocks;int interfaces;int dummies;chan child) {
	bool closed; 
	int i;
	Chandef stopper;
	Wgdef wg;
	
	if
	:: 1024 > 0 -> 
		stopper.size = 1024;
		run emptyChan(stopper)
	:: else -> 
		run sync_monitor(stopper)
	fi;
	run wgMonitor(wg);
	run go_anycastwatchRoutes(stopper,wg);
	run go_anycastwatchPeerState(stopper,wg);
		for(i : 1.. peers) {
for30:
	};
		for(i : 1.. netblocks) {
for40:
	};
		for(i : 1.. interfaces) {
for50:				for(i : 1.. netblocks) {
for51:
		}
	};
	do
	:: true -> 
for60:
	:: true -> 
		break
	od;
	do
	:: true -> 
for70:		
		if
		:: notify.async_send!0;
		:: notify.sync!0 -> 
			notify.sending?0
		fi
	:: true -> 
		break
	od;
		for(i : 1.. dummies) {
for80:
	};
	do
	:: stop.async_rcv?0 -> 
		goto for80_exit
	:: stop.sync?0 -> 
		goto for80_exit;
		break
	od;
	
	if
	:: lb_for228_4 != -1 && ub_for228_5 != -1 -> 
				for(i : lb_for228_4.. ub_for228_5) {
for90:			
			if
			:: stopper.async_send!0;
			:: stopper.sync!0 -> 
				stopper.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for90:			
			if
			:: stopper.async_send!0;
			:: stopper.sync!0 -> 
				stopper.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for90_exit:	wg.Wait?0;
	child!0;
stop_process:
}
proctype go_anycastwatchRoutes(Chandef stop;Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!1;
	
	if
	:: lb_for49_0 != -1 && ub_for49_1 != -1 -> 
				for(i : lb_for49_0.. ub_for49_1) {
for10:			do
			:: stop.async_rcv?0 -> 
				goto for10_exit
			:: stop.sync?0 -> 
				goto for10_exit;
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: stop.async_rcv?0 -> 
				goto for10_exit
			:: stop.sync?0 -> 
				goto for10_exit;
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	wg.Add!-1;
stop_process:
}
proctype go_anycastwatchPeerState(Chandef stop;Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!1;
	
	if
	:: lb_for73_2 != -1 && ub_for73_3 != -1 -> 
				for(i : lb_for73_2.. ub_for73_3) {
for20:			do
			:: stop.async_rcv?0 -> 
				goto for20_exit
			:: stop.sync?0 -> 
				goto for20_exit;
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: stop.async_rcv?0 -> 
				goto for20_exit
			:: stop.sync?0 -> 
				goto for20_exit;
				break
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	wg.Add!-1;
stop_process:
}
proctype Anonymous0(Chandef notify;Chandef stop) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		chan child_anycastdoAdvertiseRoutes0 = [0] of {int};
		run anycastdoAdvertiseRoutes(notify,stop,peers,netblocks,interfaces,dummies,child_anycastdoAdvertiseRoutes0);
		child_anycastdoAdvertiseRoutes0?0
	fi;
	
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

