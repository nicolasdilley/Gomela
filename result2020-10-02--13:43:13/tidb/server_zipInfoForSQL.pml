
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example811888897/server/sql_info_fetcher.go
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
	int result_rows = 5;
	int pairs = 5;
	bool state = false;
	int sRows = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. pairs) {
for10:
	};
		for(i : 1.. pairs) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	
	if
	:: true -> 
		
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
				for(i : 1.. sRows) {
for30:
		}
	:: true -> 
		Chandef resultChan;
		run sync_monitor(resultChan);
		run go_shgetExplainAnalyze(resultChan);
		Chandef errChan;
		run sync_monitor(errChan);
		run go_shcatchCPUProfile(errChan);
		do
		:: true;
		od;
		chan child_serverdumpCPUProfile0 = [0] of {int};
		run serverdumpCPUProfile(errChan,child_serverdumpCPUProfile0);
		child_serverdumpCPUProfile0?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		Chandef resultChan;
		run sync_monitor(resultChan);
		run go_shgetExplainAnalyze(resultChan);
		Chandef errChan;
		run sync_monitor(errChan);
		run go_shcatchCPUProfile(errChan);
		do
		:: true;
		od;
		chan child_serverdumpCPUProfile0 = [0] of {int};
		run serverdumpCPUProfile(errChan,child_serverdumpCPUProfile0);
		child_serverdumpCPUProfile0?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi
stop_process:}

proctype go_shgetExplainAnalyze(Chandef resultChan) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: resultChan.async_send!0;
		:: resultChan.sync!0 -> 
			resultChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: resultChan.async_send!0;
	:: resultChan.sync!0 -> 
		resultChan.sending?0
	fi;
stop_process:
}
proctype go_shcatchCPUProfile(Chandef errChan) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: errChan.async_send!0;
		:: errChan.sync!0 -> 
			errChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: errChan.async_send!0;
	:: errChan.sync!0 -> 
		errChan.sending?0
	fi;
stop_process:
}
proctype serverdumpCPUProfile(Chandef errChan;chan child) {
	bool closed; 
	int i;
	
	if
	:: errChan.async_rcv?0;
	:: errChan.sync?0;
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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	child!0;
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
