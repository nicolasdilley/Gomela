#define lb_for563_0  -1
#define ub_for563_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example148026338/pkg/receive/handler.go
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
	Chandef ec;
	int i;
	Wgdef wg;
	bool state = false;
	run sync_monitor(ec);
	run wgMonitor(wg);
		for(i : 1.. wreqs) {
for10:		wg.Add!1;
		
		if
		:: true -> 
			run Anonymous0(ec,wg)
		:: true;
		fi;
		
		if
		:: true -> 
			run Anonymous1(ec,wg)
		:: true;
		fi;
		run Anonymous2(ec,wg)
	};
	run Anonymous3(ec,wg);
	do
	:: true -> 
for30:		do
		:: true -> 
			goto stop_process
		od
	od;
for30_exit:	run Anonymous4(ec,wg)
stop_process:}

proctype Anonymous0(Chandef ec;Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: ec.async_send!0;
		:: ec.sync!0 -> 
			ec.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: ec.async_send!0;
	:: ec.sync!0 -> 
		ec.sending?0
	fi;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Chandef ec;Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: ec.async_send!0;
		:: ec.sync!0 -> 
			ec.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: ec.async_send!0;
	:: ec.sync!0 -> 
		ec.sending?0
	fi;
	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Chandef ec;Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: ec.async_send!0;
		:: ec.sync!0 -> 
			ec.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: ec.async_send!0;
			:: ec.sync!0 -> 
				ec.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: ec.async_send!0;
		:: ec.sync!0 -> 
			ec.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: ec.async_send!0;
	:: ec.sync!0 -> 
		ec.sending?0
	fi;
	wg.Add!-1;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:
}
proctype Anonymous3(Chandef ec;Wgdef wg) {
	bool closed; 
	int i;
	wg.Wait?0;
	ec.closing!true;
stop_process:
}
proctype Anonymous4(Chandef ec;Wgdef wg) {
	bool closed; 
	int i;
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
	od;
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

