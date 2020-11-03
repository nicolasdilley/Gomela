#define lb_for144_0  -1
#define ub_for144_1  -1
#define lb_for164_2  -1
#define ub_for164_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example049698811/src/novmm/control/server.go
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
		Chandef inputs;
		run sync_monitor(inputs);
		Chandef outputs;
		run sync_monitor(outputs);
		Chandef exitcode;
		run sync_monitor(exitcode);
		run Anonymous0(inputs,outputs,exitcode);
		run Anonymous1(inputs,outputs,exitcode);
		run Anonymous2(inputs,outputs,exitcode);
		
		if
		:: exitcode.async_rcv?0;
		:: exitcode.sync?0;
		fi;
		
		if
		:: inputs.async_rcv?0;
		:: inputs.sync?0;
		fi
	fi
stop_process:}

proctype Anonymous0(Chandef inputs;Chandef outputs;Chandef exitcode) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: exitcode.async_send!0;
		:: exitcode.sync!0 -> 
			exitcode.sending?0
		fi
	:: true -> 
		
		if
		:: exitcode.async_send!0;
		:: exitcode.sync!0 -> 
			exitcode.sending?0
		fi
	:: true -> 
		
		if
		:: exitcode.async_send!0;
		:: exitcode.sync!0 -> 
			exitcode.sending?0
		fi
	fi;
stop_process:
}
proctype Anonymous1(Chandef inputs;Chandef outputs;Chandef exitcode) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: inputs.async_send!0;
			:: inputs.sync!0 -> 
				inputs.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: inputs.async_send!0;
			:: inputs.sync!0 -> 
				inputs.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	od;
for10_exit:stop_process:
}
proctype Anonymous2(Chandef inputs;Chandef outputs;Chandef exitcode) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			
			if
			:: outputs.async_send!0;
			:: outputs.sync!0 -> 
				outputs.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: outputs.async_send!0;
			:: outputs.sync!0 -> 
				outputs.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	od;
for20_exit:stop_process:
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

