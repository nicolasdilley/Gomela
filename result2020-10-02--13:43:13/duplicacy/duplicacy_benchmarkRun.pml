#define lb_for73_0  -1
#define ub_for73_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example593946979/src/duplicacy_benchmark.go
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
	Chandef stopChannel;
	Chandef indexChannel;
	Chandef finishChannel;
	bool state = false;
	
	if
	:: chunkCount > 0 -> 
		indexChannel.size = chunkCount;
		run emptyChan(indexChannel)
	:: else -> 
		run sync_monitor(indexChannel)
	fi;
	
	if
	:: threads > 0 -> 
		stopChannel.size = threads;
		run emptyChan(stopChannel)
	:: else -> 
		run sync_monitor(stopChannel)
	fi;
	
	if
	:: threads > 0 -> 
		finishChannel.size = threads;
		run emptyChan(finishChannel)
	:: else -> 
		run sync_monitor(finishChannel)
	fi;
		for(i : 0.. threads-1) {
for10:		run Anonymous0(indexChannel,stopChannel,finishChannel)
	};
for10_exit:	
	if
	:: 0 != -1 && chunkCount-1 != -1 -> 
				for(i : 0.. chunkCount-1) {
for20:			
			if
			:: indexChannel.async_send!0;
			:: indexChannel.sync!0 -> 
				indexChannel.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: indexChannel.async_send!0;
			:: indexChannel.sync!0 -> 
				indexChannel.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: 0 != -1 && chunkCount-1 != -1 -> 
				for(i : 0.. chunkCount-1) {
for30:			
			if
			:: finishChannel.async_rcv?0;
			:: finishChannel.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: finishChannel.async_rcv?0;
			:: finishChannel.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: 0 != -1 && threads-1 != -1 -> 
				for(i : 0.. threads-1) {
for40:			
			if
			:: stopChannel.async_send!0;
			:: stopChannel.sync!0 -> 
				stopChannel.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for40:			
			if
			:: stopChannel.async_send!0;
			:: stopChannel.sync!0 -> 
				stopChannel.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for40_exit:
stop_process:}

proctype Anonymous0(Chandef indexChannel;Chandef stopChannel;Chandef finishChannel) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		do
		:: stopChannel.async_rcv?0 -> 
			goto stop_process
		:: stopChannel.sync?0 -> 
			goto stop_process
		od
	od;
for11_exit:stop_process:
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
