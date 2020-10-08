
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example076238862/dgraph/cmd/conv/conv.go
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
	Chandef chb;
	bool state = false;
	int f_Properties = 5;
	Chandef che;
	int fc_Features = 5;
	int i;
	
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
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		che.size = 1;
		run emptyChan(che)
	:: else -> 
		run sync_monitor(che)
	fi;
	
	if
	:: 1000 > 0 -> 
		chb.size = 1000;
		run emptyChan(chb)
	:: else -> 
		run sync_monitor(chb)
	fi;
	run Anonymous0(che,chb);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. fc_Features) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: chb.async_send!0;
		:: chb.sync!0 -> 
			chb.sending?0
		fi;
				for(i : 1.. f_Properties) {
for21:			
			if
			:: true -> 
				
				if
				:: chb.async_send!0;
				:: chb.sync!0 -> 
					chb.sending?0
				fi
			:: true;
			fi
		}
	};
	chb.closing!true;
	
	if
	:: che.async_rcv?0;
	:: che.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype convwriteToFile(Chandef ch;chan child) {
	bool closed; 
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
	do
	:: ch.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: ch.async_rcv?0;
			:: ch.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
	
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
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef che;Chandef chb) {
	bool closed; 
	int i;
	chan child_convwriteToFile0 = [0] of {int};
	run convwriteToFile(chb,child_convwriteToFile0);
	child_convwriteToFile0?0;
	
	if
	:: che.async_send!0;
	:: che.sync!0 -> 
		che.sending?0
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

