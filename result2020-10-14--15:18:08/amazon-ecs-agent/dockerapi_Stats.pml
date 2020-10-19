#define lb_for1347_0  -1
#define ub_for1347_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example903376618/agent/dockerclient/dockerapi/docker_client.go
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
	Chandef errC;
	int i;
	Chandef statsC;
	bool state = false;
	run sync_monitor(errC);
	run sync_monitor(statsC);
	
	if
	:: true -> 
		run Anonymous0(errC,statsC);
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		run Anonymous1(errC,statsC)
	:: true -> 
		run Anonymous2(errC,statsC)
	:: true -> 
		run Anonymous2(errC,statsC)
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errC;Chandef statsC) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: errC.async_send!0;
	:: errC.sync!0 -> 
		errC.sending?0
	fi;
	statsC.closing!true;
stop_process:
}
proctype Anonymous1(Chandef errC;Chandef statsC) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: errC.async_send!0;
		:: errC.sync!0 -> 
			errC.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for1347_0 != -1 && ub_for1347_1 != -1 -> 
				for(i : lb_for1347_0.. ub_for1347_1) {
for10:			
			if
			:: true -> 
				
				if
				:: errC.async_send!0;
				:: errC.sync!0 -> 
					errC.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: errC.async_send!0;
				:: errC.sync!0 -> 
					errC.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: statsC.async_send!0;
			:: statsC.sync!0 -> 
				statsC.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				
				if
				:: errC.async_send!0;
				:: errC.sync!0 -> 
					errC.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: errC.async_send!0;
				:: errC.sync!0 -> 
					errC.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: statsC.async_send!0;
			:: statsC.sync!0 -> 
				statsC.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	statsC.closing!true;
stop_process:
}
proctype Anonymous2(Chandef errC;Chandef statsC) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: errC.async_send!0;
		:: errC.sync!0 -> 
			errC.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: statsC.async_send!0;
	:: statsC.sync!0 -> 
		statsC.sending?0
	fi;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			
			if
			:: errC.async_send!0;
			:: errC.sync!0 -> 
				errC.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: statsC.async_send!0;
		:: statsC.sync!0 -> 
			statsC.sending?0
		fi
	:: true -> 
		break
	od;
	statsC.closing!true;
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

