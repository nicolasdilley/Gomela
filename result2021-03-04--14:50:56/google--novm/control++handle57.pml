
// https://github.com/google/novm/blob/278237d9ebcaea19695a08151e64555e634442f3/src/novmm/control/server.go#L57
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	run go_handle()
stop_process:skip
}

proctype go_handle() {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef exitcode;
	Chandef outputs;
	Chandef inputs;
	

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
		run go_Anonymous1(inputs,outputs,exitcode);
		run go_Anonymous2(inputs,outputs,exitcode);
		run go_Anonymous3(inputs,outputs,exitcode);
		

		if
		:: exitcode.async_rcv?state,num_msgs;
		:: exitcode.sync?state,num_msgs;
		fi;
		

		if
		:: inputs.async_rcv?state,num_msgs;
		:: inputs.sync?state,num_msgs;
		fi
	fi;
	stop_process: skip;
	
}
proctype go_Anonymous1(Chandef inputs;Chandef outputs;Chandef exitcode) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: exitcode.async_send!0;
		:: exitcode.sync!false,0 -> 
			exitcode.sending?state
		fi
	:: true -> 
		

		if
		:: exitcode.async_send!0;
		:: exitcode.sync!false,0 -> 
			exitcode.sending?state
		fi
	fi;
	stop_process: skip
}
proctype go_Anonymous2(Chandef inputs;Chandef outputs;Chandef exitcode) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: inputs.async_send!0;
			:: inputs.sync!false,0 -> 
				inputs.sending?state
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: inputs.async_send!0;
			:: inputs.sync!false,0 -> 
				inputs.sending?state
			fi;
			goto stop_process
		:: true;
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip
}
proctype go_Anonymous3(Chandef inputs;Chandef outputs;Chandef exitcode) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for20: skip;
		

		if
		:: true -> 
			

			if
			:: outputs.async_send!0;
			:: outputs.sync!false,0 -> 
				outputs.sending?state
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: outputs.async_send!0;
			:: outputs.sync!false,0 -> 
				outputs.sending?state
			fi;
			goto stop_process
		:: true;
		fi;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

