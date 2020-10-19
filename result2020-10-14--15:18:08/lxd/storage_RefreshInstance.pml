#define RefreshInstance_srcSnapshots  60
#define RefreshInstance_srcSnapVols  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example232910342/lxd/storage/backend_lxd.go
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
	int srcSnapVols = RefreshInstance_srcSnapVols;
	int srcSnapshots = RefreshInstance_srcSnapshots;
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. srcSnapshots) {
for10:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
				for(i : 1.. srcSnapVols) {
for20:
		};
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		Chandef aEndErrCh;
		
		if
		:: 1 > 0 -> 
			aEndErrCh.size = 1;
			run emptyChan(aEndErrCh)
		:: else -> 
			run sync_monitor(aEndErrCh)
		fi;
		Chandef bEndErrCh;
		
		if
		:: 1 > 0 -> 
			bEndErrCh.size = 1;
			run emptyChan(bEndErrCh)
		:: else -> 
			run sync_monitor(bEndErrCh)
		fi;
		run Anonymous0(aEndErrCh,bEndErrCh);
		run Anonymous1(aEndErrCh,bEndErrCh);
		
		if
		:: aEndErrCh.async_rcv?0;
		:: aEndErrCh.sync?0;
		fi;
		
		if
		:: bEndErrCh.async_rcv?0;
		:: bEndErrCh.sync?0;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
				for(i : 1.. srcSnapVols) {
for20:
		};
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		Chandef aEndErrCh;
		
		if
		:: 1 > 0 -> 
			aEndErrCh.size = 1;
			run emptyChan(aEndErrCh)
		:: else -> 
			run sync_monitor(aEndErrCh)
		fi;
		Chandef bEndErrCh;
		
		if
		:: 1 > 0 -> 
			bEndErrCh.size = 1;
			run emptyChan(bEndErrCh)
		:: else -> 
			run sync_monitor(bEndErrCh)
		fi;
		run Anonymous0(aEndErrCh,bEndErrCh);
		run Anonymous1(aEndErrCh,bEndErrCh);
		
		if
		:: aEndErrCh.async_rcv?0;
		:: aEndErrCh.sync?0;
		fi;
		
		if
		:: bEndErrCh.async_rcv?0;
		:: bEndErrCh.sync?0;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	
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
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef aEndErrCh;Chandef bEndErrCh) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: aEndErrCh.async_send!0;
	:: aEndErrCh.sync!0 -> 
		aEndErrCh.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef aEndErrCh;Chandef bEndErrCh) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: bEndErrCh.async_send!0;
	:: bEndErrCh.sync!0 -> 
		bEndErrCh.sending?0
	fi;
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

