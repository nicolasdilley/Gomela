
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example568214541/pipeline/report.go
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
	Chandef reports;
	int i;
	int pack_Message_Fields = 5;
	bool state = false;
	run sync_monitor(reports);
	run go_pcreports(reports);
	do
	:: reports.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: reports.async_rcv?0;
			:: reports.sync?0;
			fi;
						for(i : 1.. pack_Message_Fields) {
for81:
			}
		fi
	od;
	goto stop_process
stop_process:}

proctype go_pcreports(Chandef reportChan) {
	bool closed; 
	int i;
	
	if
	:: reportChan.async_send!0;
	:: reportChan.sync!0 -> 
		reportChan.sending?0
	fi;
	
	if
	:: reportChan.async_send!0;
	:: reportChan.sync!0 -> 
		reportChan.sending?0
	fi;
	
	if
	:: reportChan.async_send!0;
	:: reportChan.sync!0 -> 
		reportChan.sending?0
	fi;
		for(i : 1.. pc_InputRunners) {
for10:		
		if
		:: reportChan.async_send!0;
		:: reportChan.sync!0 -> 
			reportChan.sending?0
		fi
	};
		for(i : 1.. pc_allDecoders) {
for20:		
		if
		:: reportChan.async_send!0;
		:: reportChan.sync!0 -> 
			reportChan.sending?0
		fi
	};
		for(i : 1.. pc_allSyncDecoders) {
for30:		
		if
		:: reportChan.async_send!0;
		:: reportChan.sync!0 -> 
			reportChan.sending?0
		fi
	};
		for(i : 1.. pc_allSplitters) {
for40:		
		if
		:: reportChan.async_send!0;
		:: reportChan.sync!0 -> 
			reportChan.sending?0
		fi
	};
		for(i : 1.. pc_allEncoders) {
for50:		
		if
		:: reportChan.async_send!0;
		:: reportChan.sync!0 -> 
			reportChan.sending?0
		fi
	};
		for(i : 1.. pc_FilterRunners) {
for60:		
		if
		:: reportChan.async_send!0;
		:: reportChan.sync!0 -> 
			reportChan.sending?0
		fi
	};
		for(i : 1.. pc_OutputRunners) {
for70:		
		if
		:: reportChan.async_send!0;
		:: reportChan.sync!0 -> 
			reportChan.sending?0
		fi
	};
	reportChan.closing!true;
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
