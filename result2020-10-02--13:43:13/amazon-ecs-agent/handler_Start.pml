#define lb_for191_0  -1
#define ub_for191_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example646408234/agent/acs/handler/acs_handler.go
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
	int i;
	Chandef connectToACS;
	bool state = false;
	run sync_monitor(connectToACS);
	run Anonymous0(connectToACS);
		for(i : lb_for191_0.. ub_for191_1) {
for10:		do
		:: connectToACS.async_rcv?0 -> 
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				chan child_handlersendEmptyMessageOnChannel0 = [0] of {int};
				run handlersendEmptyMessageOnChannel(connectToACS,child_handlersendEmptyMessageOnChannel0);
				child_handlersendEmptyMessageOnChannel0?0
			:: true -> 
				
				if
				:: true -> 
					chan child_handlersendEmptyMessageOnChannel1 = [0] of {int};
					run handlersendEmptyMessageOnChannel(connectToACS,child_handlersendEmptyMessageOnChannel1);
					child_handlersendEmptyMessageOnChannel1?0
				fi
			:: true -> 
				
				if
				:: true -> 
					chan child_handlersendEmptyMessageOnChannel1 = [0] of {int};
					run handlersendEmptyMessageOnChannel(connectToACS,child_handlersendEmptyMessageOnChannel1);
					child_handlersendEmptyMessageOnChannel1?0
				fi
			fi;
			break
		:: connectToACS.sync?0 -> 
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				chan child_handlersendEmptyMessageOnChannel0 = [0] of {int};
				run handlersendEmptyMessageOnChannel(connectToACS,child_handlersendEmptyMessageOnChannel0);
				child_handlersendEmptyMessageOnChannel0?0
			:: true -> 
				
				if
				:: true -> 
					chan child_handlersendEmptyMessageOnChannel1 = [0] of {int};
					run handlersendEmptyMessageOnChannel(connectToACS,child_handlersendEmptyMessageOnChannel1);
					child_handlersendEmptyMessageOnChannel1?0
				fi
			:: true -> 
				
				if
				:: true -> 
					chan child_handlersendEmptyMessageOnChannel1 = [0] of {int};
					run handlersendEmptyMessageOnChannel(connectToACS,child_handlersendEmptyMessageOnChannel1);
					child_handlersendEmptyMessageOnChannel1?0
				fi
			fi;
			break
		:: true -> 
			goto stop_process
		od
	};
for10_exit:
stop_process:}

proctype Anonymous0(Chandef connectToACS) {
	bool closed; 
	int i;
	
	if
	:: connectToACS.async_send!0;
	:: connectToACS.sync!0 -> 
		connectToACS.sending?0
	fi;
stop_process:
}
proctype handlersendEmptyMessageOnChannel(Chandef channel;chan child) {
	bool closed; 
	int i;
	run Anonymous2(channel);
	child!0;
stop_process:
}
proctype Anonymous2(Chandef channel) {
	bool closed; 
	int i;
	
	if
	:: channel.async_send!0;
	:: channel.sync!0 -> 
		channel.sending?0
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

