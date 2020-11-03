#define lb_for270_0  -1
#define ub_for270_1  -1
#define lb_for401_2  -1
#define ub_for401_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example431453111/service/service.go
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
	Chandef s_doneChan;
	Wgdef bindWait;
	int i;
	Chandef c;
	Wgdef s_doneGroup;
	bool state = false;
	run wgMonitor(bindWait);
	bindWait.Add!1;
	run go_slisten(bindWait);
	
	if
	:: 1 > 0 -> 
		c.size = 1;
		run emptyChan(c)
	:: else -> 
		run sync_monitor(c)
	fi;
	run go_servicewatchSignals(c);
	
	if
	:: 1 > 0 -> 
		s_doneChan.size = 1;
		run emptyChan(s_doneChan)
	:: else -> 
		run sync_monitor(s_doneChan)
	fi;
	bindWait.Wait?0;
	run wgMonitor(s_doneGroup);
	run Anonymous2(c,s_doneChan);
	goto stop_process
stop_process:}

proctype go_slisten(Wgdef bindWait) {
	bool closed; 
	int i;
	bool state;
	bindWait.Add!-1;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for10_exit:stop_process:
}
proctype go_servicewatchSignals(Chandef c) {
	bool closed; 
	int i;
	bool state;
	do
	:: c!0 -> 
		break
	:: true -> 
		break
	od;
	do
	:: true -> 
for20:		do
		:: c.async_rcv?0 -> 
			

			if
			:: true -> 
				goto stop_process
			fi;
			break
		:: c.sync?0 -> 
			

			if
			:: true -> 
				goto stop_process
			fi;
			break
		od
	od;
for20_exit:stop_process:
}
proctype Anonymous2(Chandef c;Chandef s_doneChan) {
	bool closed; 
	int i;
	bool state;
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
	od
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

