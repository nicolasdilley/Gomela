
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example167378074/pkg/sql/catalog/lease/lease.go
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
	Chandef descUpdateCh;
	int i;
	chan child_mwatchForUpdates2 = [0] of {int};
	bool state = false;
	run sync_monitor(descUpdateCh);
	run mwatchForUpdates(descUpdateCh,child_mwatchForUpdates0);
	child_mwatchForUpdates2?0
stop_process:}

proctype mwatchForUpdates(Chandef descUpdateCh;chan child) {
	bool closed; 
	int i;
	chan child_mwatchForGossipUpdates1 = [0] of {int};
	
	if
	:: true -> 
		chan child_mwatchForRangefeedUpdates0 = [0] of {int};
		run mwatchForRangefeedUpdates(descUpdateCh,child_mwatchForRangefeedUpdates0);
		child_mwatchForRangefeedUpdates0?0;
		goto stop_process
	:: true;
	fi;
	run mwatchForGossipUpdates(descUpdateCh,child_mwatchForGossipUpdates1);
	child_mwatchForGossipUpdates1?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	child!0;
stop_process:
}
proctype mwatchForRangefeedUpdates(Chandef descUpdateCh;chan child) {
	bool closed; 
	int i;
	Chandef eventCh;
	run sync_monitor(eventCh);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	child!0;
stop_process:
}
proctype mwatchForGossipUpdates(Chandef descUpdateCh;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

