#define ScanRepositoryUsingGraph_trees  60
#define ScanRepositoryUsingGraph_commits  60
#define ScanRepositoryUsingGraph_tags  60
#define ScanRepositoryUsingGraph_refs  60
#define lb_for56_4  -1
#define ub_for56_5  -1
#define lb_for140_6  -1
#define ub_for140_7  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example556355026/sizes/graph.go
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
	Chandef errChan;
	int refs = ScanRepositoryUsingGraph_refs;
	int commits = ScanRepositoryUsingGraph_commits;
	bool state = false;
	int trees = ScanRepositoryUsingGraph_trees;
	int tags = ScanRepositoryUsingGraph_tags;
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
	:: 1 > 0 -> 
		errChan.size = 1;
		run emptyChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	run Anonymous0(errChan);
	do
	:: true -> 
for20:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: true;
		fi;
		

		if
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		fi
	od;
for20_exit:	
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
	run Anonymous1(errChan);
		for(i : 1.. trees) {
for60:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
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
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	
	if
	:: 0 != -1 && commits-1 != -1 -> 
				for(i : 0.. commits-1) {
for70:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
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
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for70:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
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
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for70_exit:	
	if
	:: true -> 
				for(i : 1.. commits) {
for80:
		}
	:: true;
	fi;
		for(i : 1.. tags) {
for90:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
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
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	
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
		for(i : 1.. refs) {
for100:
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
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
		:: true -> 
			break
		:: true;
		fi;
		
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
		:: true -> 
			
			if
			:: errChan.async_send!0;
			:: errChan.sync!0 -> 
				errChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	od;
for10_exit:	
	if
	:: errChan.async_send!0;
	:: errChan.sync!0 -> 
		errChan.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef errChan) {
	bool closed; 
	int i;
	bool state;
		for(i : 1.. trees) {
for30:		
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
		:: true -> 
			
			if
			:: errChan.async_send!0;
			:: errChan.sync!0 -> 
				errChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	};
	
	if
	:: 0 != -1 && commits-1 != -1 -> 
				for(i : 0.. commits-1) {
for40:			
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
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for40:			
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
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for40_exit:		for(i : 1.. tags) {
for50:		
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
		:: true -> 
			
			if
			:: errChan.async_send!0;
			:: errChan.sync!0 -> 
				errChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	};
	
	if
	:: errChan.async_send!0;
	:: errChan.sync!0 -> 
		errChan.sending?0
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

