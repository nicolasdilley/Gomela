#define restoreIntoIndex_restoreChunkKeys  60
#define restoreIntoIndex_kiCache  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example136822689/mvcc/kvstore.go
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
	int restoreChunkKeys = restoreIntoIndex_restoreChunkKeys;
	Chandef revc;
	int i;
	Chandef rkvc;
	int kiCache = restoreIntoIndex_kiCache;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		revc.size = 1;
		run emptyChan(revc)
	:: else -> 
		run sync_monitor(revc)
	fi;
	
	if
	:: restoreChunkKeys > 0 -> 
		rkvc.size = restoreChunkKeys;
		run emptyChan(rkvc)
	:: else -> 
		run sync_monitor(rkvc)
	fi;
	run Anonymous0(rkvc,revc);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef rkvc;Chandef revc) {
	bool closed; 
	int i;
	bool state;
	do
	:: rkvc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: rkvc.async_rcv?0;
			:: rkvc.sync?0;
			fi;
			
			if
			:: true -> 
								for(i : 1.. kiCache) {
for11:					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: true;
			fi
		fi
	od;
	
	if
	:: revc.async_send!0;
	:: revc.sync!0 -> 
		revc.sending?0
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

