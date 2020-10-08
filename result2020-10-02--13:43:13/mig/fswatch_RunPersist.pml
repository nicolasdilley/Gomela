#define lb_for511_0  -1
#define ub_for511_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example867686433/modules/fswatch/fswatch.go
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
	Chandef agentAlertChan;
	int i;
	Chandef handlerErrChan;
	Chandef logChan;
	Chandef regChan;
	Chandef configChan;
	bool state = false;
	
	if
	:: 64 > 0 -> 
		logChan.size = 64;
		run emptyChan(logChan)
	:: else -> 
		run sync_monitor(logChan)
	fi;
	
	if
	:: 64 > 0 -> 
		agentAlertChan.size = 64;
		run emptyChan(agentAlertChan)
	:: else -> 
		run sync_monitor(agentAlertChan)
	fi;
	
	if
	:: 64 > 0 -> 
		regChan.size = 64;
		run emptyChan(regChan)
	:: else -> 
		run sync_monitor(regChan)
	fi;
	
	if
	:: 64 > 0 -> 
		handlerErrChan.size = 64;
		run emptyChan(handlerErrChan)
	:: else -> 
		run sync_monitor(handlerErrChan)
	fi;
	
	if
	:: 1 > 0 -> 
		configChan.size = 1;
		run emptyChan(configChan)
	:: else -> 
		run sync_monitor(configChan)
	fi;
	
	if
	:: true -> 
		
		if
		:: handlerErrChan.async_send!0;
		:: handlerErrChan.sync!0 -> 
			handlerErrChan.sending?0
		fi
	:: true -> 
		
		if
		:: regChan.async_send!0;
		:: regChan.sync!0 -> 
			regChan.sending?0
		fi
	:: true -> 
		
		if
		:: regChan.async_send!0;
		:: regChan.sync!0 -> 
			regChan.sending?0
		fi
	fi;
	run go_modulesHandlePersistRequest(handlerErrChan)
stop_process:}

proctype go_modulesHandlePersistRequest(Chandef errch) {
	bool closed; 
	int i;
		for(i : lb_for511_0.. ub_for511_1) {
for10:		
		if
		:: true -> 
			
			if
			:: errch.async_send!0;
			:: errch.sync!0 -> 
				errch.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		run Anonymous1(errch)
	};
for10_exit:stop_process:
}
proctype Anonymous1(Chandef errch) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: errch.async_send!0;
		:: errch.sync!0 -> 
			errch.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errch.async_send!0;
		:: errch.sync!0 -> 
			errch.sending?0
		fi;
		goto stop_process
	:: true;
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

