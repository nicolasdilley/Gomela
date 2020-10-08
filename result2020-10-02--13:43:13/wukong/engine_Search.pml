
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example603070137/engine/engine.go
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
	Chandef rankerReturnChannel;
	int rankerOutput_docs = 5;
	int request_Tokens = 5;
	bool state = false;
	int querySegments = 5;
	int engine_initOptions_NumShards = 5;
	int i;
	
	if
	:: true -> 
				for(i : 1.. querySegments) {
for10:
		}
	:: true -> 
				for(i : 1.. request_Tokens) {
for20:
		}
	:: true -> 
				for(i : 1.. request_Tokens) {
for20:
		}
	fi;
	
	if
	:: engine_initOptions_NumShards > 0 -> 
		rankerReturnChannel.size = engine_initOptions_NumShards;
		run emptyChan(rankerReturnChannel)
	:: else -> 
		run sync_monitor(rankerReturnChannel)
	fi;
	
	if
	:: 0 != -1 && engine_initOptions_NumShards-1 != -1 -> 
				for(i : 0.. engine_initOptions_NumShards-1) {
for30:
		}
	:: else -> 
		do
		:: true -> 
for30:
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: true -> 
		
		if
		:: 0 != -1 && engine_initOptions_NumShards-1 != -1 -> 
						for(i : 0.. engine_initOptions_NumShards-1) {
for40:				
				if
				:: rankerReturnChannel.async_rcv?0;
				:: rankerReturnChannel.sync?0;
				fi;
				
				if
				:: true -> 
										for(i : 1.. rankerOutput_docs) {
for41:
					}
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for40:				
				if
				:: rankerReturnChannel.async_rcv?0;
				:: rankerReturnChannel.sync?0;
				fi;
				
				if
				:: true -> 
										for(i : 1.. rankerOutput_docs) {
for41:
					}
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for40_exit:
	:: true -> 
		
		if
		:: 0 != -1 && engine_initOptions_NumShards-1 != -1 -> 
						for(i : 0.. engine_initOptions_NumShards-1) {
for50:				do
				:: true -> 
					break
				od
			}
		:: else -> 
			do
			:: true -> 
for50:				do
				:: true -> 
					break
				od
			:: true -> 
				break
			od
		fi;
for50_exit:
	:: true -> 
		
		if
		:: 0 != -1 && engine_initOptions_NumShards-1 != -1 -> 
						for(i : 0.. engine_initOptions_NumShards-1) {
for50:				do
				:: true -> 
					break
				od
			}
		:: else -> 
			do
			:: true -> 
for50:				do
				:: true -> 
					break
				od
			:: true -> 
				break
			od
		fi;
for50_exit:
	fi;
	goto stop_process
stop_process:}

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

