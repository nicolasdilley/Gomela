#define lb_for54_0  -1
#define ub_for54_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example807304111/go/merge/three_way_list.go
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
	Chandef bSpliceChan;
	chan child_mergestopAndDrain8 = [0] of {int};
	Chandef bStopChan;
	int i;
	Chandef aSpliceChan;
	Chandef aStopChan;
	chan child_mergestopAndDrain9 = [0] of {int};
	bool state = false;
	run sync_monitor(bSpliceChan);
	run sync_monitor(aSpliceChan);
	
	if
	:: 1 > 0 -> 
		bStopChan.size = 1;
		run emptyChan(bStopChan)
	:: else -> 
		run sync_monitor(bStopChan)
	fi;
	
	if
	:: 1 > 0 -> 
		aStopChan.size = 1;
		run emptyChan(aStopChan)
	:: else -> 
		run sync_monitor(aStopChan)
	fi;
	run Anonymous0(aSpliceChan,bSpliceChan,aStopChan,bStopChan);
	run Anonymous4(aSpliceChan,bSpliceChan,aStopChan,bStopChan);
	do
	:: true -> 
for30:		
		if
		:: true -> 
			
			if
			:: aSpliceChan.async_rcv?0;
			:: aSpliceChan.sync?0;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: bSpliceChan.async_rcv?0;
			:: bSpliceChan.sync?0;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for30_exit:	goto stop_process;
	run mergestopAndDrain(aStopChan,aSpliceChan,child_mergestopAndDrain8);
	child_mergestopAndDrain8?0;
	run mergestopAndDrain(bStopChan,bSpliceChan,child_mergestopAndDrain9);
	child_mergestopAndDrain9?0
stop_process:}

proctype aDiff(Chandef changes;Chandef closeChan;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_lDiffWithLimit4 = [0] of {int};
	run lDiffWithLimit(changes,closeChan,child_lDiffWithLimit0);
	child_lDiffWithLimit4?0;
stop_process:	child!0
}
proctype lDiffWithLimit(Chandef changes;Chandef closeChan;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_typesindexedSequenceDiff3 = [0] of {int};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: changes.async_send!0;
		:: changes.sync!0 -> 
			changes.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: changes.async_send!0;
		:: changes.sync!0 -> 
			changes.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	run typesindexedSequenceDiff(changes,closeChan,child_typesindexedSequenceDiff0);
	child_typesindexedSequenceDiff3?0;
stop_process:	child!0
}
proctype typesindexedSequenceDiff(Chandef changes;Chandef closeChan;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		chan child_typesindexedSequenceDiff0 = [0] of {int};
		run typesindexedSequenceDiff(changes,closeChan,child_typesindexedSequenceDiff0);
		child_typesindexedSequenceDiff0?0;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		chan child_typesindexedSequenceDiff1 = [0] of {int};
		run typesindexedSequenceDiff(changes,closeChan,child_typesindexedSequenceDiff1);
		child_typesindexedSequenceDiff1?0;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		chan child_typesindexedSequenceDiff2 = [0] of {int};
		run typesindexedSequenceDiff(changes,closeChan,child_typesindexedSequenceDiff2);
		child_typesindexedSequenceDiff2?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		break
	od;
	goto stop_process;
stop_process:	child!0
}
proctype Anonymous0(Chandef aSpliceChan;Chandef bSpliceChan;Chandef aStopChan;Chandef bStopChan) {
	bool closed; 
	int i;
	bool state;
	chan child_aDiff5 = [0] of {int};
	run aDiff(aSpliceChan,aStopChan,child_aDiff0);
	child_aDiff5?0;
	aSpliceChan.closing!true;
stop_process:
}
proctype bDiff(Chandef changes;Chandef closeChan;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_lDiffWithLimit6 = [0] of {int};
	run lDiffWithLimit(changes,closeChan,child_lDiffWithLimit6);
	child_lDiffWithLimit6?0;
stop_process:	child!0
}
proctype Anonymous4(Chandef aSpliceChan;Chandef bSpliceChan;Chandef aStopChan;Chandef bStopChan) {
	bool closed; 
	int i;
	bool state;
	chan child_bDiff7 = [0] of {int};
	run bDiff(bSpliceChan,bStopChan,child_bDiff6);
	child_bDiff7?0;
	bSpliceChan.closing!true;
stop_process:
}
proctype mergestopAndDrain(Chandef stop;Chandef drain;chan child) {
	bool closed; 
	int i;
	bool state;
	stop.closing!true;
	do
	:: drain.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: drain.async_rcv?0;
			:: drain.sync?0;
			fi
		fi
	od;
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

