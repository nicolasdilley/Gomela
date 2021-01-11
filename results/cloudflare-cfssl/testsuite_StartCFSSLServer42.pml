#define ub_for111_0  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example091868997/helpers/testsuite/testing_helpers.go
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
	Chandef errorOccurred;
	bool state = false;
	int i;
	

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
	run sync_monitor(errorOccurred);
	run go_Anonymous0(errorOccurred);
	do
	:: errorOccurred.async_rcv?0 -> 
		goto stop_process
	:: errorOccurred.sync?0 -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od
stop_process:skip
}

proctype go_Anonymous0(Chandef errorOccurred) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: 0 != -2 && ub_for111_0 != -2 -> 
				for(i : 0.. ub_for111_0) {
			for40934: skip;
			

			if
			:: true -> 
				

				if
				:: errorOccurred.async_send!0;
				:: errorOccurred.sync!0 -> 
					errorOccurred.sending?0
				fi
			:: true;
			fi;
			for40_end934: skip
		};
		for40_exit934: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			

			if
			:: true -> 
				

				if
				:: errorOccurred.async_send!0;
				:: errorOccurred.sync!0 -> 
					errorOccurred.sending?0
				fi
			:: true;
			fi;
			for40_end: skip
		:: true -> 
			break
		od;
		for40_exit: skip
	fi;
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

