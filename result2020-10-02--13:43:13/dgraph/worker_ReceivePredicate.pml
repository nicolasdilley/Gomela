#define lb_for142_0  -1
#define ub_for142_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example076238862/worker/predicate_move.go
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
	bool state = false;
	Chandef che;
	Chandef kvs;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 3 > 0 -> 
		kvs.size = 3;
		run emptyChan(kvs)
	:: else -> 
		run sync_monitor(kvs)
	fi;
	
	if
	:: 1 > 0 -> 
		che.size = 1;
		run emptyChan(che)
	:: else -> 
		run sync_monitor(che)
	fi;
	run Anonymous0(kvs,che);
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
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: kvs.async_send!0 -> 
			break
		:: kvs.sync!0 -> 
			kvs.sending?0;
			break
		:: true -> 
			kvs.closing!true;
			
			if
			:: che.async_rcv?0;
			:: che.sync?0;
			fi;
			goto stop_process
		od
	od;
for20_exit:	kvs.closing!true;
	
	if
	:: che.async_rcv?0;
	:: che.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype workerbatchAndProposeKeyValues(Chandef kvs;chan child) {
	bool closed; 
	int i;
	do
	:: kvs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: kvs.async_rcv?0;
			:: kvs.sync?0;
			fi;
			do
			:: true -> 
for11:				
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
				fi
			:: true -> 
				break
			od
		fi
	od;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef kvs;Chandef che) {
	bool closed; 
	int i;
	chan child_workerbatchAndProposeKeyValues0 = [0] of {int};
	run workerbatchAndProposeKeyValues(kvs,child_workerbatchAndProposeKeyValues0);
	child_workerbatchAndProposeKeyValues0?0;
	
	if
	:: che.async_send!0;
	:: che.sync!0 -> 
		che.sending?0
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

