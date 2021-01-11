#define ub_for243_0  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example047883942/github/github.go
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
	Chandef responses;
	Chandef done;
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(done);
	

	if
	:: 5 > 0 -> 
		responses.size = 5;
		run AsyncChan(responses)
	:: else -> 
		run sync_monitor(responses)
	fi;
	

	if
	:: responses.async_send!0;
	:: responses.sync!0 -> 
		responses.sending?0
	fi;
	run go_Anonymous0(done,responses);
	run go_Anonymous1(done,responses);
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef done;Chandef responses) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: 0 != -2 && ub_for243_0 != -2 -> 
				for(i : 0.. ub_for243_0) {
			for102228: skip;
			

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
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: done.async_rcv?0 -> 
				goto stop_process
			:: done.sync?0 -> 
				goto stop_process
			:: responses.async_send!0 -> 
				break
			:: responses.sync!0 -> 
				responses.sending?0;
				break
			od;
			for10_end2228: skip
		};
		for10_exit2228: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

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
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: done.async_rcv?0 -> 
				goto stop_process
			:: done.sync?0 -> 
				goto stop_process
			:: responses.async_send!0 -> 
				break
			:: responses.sync!0 -> 
				responses.sending?0;
				break
			od;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	responses.closing!true
}
proctype go_Anonymous1(Chandef done;Chandef responses) {
	bool closed; 
	int i;
	bool state;
	do
	:: responses.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: responses.async_rcv?0;
			:: responses.sync?0;
			fi;
			for30: skip;
			

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
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	stop_process: skip;
	done.closing!true;
	for20_exit: skip;
	do
	:: responses.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: responses.async_rcv?0;
			:: responses.sync?0;
			fi;
			for20: skip;
			for20_end: skip
		fi
	od
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

