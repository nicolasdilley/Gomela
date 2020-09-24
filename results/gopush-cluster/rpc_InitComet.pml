#define lb_for145_0  -1
#define ub_for145_1  -1
#define lb_for272_2  -1
#define ub_for272_3  -1
#define lb_for106_4  -1
#define ub_for106_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example894637052/rpc/comet.go
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
	Chandef ch;
	bool state = false;
	
	if
	:: 1024 > 0 -> 
		ch.size = 1024;
		run emptyChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run go_rpchandleCometNodeEvent(ch);
	run go_rpcwatchCometRoot(ch)
stop_process:}

proctype go_rpchandleCometNodeEvent(Chandef ch) {
	bool closed; 
	int i;
		for(i : lb_for145_0.. ub_for145_1) {
for10:		
		if
		:: ch.async_rcv?0;
		:: ch.sync?0;
		fi;
		do
		:: true -> 
for11:
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			run go_rpcwatchCometNode(ch)
		fi;
		do
		:: true -> 
for13:
		:: true -> 
			break
		od
	};
for10_exit:stop_process:
}
proctype go_rpcwatchCometNode(Chandef ch) {
	bool closed; 
	int i;
	do
	:: true -> 
for12:		
		if
		:: true -> 
			break
		fi;
		
		if
		:: true -> 
			
			if
			:: ch.async_send!0;
			:: ch.sync!0 -> 
				ch.sending?0
			fi
		:: true -> 
			
			if
			:: ch.async_send!0;
			:: ch.sync!0 -> 
				ch.sending?0
			fi
		fi
	od;
for12_exit:stop_process:
}
proctype go_rpcwatchCometRoot(Chandef ch) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			
			if
			:: true -> 
				do
				:: true -> 
for21:					
					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				:: true -> 
					break
				od
			fi
		fi;
		do
		:: true -> 
for22:			
			if
			:: true -> 
				
				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi
			:: true;
			fi
		:: true -> 
			break
		od;
		do
		:: true -> 
for23:			
			if
			:: true -> 
				
				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi
			:: true;
			fi
		:: true -> 
			break
		od
	od;
for20_exit:stop_process:
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

