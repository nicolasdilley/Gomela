#define findConsoleImpl_consoles  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example125118360/vm/adb/adb.go
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
	Chandef done;
	Chandef errors;
	int num_msgs = 0;
	bool state = false;
	int i;
	int output=3;
	int consoles = findConsoleImpl_consoles;
	

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
	:: consoles > 0 -> 
		errors.size = consoles;
		run AsyncChan(errors)
	:: else -> 
		run sync_monitor(errors)
	fi;
	run sync_monitor(done);
		for(i : 0.. consoles-1) {
		for10: skip;
		

		if
		:: true -> 
			goto for10_end
		:: true;
		fi;
		run go_Anonymous0(errors,done);
		for10_end: skip
	};
	for10_exit: skip;
	

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
	done.closing!true;
	

	if
	:: output-1 != -3 -> 
				for(i : 0.. output-1) {
			for20: skip;
			

			if
			:: errors.async_rcv?state,num_msgs;
			:: errors.sync?state,num_msgs;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for201028: skip;
			

			if
			:: errors.async_rcv?state,num_msgs;
			:: errors.sync?state,num_msgs;
			fi;
			for20_end1028: skip
		:: true -> 
			break
		od;
		for20_exit1028: skip
	fi;
	

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
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef errors;Chandef done) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errors.async_send!0;
		:: errors.sync!false,0 -> 
			errors.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	run go_Anonymous1(errors,done);
	

	if
	:: errors.async_send!0;
	:: errors.sync!false,0 -> 
		errors.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef errors;Chandef done) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: done.async_rcv?state,num_msgs;
	:: done.sync?state,num_msgs;
	fi;
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


