#define applyMutations_initialSchema  60
#define applyMutations_initialTypes  60
#define applyMutations_proposal_Mutations_Schema  60
#define applyMutations_proposal_Mutations_Types  60
#define applyMutations_proposal_Mutations_Edges  60
#define applyMutations_schemaMap  60
#define applyMutations_edges  60
#define applyMutations_numGo  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example897304492/worker/draft.go
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
	int proposal_Mutations_Types = applyMutations_proposal_Mutations_Types;
	Chandef errCh;
	int numGo = applyMutations_numGo;
	int initialTypes = applyMutations_initialTypes;
	int schemaMap = applyMutations_schemaMap;
	bool state = false;
	int initialSchema = applyMutations_initialSchema;
	int proposal_Mutations_Schema = applyMutations_proposal_Mutations_Schema;
	int proposal_Mutations_Edges = applyMutations_proposal_Mutations_Edges;
	int edges = applyMutations_edges;
	int i;
	
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
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
						for(i : 1.. initialSchema) {
for10:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					goto stop_process
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				fi
			}
		:: true;
		fi;
				for(i : 1.. initialTypes) {
for20:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		};
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
				for(i : 1.. proposal_Mutations_Schema) {
for30:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		};
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 1.. proposal_Mutations_Types) {
for40:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		};
		goto stop_process
	:: true;
	fi;
		for(i : 1.. proposal_Mutations_Edges) {
for50:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: true;
		fi
	};
		for(i : 1.. schemaMap) {
for60:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	};
	
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
	
	if
	:: numGo > 0 -> 
		errCh.size = numGo;
		run emptyChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
		for(i : 0.. numGo-1) {
for70:		run Anonymous0(errCh)
	};
for70_exit:	
	if
	:: 0 != -1 && numGo-1 != -1 -> 
				for(i : 0.. numGo-1) {
for80:			
			if
			:: errCh.async_rcv?0;
			:: errCh.sync?0;
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
for80:			
			if
			:: errCh.async_rcv?0;
			:: errCh.sync?0;
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
for80_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: errCh.async_send!0;
	:: errCh.sync!0 -> 
		errCh.sending?0
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

