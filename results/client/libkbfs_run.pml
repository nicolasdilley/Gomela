#define lb_for294_0  -1
#define ub_for294_1  -1
#define lb_for169_2  -1
#define ub_for169_3  -1
#define lb_for326_4  -1
#define ub_for326_5  -1
#define lb_for342_6  -1
#define ub_for342_7  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example131909709/go/kbfs/libkbfs/online_status_tracker.go
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
	Chandef sideEffects;
	Chandef disconnected;
	Chandef tryingTimerUp;
	bool state = false;
	Chandef onlineStatusUpdates;
	Chandef connected;
	int i;
	
	if
	:: lb_for294_0 != -1 && ub_for294_1 != -1 -> 
				for(i : lb_for294_0.. ub_for294_1) {
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
for10_exit:	run sync_monitor(sideEffects);
	run sync_monitor(onlineStatusUpdates);
	run sync_monitor(tryingTimerUp);
	run sync_monitor(connected);
	run sync_monitor(disconnected);
	run go_libkbfsostFsm(sideEffects,onlineStatusUpdates,tryingTimerUp,connected,disconnected);
	run Anonymous1(sideEffects,onlineStatusUpdates,tryingTimerUp,connected,disconnected);
		for(i : lb_for342_6.. ub_for342_7) {
for40:		do
		:: true -> 
			
			if
			:: tryingTimerUp.async_send!0;
			:: tryingTimerUp.sync!0 -> 
				tryingTimerUp.sending?0
			fi
		:: true -> 
			goto stop_process
		od
	};
for40_exit:
stop_process:}

proctype go_libkbfsostFsm(Chandef sideEffects;Chandef onlineStatusUpdates;Chandef tryingTimerUp;Chandef connected;Chandef disconnected) {
	bool closed; 
	int i;
	do
	:: true -> 
		goto stop_process
	:: true -> 
		break
	od;
	do
	:: true -> 
for20:		

		if
		:: true -> 
			do
			:: true;
			:: true;
			:: tryingTimerUp.async_rcv?0 -> 
				break
			:: tryingTimerUp.sync?0 -> 
				break
			:: connected.async_rcv?0 -> 
				break
			:: connected.sync?0 -> 
				break
			:: disconnected.async_rcv?0 -> 
				
				if
				:: sideEffects.async_send!0;
				:: sideEffects.sync!0 -> 
					sideEffects.sending?0
				fi;
				
				if
				:: sideEffects.async_send!0;
				:: sideEffects.sync!0 -> 
					sideEffects.sending?0
				fi;
				break
			:: disconnected.sync?0 -> 
				
				if
				:: sideEffects.async_send!0;
				:: sideEffects.sync!0 -> 
					sideEffects.sending?0
				fi;
				
				if
				:: sideEffects.async_send!0;
				:: sideEffects.sync!0 -> 
					sideEffects.sending?0
				fi;
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			do
			:: true;
			:: true;
			:: tryingTimerUp.async_rcv?0 -> 
				break
			:: tryingTimerUp.sync?0 -> 
				break
			:: connected.async_rcv?0 -> 
				break
			:: connected.sync?0 -> 
				break
			:: disconnected.async_rcv?0 -> 
				break
			:: disconnected.sync?0 -> 
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			do
			:: true;
			:: true -> 
				
				if
				:: sideEffects.async_send!0;
				:: sideEffects.sync!0 -> 
					sideEffects.sending?0
				fi
			:: tryingTimerUp.async_rcv?0 -> 
				break
			:: tryingTimerUp.sync?0 -> 
				break
			:: connected.async_rcv?0 -> 
				break
			:: connected.sync?0 -> 
				break
			:: disconnected.async_rcv?0 -> 
				break
			:: disconnected.sync?0 -> 
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			do
			:: true -> 
				
				if
				:: sideEffects.async_send!0;
				:: sideEffects.sync!0 -> 
					sideEffects.sending?0
				fi;
				
				if
				:: sideEffects.async_send!0;
				:: sideEffects.sync!0 -> 
					sideEffects.sending?0
				fi
			:: true;
			:: tryingTimerUp.async_rcv?0 -> 
				break
			:: tryingTimerUp.sync?0 -> 
				break
			:: connected.async_rcv?0 -> 
				break
			:: connected.sync?0 -> 
				break
			:: disconnected.async_rcv?0 -> 
				break
			:: disconnected.sync?0 -> 
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			do
			:: true;
			:: true;
			:: tryingTimerUp.async_rcv?0 -> 
				break
			:: tryingTimerUp.sync?0 -> 
				break
			:: connected.async_rcv?0 -> 
				break
			:: connected.sync?0 -> 
				break
			:: disconnected.async_rcv?0 -> 
				break
			:: disconnected.sync?0 -> 
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			do
			:: true -> 
				
				if
				:: sideEffects.async_send!0;
				:: sideEffects.sync!0 -> 
					sideEffects.sending?0
				fi
			:: true;
			:: tryingTimerUp.async_rcv?0 -> 
				break
			:: tryingTimerUp.sync?0 -> 
				break
			:: connected.async_rcv?0 -> 
				break
			:: connected.sync?0 -> 
				break
			:: disconnected.async_rcv?0 -> 
				break
			:: disconnected.sync?0 -> 
				break
			:: true -> 
				goto stop_process
			od
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				do
				:: onlineStatusUpdates.async_send!0 -> 
					break
				:: onlineStatusUpdates.sync!0 -> 
					onlineStatusUpdates.sending?0;
					break
				:: true -> 
					goto stop_process
				od
			:: true;
			fi
		:: true;
		fi
	od;
for20_exit:stop_process:
}
proctype Anonymous1(Chandef sideEffects;Chandef onlineStatusUpdates;Chandef tryingTimerUp;Chandef connected;Chandef disconnected) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		do
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: connected.async_send!0;
				:: connected.sync!0 -> 
					connected.sending?0
				fi
			:: true -> 
				
				if
				:: disconnected.async_send!0;
				:: disconnected.sync!0 -> 
					disconnected.sending?0
				fi
			:: true -> 
				
				if
				:: disconnected.async_send!0;
				:: disconnected.sync!0 -> 
					disconnected.sending?0
				fi
			fi
		:: true -> 
			goto stop_process
		od
	od;
for30_exit:stop_process:
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

