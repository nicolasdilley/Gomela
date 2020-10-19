
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example965297086/lfs/scanner.go
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
	Chandef lockableCh;
	int i;
	chan child_lfsrunCatFileBatch0 = [0] of {int};
	Chandef pointerCh;
	Chandef errCh;
	chan child_lfsNewPointerChannelWrapper1 = [0] of {int};
	bool state = false;
	
	if
	:: 100 > 0 -> 
		pointerCh.size = 100;
		run emptyChan(pointerCh)
	:: else -> 
		run sync_monitor(pointerCh)
	fi;
	
	if
	:: 100 > 0 -> 
		lockableCh.size = 100;
		run emptyChan(lockableCh)
	:: else -> 
		run sync_monitor(lockableCh)
	fi;
	
	if
	:: 5 > 0 -> 
		errCh.size = 5;
		run emptyChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
	run lfsrunCatFileBatch(pointerCh,lockableCh,errCh,child_lfsrunCatFileBatch0);
	child_lfsrunCatFileBatch0?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run lfsNewPointerChannelWrapper(pointerCh,errCh,child_lfsNewPointerChannelWrapper1);
	child_lfsNewPointerChannelWrapper1?0;
	goto stop_process
stop_process:}

proctype lfsrunCatFileBatch(Chandef pointerCh;Chandef lockableCh;Chandef errCh;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous1(pointerCh,lockableCh,errCh);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef pointerCh;Chandef lockableCh;Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: errCh.async_send!0;
			:: errCh.sync!0 -> 
				errCh.sending?0
			fi
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: pointerCh.async_send!0;
				:: pointerCh.sync!0 -> 
					pointerCh.sending?0
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						
						if
						:: lockableCh.async_send!0;
						:: lockableCh.sync!0 -> 
							lockableCh.sending?0
						fi
					:: true;
					fi
				:: true;
				fi
			fi
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: errCh.async_send!0;
			:: errCh.sync!0 -> 
				errCh.sending?0
			fi
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errCh.async_send!0;
		:: errCh.sync!0 -> 
			errCh.sending?0
		fi
	:: true;
	fi;
	pointerCh.closing!true;
	errCh.closing!true;
	lockableCh.closing!true;
stop_process:
}
proctype lfsNewPointerChannelWrapper(Chandef pointerChan;Chandef errorChan;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
	child!0;
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

