
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example075292065/internal/chanworker/chanworker.go
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



init { 
	Chandef w_donec;
	Chandef retc;
	int i;
	Chandef w_workc;
	int nWorkers = 5;
	bool state = false;
	
	if
	:: 16 > 0 -> 
		retc.size = 16;
		run emptyChan(retc)
	:: else -> 
		run sync_monitor(retc)
	fi;
	
	if
	:: true -> 
		run Anonymous0(retc);
		goto stop_process
	:: true;
	fi;
	
	if
	:: 16 > 0 -> 
		w_workc.size = 16;
		run emptyChan(w_workc)
	:: else -> 
		run sync_monitor(w_workc)
	fi;
	run sync_monitor(w_donec);
		for(i : 0.. nWorkers-1) {
for20:
	};
for20_exit:	run Anonymous2(retc);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef retc) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous0(Chandef retc) {
	bool closed; 
	int i;
	bool state;
	Wgdef wg;
	run wgMonitor(wg);
	do
	:: retc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: retc.async_rcv?0;
			:: retc.sync?0;
			fi;
			wg.Add!1;
			run Anonymous0(retc)
		fi
	od;
	wg.Wait?0;
stop_process:
}
proctype Anonymous2(Chandef retc) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && nWorkers-1 != -1 -> 
				for(i : 0.. nWorkers-1) {
for30:
		}
	:: else -> 
		do
		:: true -> 
for30:
		:: true -> 
			break
		od
	fi;
for30_exit:stop_process:
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

