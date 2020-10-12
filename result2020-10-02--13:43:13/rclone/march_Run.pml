#define lb_for149_0  -1
#define ub_for149_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example822197482/fs/march/march.go
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
	Wgdef traversing;
	int i;
	int fs_Config_Checkers = 5;
	Wgdef wg;
	Chandef in;
	int jobs = 5;
	bool state = false;
	run wgMonitor(wg);
	run wgMonitor(traversing);
	
	if
	:: fs_Config_Checkers > 0 -> 
		in.size = fs_Config_Checkers;
		run emptyChan(in)
	:: else -> 
		run sync_monitor(in)
	fi;
		for(i : 0.. fs_Config_Checkers-1) {
for10:		wg.Add!1;
		run Anonymous0(in,wg,traversing)
	};
for10_exit:	traversing.Add!1;
	
	if
	:: in.async_send!0;
	:: in.sync!0 -> 
		in.sending?0
	fi;
	run Anonymous2(in,wg,traversing);
	traversing.Wait?0;
	in.closing!true;
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef in;Wgdef wg;Wgdef traversing) {
	bool closed; 
	int i;
		for(i : 1.. jobs) {
for12:		do
		:: true -> 
			traversing.Add!-1
		:: in.async_send!0 -> 
			break
		:: in.sync!0 -> 
			in.sending?0;
			break
		od
	};
stop_process:
}
proctype Anonymous0(Chandef in;Wgdef wg;Wgdef traversing) {
	bool closed; 
	int i;
		for(i : lb_for149_0.. ub_for149_1) {
for11:		do
		:: true -> 
			goto stop_process
		od
	};
for11_exit:	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Chandef in;Wgdef wg;Wgdef traversing) {
	bool closed; 
	int i;
	do
	:: in.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: in.async_rcv?0;
			:: in.sync?0;
			fi;
			traversing.Add!-1
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
