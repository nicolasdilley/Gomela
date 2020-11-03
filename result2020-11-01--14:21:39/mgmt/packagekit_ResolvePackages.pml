#define ResolvePackages_signals 1
#define ResolvePackages_packageIDs 3
#define lb_for325_2  -1
#define ub_for325_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example822374033/engine/resources/packagekit/packagekit.go
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
	int signals = ResolvePackages_signals;
	Chandef ch;
	int i;
	chan child_objmatchSignal0 = [0] of {int};
	int packageIDs = ResolvePackages_packageIDs;
	bool state = false;
	
	if
	:: 1000 > 0 -> 
		ch.size = 1000;
		run emptyChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run objmatchSignal(ch,signals,child_objmatchSignal0);
	child_objmatchSignal0?0;
	
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
loop:		do
	:: true -> 
for20:		do
		:: ch.async_rcv?0 -> 
			
			if
			:: true -> 
								for(i : 0.. packageIDs-1) {
for21:
				}
			:: true -> 
				
				if
				:: true -> 
					goto loop
				:: true -> 
					
					if
					:: true -> 
						goto loop
					:: true -> 
						goto stop_process
					:: true -> 
						goto stop_process
					fi
				fi
			fi;
			break
		:: ch.sync?0 -> 
			
			if
			:: true -> 
								for(i : 0.. packageIDs-1) {
for21:
				}
			:: true -> 
				
				if
				:: true -> 
					goto loop
				:: true -> 
					
					if
					:: true -> 
						goto loop
					:: true -> 
						goto stop_process
					:: true -> 
						goto stop_process
					fi
				fi
			fi;
			break
		od
	od;
for20_exit:;
	goto stop_process
stop_process:}

proctype objmatchSignal(Chandef ch;int signals;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
				for(i : 0.. signals-1) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: true -> 
				for(i : 0.. signals-1) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
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


