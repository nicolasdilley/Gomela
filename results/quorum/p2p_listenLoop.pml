#define tokens  5
#define lb_for883_1  -1
#define ub_for883_2  -1
#define lb_for891_3  -1
#define ub_for891_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example244624373/p2p/server.go
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
	Chandef slots;
	int i;
	int tokens = 5;
	bool state = false;
	
	if
	:: tokens > 0 -> 
		slots.size = tokens;
		run emptyChan(slots)
	:: else -> 
		run sync_monitor(slots)
	fi;
	
	if
	:: 0 != -1 && tokens-1 != -1 -> 
				for(i : 0.. tokens-1) {
for10:			
			if
			:: slots.async_send!0;
			:: slots.sync!0 -> 
				slots.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: slots.async_send!0;
			:: slots.sync!0 -> 
				slots.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:		for(i : lb_for883_1.. ub_for883_2) {
for20:		
		if
		:: slots.async_rcv?0;
		:: slots.sync?0;
		fi;
		do
		:: true -> 
for21:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi;
			break
		od;
for21_exit:		
		if
		:: true -> 
			
			if
			:: slots.async_send!0;
			:: slots.sync!0 -> 
				slots.sending?0
			fi
		:: true;
		fi;
		run Anonymous0(slots)
	};
for20_exit:
stop_process:}

proctype Anonymous0(Chandef slots) {
	bool closed; 
	int i;
	
	if
	:: slots.async_send!0;
	:: slots.sync!0 -> 
		slots.sending?0
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

