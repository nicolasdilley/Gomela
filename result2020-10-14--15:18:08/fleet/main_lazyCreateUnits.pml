#define lazyCreateUnits_args  60
#define lazyCreateUnits_blockAttempts  60
#define lb_for1012_2  -1
#define ub_for1012_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example720151836/fleetctl/fleetctl.go
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
	int args = lazyCreateUnits_args;
	Chandef errchan;
	int i;
	Wgdef wg;
	int blockAttempts = lazyCreateUnits_blockAttempts;
	bool state = false;
	run sync_monitor(errchan);
	run wgMonitor(wg);
		for(i : 1.. args) {
for10:		
		if
		:: true -> 
			goto stop_process
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
		wg.Add!1;
		run go_maincheckUnitState(wg,errchan,blockAttempts)
	};
	run Anonymous1(errchan,wg);
	do
	:: errchan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: errchan.async_rcv?0;
			:: errchan.sync?0;
			fi
		fi
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype go_maincheckUnitState(Wgdef wg;Chandef errchan;int maxAttempts) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		do
		:: true -> 
for11:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		od;
for11_exit:
	:: true -> 
		
		if
		:: 0 != -1 && maxAttempts-1 != -1 -> 
						for(i : 0.. maxAttempts-1) {
for12:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for12:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for12_exit:		
		if
		:: errchan.async_send!0;
		:: errchan.sync!0 -> 
			errchan.sending?0
		fi
	:: true -> 
		
		if
		:: 0 != -1 && maxAttempts-1 != -1 -> 
						for(i : 0.. maxAttempts-1) {
for12:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for12:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for12_exit:		
		if
		:: errchan.async_send!0;
		:: errchan.sync!0 -> 
			errchan.sending?0
		fi
	fi;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Chandef errchan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Wait?0;
	errchan.closing!true;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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

