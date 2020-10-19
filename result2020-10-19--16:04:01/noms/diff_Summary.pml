
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example438574528/go/diff/summary.go
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
	Chandef ch;
	bool state = false;
	int i;
	
	if
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true;
		fi
	:: true;
	fi;
	run sync_monitor(ch);
	run Anonymous0(ch);
	do
	:: ch.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: ch.async_rcv?0;
			:: ch.sync?0;
			fi
		fi
	od
stop_process:}

proctype diffdiffSummary(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: true -> 
			

			if
			:: true -> 
				chan child_diffdiffSummaryList6 = [0] of {int};
				run diffdiffSummaryList(ch,child_diffdiffSummaryList0);
				child_diffdiffSummaryList6?0
			:: true -> 
				chan child_diffdiffSummaryMap9 = [0] of {int};
				run diffdiffSummaryMap(ch,child_diffdiffSummaryMap7);
				child_diffdiffSummaryMap9?0
			:: true -> 
				chan child_diffdiffSummarySet11 = [0] of {int};
				run diffdiffSummarySet(ch,child_diffdiffSummarySet10);
				child_diffdiffSummarySet11?0
			:: true -> 
				chan child_diffdiffSummaryStructs13 = [0] of {int};
				run diffdiffSummaryStructs(ch,child_diffdiffSummaryStructs12);
				child_diffdiffSummaryStructs13?0
			:: true;
			fi
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
	:: true;
	fi;
	child!0;
stop_process:
}
proctype diffdiffSummaryList(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef stopChan;
	Chandef spliceChan;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	run sync_monitor(spliceChan);
	
	if
	:: 1 > 0 -> 
		stopChan.size = 1;
		run emptyChan(stopChan)
	:: else -> 
		run sync_monitor(stopChan)
	fi;
	run Anonymous2(spliceChan,stopChan,ch);
	do
	:: spliceChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: spliceChan.async_rcv?0;
			:: spliceChan.sync?0;
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
			:: true -> 
				
				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi
			fi
		fi
	od;
	child!0;
stop_process:
}
proctype v2Diff(Chandef changes;Chandef closeChan;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_lDiffWithLimit4 = [0] of {int};
	run lDiffWithLimit(changes,closeChan,child_lDiffWithLimit0);
	child_lDiffWithLimit4?0;
	child!0;
stop_process:
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
	child!0;
stop_process:
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
	child!0;
stop_process:
}
proctype Anonymous2(Chandef spliceChan;Chandef stopChan;Chandef ch) {
	bool closed; 
	int i;
	bool state;
	chan child_v2Diff5 = [0] of {int};
	run v2Diff(spliceChan,stopChan,child_v2Diff0);
	child_v2Diff5?0;
	spliceChan.closing!true;
stop_process:
}
proctype diffdiffSummaryMap(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_diffdiffSummaryValueChanged8 = [0] of {int};
	run diffdiffSummaryValueChanged(ch,child_diffdiffSummaryValueChanged7);
	child_diffdiffSummaryValueChanged8?0;
	child!0;
stop_process:
}
proctype diffdiffSummaryValueChanged(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef changeChan;
	chan child_diffreportChanges7 = [0] of {int};
	Chandef stopChan;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	run sync_monitor(changeChan);
	
	if
	:: 1 > 0 -> 
		stopChan.size = 1;
		run emptyChan(stopChan)
	:: else -> 
		run sync_monitor(stopChan)
	fi;
	run Anonymous8(changeChan,stopChan,ch);
	run diffreportChanges(ch,changeChan,child_diffreportChanges7);
	child_diffreportChanges7?0;
	child!0;
stop_process:
}
proctype Anonymous8(Chandef changeChan;Chandef stopChan;Chandef ch) {
	bool closed; 
	int i;
	bool state;
	changeChan.closing!true;
stop_process:
}
proctype diffreportChanges(Chandef ch;Chandef changeChan;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: changeChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: changeChan.async_rcv?0;
			:: changeChan.sync?0;
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
			:: true -> 
				
				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi
			:: true;
			fi
		fi
	od;
	child!0;
stop_process:
}
proctype diffdiffSummarySet(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_diffdiffSummaryValueChanged10 = [0] of {int};
	run diffdiffSummaryValueChanged(ch,child_diffdiffSummaryValueChanged10);
	child_diffdiffSummaryValueChanged10?0;
	child!0;
stop_process:
}
proctype diffdiffSummaryStructs(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_diffdiffSummaryValueChanged12 = [0] of {int};
	run diffdiffSummaryValueChanged(ch,child_diffdiffSummaryValueChanged12);
	child_diffdiffSummaryValueChanged12?0;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef ch) {
	bool closed; 
	int i;
	bool state;
	chan child_diffdiffSummary14 = [0] of {int};
	run diffdiffSummary(ch,child_diffdiffSummary0);
	child_diffdiffSummary14?0;
	ch.closing!true;
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

