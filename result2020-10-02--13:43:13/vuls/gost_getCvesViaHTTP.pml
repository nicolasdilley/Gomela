
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example546695471/gost/util.go
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
	Chandef errChan;
	Chandef reqChan;
	int i;
	Chandef resChan;
	int nReq = 5;
	bool state = false;
	
	if
	:: nReq > 0 -> 
		reqChan.size = nReq;
		run emptyChan(reqChan)
	:: else -> 
		run sync_monitor(reqChan)
	fi;
	
	if
	:: nReq > 0 -> 
		resChan.size = nReq;
		run emptyChan(resChan)
	:: else -> 
		run sync_monitor(resChan)
	fi;
	
	if
	:: nReq > 0 -> 
		errChan.size = nReq;
		run emptyChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	run Anonymous0(reqChan,resChan,errChan);
	
	if
	:: 0 != -1 && nReq-1 != -1 -> 
				for(i : 0.. nReq-1) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: 0 != -1 && nReq-1 != -1 -> 
				for(i : 0.. nReq-1) {
for30:			do
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for30:			do
			:: true -> 
				goto stop_process
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
	goto stop_process;
	reqChan.closing!true;
	resChan.closing!true;
	errChan.closing!true
stop_process:}

proctype Anonymous0(Chandef reqChan;Chandef resChan;Chandef errChan) {
	bool closed; 
	int i;
		for(i : 1.. cveIDs) {
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

