
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example640268563/stream.go
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
	Chandef st_rangeCh;
	Chandef kvErr;
	Chandef errCh;
	int i;
	Chandef st_kvChan;
	Wgdef wg;
	int st_NumGo = 5;
	bool state = false;
	
	if
	:: 3 > 0 -> 
		st_rangeCh.size = 3;
		run emptyChan(st_rangeCh)
	:: else -> 
		run sync_monitor(st_rangeCh)
	fi;
	
	if
	:: 32 > 0 -> 
		st_kvChan.size = 32;
		run emptyChan(st_kvChan)
	:: else -> 
		run sync_monitor(st_kvChan)
	fi;
	
	if
	:: 1 > 0 -> 
		errCh.size = 1;
		run emptyChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
	run wgMonitor(wg);
		for(i : 0.. st_NumGo-1) {
for10:		wg.Add!1;
		run Anonymous0(st_rangeCh,st_kvChan,errCh,kvErr,wg)
	};
for10_exit:	
	if
	:: 1 > 0 -> 
		kvErr.size = 1;
		run emptyChan(kvErr)
	:: else -> 
		run sync_monitor(kvErr)
	fi;
	run Anonymous1(st_rangeCh,st_kvChan,errCh,kvErr,wg);
	wg.Wait?0;
	st_kvChan.closing!true;
	do
	:: true -> 
		break
	od;
	
	if
	:: kvErr.async_rcv?0;
	:: kvErr.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef st_rangeCh;Chandef st_kvChan;Chandef errCh;Chandef kvErr;Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		do
		:: errCh.async_send!0 -> 
			break
		:: errCh.sync!0 -> 
			errCh.sending?0;
			break
		:: true -> 
			break
		od
	:: true;
	fi;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Chandef st_rangeCh;Chandef st_kvChan;Chandef errCh;Chandef kvErr;Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: kvErr.async_send!0;
	:: kvErr.sync!0 -> 
		kvErr.sending?0
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

