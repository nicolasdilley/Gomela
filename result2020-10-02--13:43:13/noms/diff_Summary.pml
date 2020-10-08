
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example068066955/go/diff/summary.go
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
	
	if
	:: true -> 
		
		if
		:: true -> 
			

			if
			:: true -> 
				chan child_diffdiffSummaryList0 = [0] of {int};
				run diffdiffSummaryList(ch,child_diffdiffSummaryList0);
				child_diffdiffSummaryList0?0
			:: true -> 
				chan child_diffdiffSummaryMap3 = [0] of {int};
				run diffdiffSummaryMap(ch,child_diffdiffSummaryMap1);
				child_diffdiffSummaryMap3?0
			:: true -> 
				chan child_diffdiffSummarySet5 = [0] of {int};
				run diffdiffSummarySet(ch,child_diffdiffSummarySet4);
				child_diffdiffSummarySet5?0
			:: true -> 
				chan child_diffdiffSummaryStructs7 = [0] of {int};
				run diffdiffSummaryStructs(ch,child_diffdiffSummaryStructs6);
				child_diffdiffSummaryStructs7?0
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
proctype Anonymous2(Chandef spliceChan;Chandef stopChan;Chandef ch) {
	bool closed; 
	int i;
	spliceChan.closing!true;
stop_process:
}
proctype diffdiffSummaryMap(Chandef ch;chan child) {
	bool closed; 
	int i;
	chan child_diffdiffSummaryValueChanged2 = [0] of {int};
	run diffdiffSummaryValueChanged(ch,child_diffdiffSummaryValueChanged1);
	child_diffdiffSummaryValueChanged2?0;
	child!0;
stop_process:
}
proctype diffdiffSummaryValueChanged(Chandef ch;chan child) {
	bool closed; 
	int i;
	Chandef changeChan;
	chan child_diffreportChanges1 = [0] of {int};
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
	run Anonymous5(changeChan,stopChan,ch);
	run diffreportChanges(ch,changeChan,child_diffreportChanges1);
	child_diffreportChanges1?0;
	child!0;
stop_process:
}
proctype Anonymous5(Chandef changeChan;Chandef stopChan;Chandef ch) {
	bool closed; 
	int i;
	changeChan.closing!true;
stop_process:
}
proctype diffreportChanges(Chandef ch;Chandef changeChan;chan child) {
	bool closed; 
	int i;
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
	chan child_diffdiffSummaryValueChanged4 = [0] of {int};
	run diffdiffSummaryValueChanged(ch,child_diffdiffSummaryValueChanged4);
	child_diffdiffSummaryValueChanged4?0;
	child!0;
stop_process:
}
proctype diffdiffSummaryStructs(Chandef ch;chan child) {
	bool closed; 
	int i;
	chan child_diffdiffSummaryValueChanged6 = [0] of {int};
	run diffdiffSummaryValueChanged(ch,child_diffdiffSummaryValueChanged6);
	child_diffdiffSummaryValueChanged6?0;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef ch) {
	bool closed; 
	int i;
	chan child_diffdiffSummary8 = [0] of {int};
	run diffdiffSummary(ch,child_diffdiffSummary0);
	child_diffdiffSummary8?0;
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

