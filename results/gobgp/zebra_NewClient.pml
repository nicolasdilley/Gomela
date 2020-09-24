#define lb_for1239_0  -1
#define ub_for1239_1  -1
#define lb_for1342_2  -1
#define ub_for1342_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example117802945/internal/pkg/zebra/zapi.go
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
	Chandef incoming;
	Chandef outgoing;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(outgoing);
	
	if
	:: 64 > 0 -> 
		incoming.size = 64;
		run emptyChan(incoming)
	:: else -> 
		run sync_monitor(incoming)
	fi;
	run Anonymous0(outgoing,incoming);
	
	if
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: incoming.async_send!0;
			:: incoming.sync!0 -> 
				incoming.sending?0
			fi
		:: true;
		fi
	fi;
	run Anonymous2(outgoing,incoming);
	goto stop_process
stop_process:}

proctype zebracloseChannel(Chandef ch;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
		break
	od;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef outgoing;Chandef incoming) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: outgoing.async_rcv?0;
		:: outgoing.sync?0;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				chan child_zebracloseChannel0 = [0] of {int};
				run zebracloseChannel(outgoing,child_zebracloseChannel0);
				child_zebracloseChannel0?0;
				goto stop_process
			:: true;
			fi
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	od;
for10_exit:stop_process:
}
proctype Anonymous2(Chandef outgoing;Chandef incoming) {
	bool closed; 
	int i;
	chan child_zebracloseChannel1 = [0] of {int};
	do
	:: true -> 
for20:		
		if
		:: true -> 
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: incoming.async_send!0;
				:: incoming.sync!0 -> 
					incoming.sending?0
				fi
			:: true;
			fi
		fi
	od;
for20_exit:	run zebracloseChannel(incoming,child_zebracloseChannel1);
	child_zebracloseChannel1?0;
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

