#define lb_for76_0  -1
#define ub_for76_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example950870649/scan/broad.go
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
	Chandef addrs;
	bool state = false;
	int numWorkers = 5;
	Wgdef wg;
	Chandef chains;
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
	run wgMonitor(wg);
	wg.Add!numWorkers;
	run sync_monitor(addrs);
	
	if
	:: numWorkers > 0 -> 
		chains.size = numWorkers;
		run emptyChan(chains)
	:: else -> 
		run sync_monitor(chains)
	fi;
	run Anonymous0(addrs,chains,wg);
		for(i : 0.. numWorkers-1) {
for20:		run Anonymous1(addrs,chains,wg)
	};
for20_exit:	
	if
	:: lb_for76_0 != -1 && ub_for76_1 != -1 -> 
				for(i : lb_for76_0.. ub_for76_1) {
for30:			
			if
			:: addrs.async_send!0;
			:: addrs.sync!0 -> 
				addrs.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: addrs.async_send!0;
			:: addrs.sync!0 -> 
				addrs.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	addrs.closing!true;
	wg.Wait?0;
	chains.closing!true;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef addrs;Chandef chains;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: chains.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: chains.async_rcv?0;
			:: chains.sync?0;
			fi
		fi
	od;
stop_process:
}
proctype Anonymous1(Chandef addrs;Chandef chains;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: addrs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: addrs.async_rcv?0;
			:: addrs.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: chains.async_send!0;
				:: chains.sync!0 -> 
					chains.sending?0
				fi
			:: true;
			fi
		fi
	od;
	wg.Add!-1;
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

