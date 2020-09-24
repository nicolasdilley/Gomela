#define lb_for177_0  -1
#define ub_for177_1  -1
#define lb_for183_2  -1
#define ub_for183_3  -1
#define lb_for231_4  -1
#define ub_for231_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example853255129/devices/lepton/lepton.go
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
	Chandef done;
	int i;
	Chandef c;
	int w = 5;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		done.size = 1;
		run emptyChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	
	if
	:: 1024 > 0 -> 
		c.size = 1024;
		run emptyChan(c)
	:: else -> 
		run sync_monitor(c)
	fi;
	run wgMonitor(wg);
	wg.Add!1;
	run Anonymous0(done,c,wg);
	do
	:: true -> 
for20:		do
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:	
	if
	:: done.async_send!0;
	:: done.sync!0 -> 
		done.sending?0
	fi
stop_process:}

proctype dstream(Chandef done;Chandef c;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: lb_for183_2 != -1 && ub_for183_3 != -1 -> 
						for(i : lb_for183_2.. ub_for183_3) {
for11:				do
				:: done.async_rcv?0 -> 
					goto stop_process
				:: done.sync?0 -> 
					goto stop_process
				:: c.async_send!0 -> 
					break
				:: c.sync!0 -> 
					c.sending?0;
					break
				od
			}
		:: else -> 
			do
			:: true -> 
for11:				do
				:: done.async_rcv?0 -> 
					goto stop_process
				:: done.sync?0 -> 
					goto stop_process
				:: c.async_send!0 -> 
					break
				:: c.sync!0 -> 
					c.sending?0;
					break
				od
			:: true -> 
				break
			od
		fi;
for11_exit:
	od;
for10_exit:	child!0;
stop_process:
}
proctype Anonymous0(Chandef done;Chandef c;Wgdef wg) {
	bool closed; 
	int i;
	chan child_dstream0 = [0] of {int};
	run dstream(done,c,child_dstream0);
	child_dstream0?0;
	wg.Add!-1;
	c.closing!true;
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

