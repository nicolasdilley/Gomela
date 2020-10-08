#define lb_for386_0  -1
#define ub_for386_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example473882999/pkg/dockerclient/shell.go
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
	Chandef containerHealthy;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		containerHealthy.size = 1;
		run emptyChan(containerHealthy)
	:: else -> 
		run sync_monitor(containerHealthy)
	fi;
	
	if
	:: true -> 
		Chandef timeoutChan;
		
		if
		:: 1 > 0 -> 
			timeoutChan.size = 1;
			run emptyChan(timeoutChan)
		:: else -> 
			run sync_monitor(timeoutChan)
		fi
	fi;
	run Anonymous0(containerHealthy,timeoutChan);
	do
	:: timeoutChan.async_rcv?0 -> 
		goto stop_process
	:: timeoutChan.sync?0 -> 
		goto stop_process
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef containerHealthy;Chandef timeoutChan) {
	bool closed; 
	int i;
	
	if
	:: lb_for386_0 != -1 && ub_for386_1 != -1 -> 
				for(i : lb_for386_0.. ub_for386_1) {
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!0 -> 
						containerHealthy.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!0 -> 
						containerHealthy.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!0 -> 
						containerHealthy.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!0 -> 
						containerHealthy.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!0 -> 
						containerHealthy.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!0 -> 
						containerHealthy.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:stop_process:
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

