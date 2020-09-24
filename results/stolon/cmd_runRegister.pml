#define lb_for115_0  -1
#define ub_for115_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example589735668/cmd/stolonctl/cmd/register.go
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
	chan child_cmdregisterCluster0 = [0] of {int};
	Chandef sigs;
	int i;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		sigs.size = 1;
		run emptyChan(sigs)
	:: else -> 
		run sync_monitor(sigs)
	fi;
	run cmdregisterCluster(sigs,child_cmdregisterCluster0);
	child_cmdregisterCluster0?0
stop_process:}

proctype cmdregisterCluster(Chandef sigs;chan child) {
	bool closed; 
	int i;
	Chandef endCh;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(endCh);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : lb_for115_0.. ub_for115_1) {
for10:		do
		:: sigs.async_rcv?0 -> 
			goto stop_process
		:: sigs.sync?0 -> 
			goto stop_process
		:: true -> 
			run Anonymous1(endCh,sigs)
		:: endCh.async_rcv?0 -> 
			break
		:: endCh.sync?0 -> 
			break
		od
	};
for10_exit:	child!0;
stop_process:
}
proctype Anonymous1(Chandef endCh;Chandef sigs) {
	bool closed; 
	int i;
	
	if
	:: endCh.async_send!0;
	:: endCh.sync!0 -> 
		endCh.sending?0
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

