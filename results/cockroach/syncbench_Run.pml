#define lb_for84_0  -1
#define ub_for84_1  -1
#define workers  5
#define lb_for185_3  -1
#define ub_for185_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example167378074/pkg/cli/syncbench/syncbench.go
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
	int workers = 5;
	Wgdef wg;
	bool state = false;
	Chandef done;
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
		for(i : 1.. workers) {
for10:		wg.Add!1;
		run go_run(wg)
	};
	
	if
	:: 3 > 0 -> 
		done.size = 3;
		run emptyChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	run Anonymous1(done,wg);
	
	if
	:: true -> 
		run Anonymous2(done,wg)
	:: true;
	fi;
	
	if
	:: lb_for185_3 != -1 && ub_for185_4 != -1 -> 
				for(i : lb_for185_3.. ub_for185_4) {
for20:			do
			:: true -> 
				do
				:: true -> 
for21:
				:: true -> 
					break
				od
			:: done.async_rcv?0 -> 
				goto stop_process
			:: done.sync?0 -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: true -> 
				do
				:: true -> 
for21:
				:: true -> 
					break
				od
			:: done.async_rcv?0 -> 
				goto stop_process
			:: done.sync?0 -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for20_exit:
stop_process:}

proctype go_run(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		
		if
		:: true -> 
			
			if
			:: 0 != -1 && 5-1 != -1 -> 
								for(i : 0.. 5-1) {
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
		:: true -> 
			
			if
			:: 0 != -1 && 5-1 != -1 -> 
								for(i : 0.. 5-1) {
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
		fi
	od;
for11_exit:	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	wg.Wait?0;
	
	if
	:: done.async_send!0;
	:: done.sync!0 -> 
		done.sending?0
	fi;
stop_process:
}
proctype Anonymous2(Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: done.async_send!0;
	:: done.sync!0 -> 
		done.sending?0
	fi;
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

