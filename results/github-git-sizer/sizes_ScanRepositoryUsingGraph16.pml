
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example782630972/sizes/graph.go
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
	Chandef errChan;
	bool state = false;
	int i;
	int tags=3;
	int commits=3;
	int trees=3;
	

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
	:: 1 > 0 -> 
		errChan.size = 1;
		run AsyncChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	run go_Anonymous0(errChan);
	

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
	run go_Anonymous1(errChan,trees,commits,tags);
	

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
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef errChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: errChan.async_send!0;
			:: errChan.sync!0 -> 
				errChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		

		if
		:: true -> 
			goto for10_end
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: errChan.async_send!0;
			:: errChan.sync!0 -> 
				errChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: errChan.async_send!0;
			:: errChan.sync!0 -> 
				errChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	

	if
	:: errChan.async_send!0;
	:: errChan.sync!0 -> 
		errChan.sending?0
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef errChan;int trees;int commits;int tags) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: trees-1 != -3 -> 
				for(i : 0.. trees-1) {
			for30: skip;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for301940: skip;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			for30_end1940: skip
		:: true -> 
			break
		od;
		for30_exit1940: skip
	fi;
	

	if
	:: 0 != -2 && commits-1 != -3 -> 
				for(i : 0.. commits-1) {
			for401941: skip;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			for40_end1941: skip
		};
		for40_exit1941: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			for40_end: skip
		:: true -> 
			break
		od;
		for40_exit: skip
	fi;
	

	if
	:: tags-1 != -3 -> 
				for(i : 0.. tags-1) {
			for50: skip;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			for50_end: skip
		};
		for50_exit: skip
	:: else -> 
		do
		:: true -> 
			for501942: skip;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			for50_end1942: skip
		:: true -> 
			break
		od;
		for50_exit1942: skip
	fi;
	

	if
	:: errChan.async_send!0;
	:: errChan.sync!0 -> 
		errChan.sending?0
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


