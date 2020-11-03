
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example276353088/pipeline/plugin_runners.go
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
	Chandef pluginErrChan;
	int i;
	Chandef bufErrChan;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		pluginErrChan.size = 1;
		run emptyChan(pluginErrChan)
	:: else -> 
		run sync_monitor(pluginErrChan)
	fi;
	
	if
	:: 1 > 0 -> 
		bufErrChan.size = 1;
		run emptyChan(bufErrChan)
	:: else -> 
		run sync_monitor(bufErrChan)
	fi;
	run Anonymous0(pluginErrChan,bufErrChan,foRunner_inChan,foRunner_stopChan);
	run Anonymous1(pluginErrChan,bufErrChan,foRunner_inChan,foRunner_stopChan);
	do
	:: pluginErrChan.async_rcv?0 -> 
		break
	:: pluginErrChan.sync?0 -> 
		break
	:: bufErrChan.async_rcv?0 -> 
		break
	:: bufErrChan.sync?0 -> 
		break
	od;
	
	if
	:: true -> 
		
		if
		:: pluginErrChan.async_rcv?0;
		:: pluginErrChan.sync?0;
		fi;
		Chandef foRunner_inChan;
		
		if
		:: 2 > 0 -> 
			foRunner_inChan.size = 2;
			run emptyChan(foRunner_inChan)
		:: else -> 
			run sync_monitor(foRunner_inChan)
		fi
	:: true -> 
		
		if
		:: bufErrChan.async_rcv?0;
		:: bufErrChan.sync?0;
		fi;
		Chandef foRunner_stopChan;
		run sync_monitor(foRunner_stopChan)
	:: true -> 
		
		if
		:: bufErrChan.async_rcv?0;
		:: bufErrChan.sync?0;
		fi;
		Chandef foRunner_stopChan;
		run sync_monitor(foRunner_stopChan)
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef pluginErrChan;Chandef bufErrChan;Chandef foRunner_inChan;Chandef foRunner_stopChan) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true;
	:: true;
	fi;
	
	if
	:: pluginErrChan.async_send!0;
	:: pluginErrChan.sync!0 -> 
		pluginErrChan.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef pluginErrChan;Chandef bufErrChan;Chandef foRunner_inChan;Chandef foRunner_stopChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: bufErrChan.async_send!0;
	:: bufErrChan.sync!0 -> 
		bufErrChan.sending?0
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

