#define DoPostActionWithCookie_model_PostActionRetainPropKeys 3
#define DoPostActionWithCookie_retain 1
#define DoPostActionWithCookie_remove 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example715326733/app/integration_action.go
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
	Chandef teamChan;
	Chandef cchan;
	int retain = DoPostActionWithCookie_retain;
	Chandef pchan;
	Chandef userChan;
	int model_PostActionRetainPropKeys = DoPostActionWithCookie_model_PostActionRetainPropKeys;
	int remove = DoPostActionWithCookie_remove;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		pchan.size = 1;
		run emptyChan(pchan)
	:: else -> 
		run sync_monitor(pchan)
	fi;
	run Anonymous0(pchan,cchan,userChan,teamChan);
	
	if
	:: 1 > 0 -> 
		cchan.size = 1;
		run emptyChan(cchan)
	:: else -> 
		run sync_monitor(cchan)
	fi;
	run Anonymous1(pchan,cchan,userChan,teamChan);
	
	if
	:: 1 > 0 -> 
		userChan.size = 1;
		run emptyChan(userChan)
	:: else -> 
		run sync_monitor(userChan)
	fi;
	run Anonymous2(pchan,cchan,userChan,teamChan);
	
	if
	:: pchan.async_rcv?0;
	:: pchan.sync?0;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
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
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
		:: true;
		fi
	:: true -> 
		
		if
		:: cchan.async_rcv?0;
		:: cchan.sync?0;
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
				for(i : 0.. model_PostActionRetainPropKeys-1) {
for10:
		}
	:: true -> 
		
		if
		:: cchan.async_rcv?0;
		:: cchan.sync?0;
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
				for(i : 0.. model_PostActionRetainPropKeys-1) {
for10:
		}
	fi;
	
	if
	:: 1 > 0 -> 
		teamChan.size = 1;
		run emptyChan(teamChan)
	:: else -> 
		run sync_monitor(teamChan)
	fi;
	run Anonymous3(pchan,cchan,userChan,teamChan);
	
	if
	:: userChan.async_rcv?0;
	:: userChan.sync?0;
	fi;
	
	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	:: true;
	fi;
	
	if
	:: teamChan.async_rcv?0;
	:: teamChan.sync?0;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
		:: true;
		fi
	:: true;
	fi;
	
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
		fi;
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. retain-1) {
for20:
			};
						for(i : 0.. remove-1) {
for30:
			}
		:: true -> 
						for(i : 0.. retain-1) {
for20:
			};
						for(i : 0.. remove-1) {
for30:
			}
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. retain-1) {
for40:
		}
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef pchan;Chandef cchan;Chandef userChan;Chandef teamChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: pchan.async_send!0;
	:: pchan.sync!0 -> 
		pchan.sending?0
	fi;
	pchan.closing!true;
stop_process:
}
proctype Anonymous1(Chandef pchan;Chandef cchan;Chandef userChan;Chandef teamChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: cchan.async_send!0;
	:: cchan.sync!0 -> 
		cchan.sending?0
	fi;
	cchan.closing!true;
stop_process:
}
proctype Anonymous2(Chandef pchan;Chandef cchan;Chandef userChan;Chandef teamChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: userChan.async_send!0;
	:: userChan.sync!0 -> 
		userChan.sending?0
	fi;
	userChan.closing!true;
stop_process:
}
proctype Anonymous3(Chandef pchan;Chandef cchan;Chandef userChan;Chandef teamChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: teamChan.async_send!0;
	:: teamChan.sync!0 -> 
		teamChan.sending?0
	fi;
stop_process:	teamChan.closing!true
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


