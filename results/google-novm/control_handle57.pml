
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example724683020/src/novmm/control/server.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef exitcode;
	Chandef outputs;
	Chandef inputs;
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
		run sync_monitor(inputs);
		run sync_monitor(outputs);
		run sync_monitor(exitcode);
		run go_Anonymous0(inputs,outputs,exitcode);
		run go_Anonymous1(inputs,outputs,exitcode);
		run go_Anonymous2(inputs,outputs,exitcode);
		

		if
		:: inputs.async_rcv?0;
		:: inputs.sync?0;
		fi
	fi
stop_process:skip
}

proctype go_Anonymous0(Chandef inputs;Chandef outputs;Chandef exitcode) {
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
	stop_process: skip
}
proctype go_Anonymous1(Chandef inputs;Chandef outputs;Chandef exitcode) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for10: skip;
		

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
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip
}
proctype go_Anonymous2(Chandef inputs;Chandef outputs;Chandef exitcode) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for20: skip;
		

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
		fi;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip
}
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
		  :: ch.sending!false;  // sending channel is open
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

