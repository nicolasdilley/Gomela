
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example500215275/credentials/fetcher_default.go
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
	Chandef errs;
	int i;
	Chandef done;
	bool state = false;
	run sync_monitor(errs);
	run sync_monitor(done);
	run Anonymous0(errs,done);
	run go_sresolveAll(done,errs,locations);
	do
	:: true;
	:: done.async_rcv?0 -> 
		break
	:: done.sync?0 -> 
		break
	od
stop_process:}

proctype Anonymous0(Chandef errs;Chandef done) {
	bool closed; 
	int i;
	do
	:: errs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: errs.async_rcv?0;
			:: errs.sync?0;
			fi
		fi
	od;
stop_process:
}
proctype go_sresolveAll(Chandef done;Chandef errs;int locations) {
	bool closed; 
	int i;
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 1.. locations) {
for20:		wg.Add!1;
		run go_sresolve(wg,errs)
	};
	wg.Wait?0;
	done.closing!true;
	errs.closing!true;
stop_process:
}
proctype go_sresolve(Wgdef wg;Chandef errs) {
	bool closed; 
	int i;
	

	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: errs.async_send!0;
			:: errs.sync!0 -> 
				errs.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	:: true;
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: errs.async_send!0;
			:: errs.sync!0 -> 
				errs.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: errs.async_send!0;
			:: errs.sync!0 -> 
				errs.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: errs.async_send!0;
		:: errs.sync!0 -> 
			errs.sending?0
		fi;
		goto stop_process
	fi;
	
	if
	:: true -> 
		
		if
		:: errs.async_send!0;
		:: errs.sync!0 -> 
			errs.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	wg.Add!-1;
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
