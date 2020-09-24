
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example221691967/internal/dir.go
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
	Chandef errListChan;
	Chandef errSlurpChan;
	int i;
	Chandef slurpChan;
	Chandef listChan;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		errSlurpChan.size = 1;
		run emptyChan(errSlurpChan)
	:: else -> 
		run sync_monitor(errSlurpChan)
	fi;
	
	if
	:: 1 > 0 -> 
		slurpChan.size = 1;
		run emptyChan(slurpChan)
	:: else -> 
		run sync_monitor(slurpChan)
	fi;
	
	if
	:: 1 > 0 -> 
		errListChan.size = 1;
		run emptyChan(errListChan)
	:: else -> 
		run sync_monitor(errListChan)
	fi;
	
	if
	:: 1 > 0 -> 
		listChan.size = 1;
		run emptyChan(listChan)
	:: else -> 
		run sync_monitor(listChan)
	fi;
	
	if
	:: true -> 
		run Anonymous0(errSlurpChan,slurpChan,errListChan,listChan)
	:: true -> 
		
		if
		:: errSlurpChan.async_send!0;
		:: errSlurpChan.sync!0 -> 
			errSlurpChan.sending?0
		fi
	:: true -> 
		
		if
		:: errSlurpChan.async_send!0;
		:: errSlurpChan.sync!0 -> 
			errSlurpChan.sending?0
		fi
	fi;
	do
	od;
	do
	od
stop_process:}

proctype Anonymous0(Chandef errSlurpChan;Chandef slurpChan;Chandef errListChan;Chandef listChan) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: errSlurpChan.async_send!0;
		:: errSlurpChan.sync!0 -> 
			errSlurpChan.sending?0
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: slurpChan.async_send!0;
			:: slurpChan.sync!0 -> 
				slurpChan.sending?0
			fi
		:: true -> 
			
			if
			:: errSlurpChan.async_send!0;
			:: errSlurpChan.sync!0 -> 
				errSlurpChan.sending?0
			fi
		:: true -> 
			
			if
			:: errSlurpChan.async_send!0;
			:: errSlurpChan.sync!0 -> 
				errSlurpChan.sending?0
			fi
		fi
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

