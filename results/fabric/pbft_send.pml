#define destCount  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example376173692/consensus/pbft/broadcast.go
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
	Chandef wait;
	int i = 5;
	int destCount = 5;
	bool state = false;
	int b_msgChans = 5;
	int required = 5;
	int i;
	do
	:: true -> 
		goto stop_process
	:: true -> 
		break
	od;
	
	if
	:: destCount > 0 -> 
		wait.size = destCount;
		run emptyChan(wait)
	:: else -> 
		run sync_monitor(wait)
	fi;
	
	if
	:: true -> 
		chan child_bunicastOne0 = [0] of {int};
		run bunicastOne(wait,child_bunicastOne0);
		child_bunicastOne0?0
	:: true -> 
		do
		:: true -> 
for10:			chan child_bunicastOne1 = [0] of {int};
			run bunicastOne(wait,child_bunicastOne1);
			child_bunicastOne1?0
		:: true -> 
			break
		od
	:: true -> 
		do
		:: true -> 
for10:			chan child_bunicastOne1 = [0] of {int};
			run bunicastOne(wait,child_bunicastOne1);
			child_bunicastOne1?0
		:: true -> 
			break
		od
	fi;
outer:		
	if
	:: 0 != -1 && destCount-1 != -1 -> 
				for(i : 0.. destCount-1) {
for20:			do
			:: true -> 
				
				if
				:: i != -1 && required-1 != -1 -> 
										for(i : i.. required-1) {
for21:						
						if
						:: wait.async_rcv?0;
						:: wait.sync?0;
						fi
					}
				:: else -> 
					do
					:: true -> 
for21:						
						if
						:: wait.async_rcv?0;
						:: wait.sync?0;
						fi
					:: true -> 
						break
					od
				fi;
for21_exit:				goto outer
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: true -> 
				
				if
				:: i != -1 && required-1 != -1 -> 
										for(i : i.. required-1) {
for21:						
						if
						:: wait.async_rcv?0;
						:: wait.sync?0;
						fi
					}
				:: else -> 
					do
					:: true -> 
for21:						
						if
						:: wait.async_rcv?0;
						:: wait.sync?0;
						fi
					:: true -> 
						break
					od
				fi;
for21_exit:				goto outer
			od
		:: true -> 
			break
		od
	fi;
for20_exit:;
	goto stop_process
stop_process:}

proctype bunicastOne(Chandef wait;chan child) {
	bool closed; 
	int i;
	do
	:: true;
	:: true -> 
		
		if
		:: wait.async_send!0;
		:: wait.sync!0 -> 
			wait.sending?0
		fi;
		break
	od;
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

