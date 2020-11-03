#define loadNames_loadSpec_hits 1
#define loadNames_loadSpec_stales 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example441703692/go/avatars/fullcaching.go
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
	bool state = false;
	int loadSpec_stales = loadNames_loadSpec_stales;
	int loadSpec_hits = loadNames_loadSpec_hits;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. loadSpec_hits-1) {
for10:
	};
		for(i : 0.. loadSpec_stales-1) {
for20:
	};
	
	if
	:: true -> 
		Chandef cb;
		
		if
		:: 1 > 0 -> 
			cb.size = 1;
			run emptyChan(cb)
		:: else -> 
			run sync_monitor(cb)
		fi;
		Chandef errCb;
		
		if
		:: 1 > 0 -> 
			errCb.size = 1;
			run emptyChan(errCb)
		:: else -> 
			run sync_monitor(errCb)
		fi;
		do
		:: cb.async_rcv?0 -> 
			break
		:: cb.sync?0 -> 
			break
		:: errCb.async_rcv?0 -> 
			break
		:: errCb.sync?0 -> 
			break
		od
	:: true;
	fi;
	
	if
	:: true -> 
		run Anonymous0(cb,errCb)
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef cb;Chandef errCb) {
	bool closed; 
	int i;
	bool state;
	Chandef cb;
	Chandef errCb;
	
	if
	:: 1 > 0 -> 
		cb.size = 1;
		run emptyChan(cb)
	:: else -> 
		run sync_monitor(cb)
	fi;
	
	if
	:: 1 > 0 -> 
		errCb.size = 1;
		run emptyChan(errCb)
	:: else -> 
		run sync_monitor(errCb)
	fi;
	do
	:: cb.async_rcv?0 -> 
		break
	:: cb.sync?0 -> 
		break
	:: errCb.async_rcv?0 -> 
		break
	:: errCb.sync?0 -> 
		break
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


