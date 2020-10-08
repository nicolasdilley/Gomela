#define lb_for396_0  -1
#define ub_for396_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example646408234/agent/dockerclient/dockerapi/docker_client.go
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
	Chandef pullFinished;
	Chandef pullBegan;
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		pullBegan.size = 1;
		run emptyChan(pullBegan)
	:: else -> 
		run sync_monitor(pullBegan)
	fi;
	
	if
	:: 1 > 0 -> 
		pullFinished.size = 1;
		run emptyChan(pullFinished)
	:: else -> 
		run sync_monitor(pullFinished)
	fi;
	run Anonymous0(pullBegan,pullFinished);
	do
	:: pullBegan.async_rcv?0 -> 
		goto for10_exit
	:: pullBegan.sync?0 -> 
		goto for10_exit;
		break
	:: true -> 
		goto stop_process
	od;
	
	if
	:: pullFinished.async_rcv?0;
	:: pullFinished.sync?0;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef pullBegan;Chandef pullFinished) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: pullFinished.async_send!0;
		:: pullFinished.sync!0 -> 
			pullFinished.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for396_0 != -1 && ub_for396_1 != -1 -> 
				for(i : lb_for396_0.. ub_for396_1) {
for10:			
			if
			:: true -> 
				
				if
				:: pullFinished.async_send!0;
				:: pullFinished.sync!0 -> 
					pullFinished.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: pullFinished.async_send!0;
				:: pullFinished.sync!0 -> 
					pullFinished.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: pullFinished.async_send!0;
				:: pullFinished.sync!0 -> 
					pullFinished.sending?0
				fi;
				goto stop_process
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
				:: pullFinished.async_send!0;
				:: pullFinished.sync!0 -> 
					pullFinished.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: pullFinished.async_send!0;
				:: pullFinished.sync!0 -> 
					pullFinished.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: pullFinished.async_send!0;
				:: pullFinished.sync!0 -> 
					pullFinished.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: pullFinished.async_send!0;
	:: pullFinished.sync!0 -> 
		pullFinished.sending?0
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

