#define inputs  5
#define inputs  5
#define inputs  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example671499408/breacharbiter.go
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
	Chandef anySpend;
	int inputs = 5;
	Chandef exit;
	int i;
	Chandef allSpends;
	Wgdef wg;
	int allSpends = 5;
	bool state = false;
	
	if
	:: inputs > 0 -> 
		anySpend.size = inputs;
		run emptyChan(anySpend)
	:: else -> 
		run sync_monitor(anySpend)
	fi;
	
	if
	:: inputs > 0 -> 
		allSpends.size = inputs;
		run emptyChan(allSpends)
	:: else -> 
		run sync_monitor(allSpends)
	fi;
	run sync_monitor(exit);
	run wgMonitor(wg);
		for(i : 1.. inputs) {
for10:		
		if
		:: true -> 
			
			if
			:: true -> 
				do
				:: true -> 
					goto stop_process
				:: true -> 
					break
				od
			:: true;
			fi
		:: true;
		fi;
		wg.Add!1;
		run Anonymous0(anySpend,allSpends,exit,wg)
	};
	do
	:: anySpend.async_rcv?0 -> 
		exit.closing!true;
		wg.Wait?0;
		allSpends.closing!true;
		do
		:: allSpends.is_closed?state -> 
			if
			:: state -> 
				break
			:: else -> 
				allSpends.in?0;
				

				if
				:: true;
				:: true;
				fi
			fi
		od;
		do
		:: true -> 
for30:
		:: true -> 
			break
		od;
		break
	:: anySpend.sync?0 -> 
		exit.closing!true;
		wg.Wait?0;
		allSpends.closing!true;
		do
		:: allSpends.is_closed?state -> 
			if
			:: state -> 
				break
			:: else -> 
				allSpends.in?0;
				

				if
				:: true;
				:: true;
				fi
			fi
		od;
		do
		:: true -> 
for30:
		:: true -> 
			break
		od;
		break
	:: true -> 
		goto stop_process
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef anySpend;Chandef allSpends;Chandef exit;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: exit.async_rcv?0 -> 
		goto stop_process
	:: exit.sync?0 -> 
		goto stop_process
	:: true -> 
		goto stop_process
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

