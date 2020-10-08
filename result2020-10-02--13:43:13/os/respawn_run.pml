#define lb_for132_0  -1
#define ub_for132_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example334872894/cmd/respawn/respawn.go
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
	Chandef doneChannel;
	int i;
	int lines = 5;
	bool state = false;
	
	if
	:: lines > 0 -> 
		doneChannel.size = lines;
		run emptyChan(doneChannel)
	:: else -> 
		run sync_monitor(doneChannel)
	fi;
		for(i : 1.. lines) {
for10:		run go_respawnexecute(doneChannel)
	};
	
	if
	:: 0 != -1 && lines-1 != -1 -> 
				for(i : 0.. lines-1) {
for20:			
			if
			:: doneChannel.async_rcv?0;
			:: doneChannel.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: doneChannel.async_rcv?0;
			:: doneChannel.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype go_respawnexecute(Chandef doneChannel) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true;
		fi
	od;
for11_exit:	
	if
	:: doneChannel.async_send!0;
	:: doneChannel.sync!0 -> 
		doneChannel.sending?0
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

