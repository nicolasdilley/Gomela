#define lb_for67_0  -1
#define ub_for67_1  -1
#define lb_for72_2  -1
#define ub_for72_3  -1
#define lb_for83_4  -1
#define ub_for83_5  -1
#define lb_for90_6  -1
#define ub_for90_7  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example152234228/functional/runner/global.go
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
	int i;
	Chandef finished;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!rcs;
	run sync_monitor(finished);
		for(i : 1.. rcs) {
for10:		run Anonymous0(finished,wg)
	};
	
	if
	:: lb_for90_6 != -1 && ub_for90_7 != -1 -> 
				for(i : lb_for90_6.. ub_for90_7) {
for20:			do
			:: finished.async_rcv?0 -> 
				break
			:: finished.sync?0 -> 
				break
			:: true;
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: finished.async_rcv?0 -> 
				break
			:: finished.sync?0 -> 
				break
			:: true;
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	wg.Wait?0;
		for(i : 1.. rcs) {
for30:
	}
stop_process:}

proctype Anonymous0(Chandef finished;Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: lb_for67_0 != -1 && ub_for67_1 != -1 -> 
				for(i : lb_for67_0.. ub_for67_1) {
for11:			
			if
			:: lb_for72_2 != -1 && ub_for72_3 != -1 -> 
								for(i : lb_for72_2.. ub_for72_3) {
for12:
				}
			:: else -> 
				do
				:: true -> 
for12:
				:: true -> 
					break
				od
			fi;
for12_exit:			
			if
			:: finished.async_send!0;
			:: finished.sync!0 -> 
				finished.sending?0
			fi;
			
			if
			:: lb_for83_4 != -1 && ub_for83_5 != -1 -> 
								for(i : lb_for83_4.. ub_for83_5) {
for13:
				}
			:: else -> 
				do
				:: true -> 
for13:
				:: true -> 
					break
				od
			fi;
for13_exit:
		}
	:: else -> 
		do
		:: true -> 
for11:			
			if
			:: lb_for72_2 != -1 && ub_for72_3 != -1 -> 
								for(i : lb_for72_2.. ub_for72_3) {
for12:
				}
			:: else -> 
				do
				:: true -> 
for12:
				:: true -> 
					break
				od
			fi;
for12_exit:			
			if
			:: finished.async_send!0;
			:: finished.sync!0 -> 
				finished.sending?0
			fi;
			
			if
			:: lb_for83_4 != -1 && ub_for83_5 != -1 -> 
								for(i : lb_for83_4.. ub_for83_5) {
for13:
				}
			:: else -> 
				do
				:: true -> 
for13:
				:: true -> 
					break
				od
			fi;
for13_exit:
		:: true -> 
			break
		od
	fi;
for11_exit:	wg.Add!-1;
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

