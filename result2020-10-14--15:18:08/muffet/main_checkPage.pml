#define checkPage_us  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example350105522/page_checker.go
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
	Wgdef w;
	Chandef sc;
	int i;
	Chandef ec;
	int us = checkPage_us;
	bool state = false;
	
	if
	:: us > 0 -> 
		sc.size = us;
		run emptyChan(sc)
	:: else -> 
		run sync_monitor(sc)
	fi;
	
	if
	:: us > 0 -> 
		ec.size = us;
		run emptyChan(ec)
	:: else -> 
		run sync_monitor(ec)
	fi;
	run wgMonitor(w);
		for(i : 1.. us) {
for10:		
		if
		:: true -> 
			
			if
			:: ec.async_send!0;
			:: ec.sync!0 -> 
				ec.sending?0
			fi
		:: true;
		fi;
		w.Add!1;
		run Anonymous0(sc,ec)
	};
	w.Wait?0;
	sc.closing!true;
	ec.closing!true;
	do
	:: sc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: sc.async_rcv?0;
			:: sc.sync?0;
			fi
		fi
	od;
	do
	:: ec.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: ec.async_rcv?0;
			:: ec.sync?0;
			fi
		fi
	od
stop_process:}

proctype Anonymous0(Chandef sc;Chandef ec) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: sc.async_send!0;
		:: sc.sync!0 -> 
			sc.sending?0
		fi
	:: true -> 
		
		if
		:: ec.async_send!0;
		:: ec.sync!0 -> 
			ec.sending?0
		fi
	:: true -> 
		
		if
		:: ec.async_send!0;
		:: ec.sync!0 -> 
			ec.sending?0
		fi
	fi;
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

