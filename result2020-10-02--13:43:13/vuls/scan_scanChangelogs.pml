
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example546695471/scan/debian.go
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
	Chandef resChan;
	int cvePackages = 5;
	Chandef reqChan;
	int i;
	Chandef errChan;
	int cves = 5;
	int names = 5;
	bool state = false;
	
	if
	:: updatablePacks > 0 -> 
		resChan.size = updatablePacks;
		run emptyChan(resChan)
	:: else -> 
		run sync_monitor(resChan)
	fi;
	
	if
	:: updatablePacks > 0 -> 
		errChan.size = updatablePacks;
		run emptyChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	
	if
	:: updatablePacks > 0 -> 
		reqChan.size = updatablePacks;
		run emptyChan(reqChan)
	:: else -> 
		run sync_monitor(reqChan)
	fi;
	run Anonymous0(resChan,errChan,reqChan);
		for(i : 1.. updatablePacks) {
for20:
	};
	
	if
	:: 0 != -1 && updatablePacks-1 != -1 -> 
				for(i : 0.. updatablePacks-1) {
for30:			do
			:: true;
			od
		}
	:: else -> 
		do
		:: true -> 
for30:			do
			:: true;
			od
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. cvePackages) {
for40:
	};
		for(i : 1.. cvePackages) {
for50:				for(i : 1.. names) {
for51:
		}
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	resChan.closing!true;
	errChan.closing!true;
	reqChan.closing!true
stop_process:}

proctype Anonymous0(Chandef resChan;Chandef errChan;Chandef reqChan) {
	bool closed; 
	int i;
		for(i : 1.. updatablePacks) {
for10:		
		if
		:: reqChan.async_send!0;
		:: reqChan.sync!0 -> 
			reqChan.sending?0
		fi
	};
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

