#define Search_engine_initOptions_NumShards 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example507211652/engine.go
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
	chan child_engineRanks5 = [0] of {int};
	Chandef rankerReturnChan;
	int engine_initOptions_NumShards = Search_engine_initOptions_NumShards;
	bool state = false;
	
	if
	:: engine_initOptions_NumShards > 0 -> 
		rankerReturnChan.size = engine_initOptions_NumShards;
		run emptyChan(rankerReturnChan)
	:: else -> 
		run sync_monitor(rankerReturnChan)
	fi;
	
	if
	:: 0 != -1 && engine_initOptions_NumShards-1 != -1 -> 
				for(i : 0.. engine_initOptions_NumShards-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		chan child_engineRankID2 = [0] of {int};
		run engineRankID(rankerReturnChan,child_engineRankID0);
		child_engineRankID2?0;
		goto stop_process
	:: true;
	fi;
	run engineRanks(rankerReturnChan,child_engineRanks3);
	child_engineRanks5?0;
	goto stop_process
stop_process:}

proctype engineRankID(Chandef rankerReturnChan;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		chan child_engineNotTimeOut0 = [0] of {int};
		run engineNotTimeOut(rankerReturnChan,child_engineNotTimeOut0);
		child_engineNotTimeOut0?0
	:: true -> 
		chan child_engineTimeOut1 = [0] of {int};
		run engineTimeOut(rankerReturnChan,child_engineTimeOut1);
		child_engineTimeOut1?0
	:: true -> 
		chan child_engineTimeOut1 = [0] of {int};
		run engineTimeOut(rankerReturnChan,child_engineTimeOut1);
		child_engineTimeOut1?0
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype engineNotTimeOut(Chandef rankerReturnChan;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && engine_initOptions_NumShards-1 != -1 -> 
				for(i : 0.. engine_initOptions_NumShards-1) {
for20:			
			if
			:: rankerReturnChan.async_rcv?0;
			:: rankerReturnChan.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: rankerReturnChan.async_rcv?0;
			:: rankerReturnChan.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype engineTimeOut(Chandef rankerReturnChan;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && engine_initOptions_NumShards-1 != -1 -> 
				for(i : 0.. engine_initOptions_NumShards-1) {
for30:			do
			:: rankerReturnChan.async_rcv?0 -> 
				break
			:: rankerReturnChan.sync?0 -> 
				break
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for30:			do
			:: rankerReturnChan.async_rcv?0 -> 
				break
			:: rankerReturnChan.sync?0 -> 
				break
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype engineRanks(Chandef rankerReturnChan;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		chan child_engineNotTimeOut3 = [0] of {int};
		run engineNotTimeOut(rankerReturnChan,child_engineNotTimeOut3);
		child_engineNotTimeOut3?0
	:: true -> 
		chan child_engineTimeOut4 = [0] of {int};
		run engineTimeOut(rankerReturnChan,child_engineTimeOut4);
		child_engineTimeOut4?0
	:: true -> 
		chan child_engineTimeOut4 = [0] of {int};
		run engineTimeOut(rankerReturnChan,child_engineTimeOut4);
		child_engineTimeOut4?0
	fi;
	goto stop_process;
stop_process:	child!0
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


