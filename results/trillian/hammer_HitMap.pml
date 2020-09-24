#define cfg_NumCheckers + 1  5
#define lb_for376_1  -1
#define ub_for376_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example533359523/testonly/internal/hammer/hammer.go
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
	bool state = false;
	int c = 5;
	Chandef errs;
	int errs = 5;
	Wgdef wg;
	Chandef done;
	int cfg_NumCheckers = 5;
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0(ticker_C,errs,done,wg);
	run wgMonitor(wg);
	
	if
	:: cfg_NumCheckers + 1 > 0 -> 
		errs.size = cfg_NumCheckers + 1;
		run emptyChan(errs)
	:: else -> 
		run sync_monitor(errs)
	fi;
	run sync_monitor(done);
		for(i : 0.. cfg_NumCheckers-1) {
for20:		wg.Add!1;
		run Anonymous1(errs,done,wg)
	};
for20_exit:	wg.Add!1;
	run Anonymous3(errs,done,wg);
	do
	:: true;
	od;
	done.closing!true;
	wg.Wait?0;
	errs.closing!true;
	do
	:: errs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			errs.in?0
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef c;Chandef errs;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: c.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			c.in?0
		fi
	od;
stop_process:
}
proctype wrun(Chandef done;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for21:		do
		:: done.async_rcv?0 -> 
			goto stop_process
		:: done.sync?0 -> 
			goto stop_process
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for21_exit:	child!0;
stop_process:
}
proctype Anonymous1(Chandef errs;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	chan child_wrun0 = [0] of {int};
	run wrun(done,child_wrun0);
	child_wrun0?0;
	
	if
	:: true -> 
		
		if
		:: errs.async_send!0;
		:: errs.sync!0 -> 
			errs.sending?0
		fi
	:: true;
	fi;
	wg.Add!-1;
stop_process:
}
proctype Anonymous3(Chandef errs;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	chan child_wrun1 = [0] of {int};
	run wrun(done,child_wrun1);
	child_wrun1?0;
	
	if
	:: errs.async_send!0;
	:: errs.sync!0 -> 
		errs.sending?0
	fi;
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

