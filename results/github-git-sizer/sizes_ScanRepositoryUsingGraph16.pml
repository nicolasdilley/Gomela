
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example815397642/sizes/graph.go
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
	Chandef errChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int tags = -2;
	int commits = -2;
	int trees = -2;
	

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
	:: errChan.async_rcv?state,num_msgs;
	:: errChan.sync?state,num_msgs;
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
	run go_Anonymous1(errChan,trees,commits,tags);
	

	if
	:: errChan.async_rcv?state,num_msgs;
	:: errChan.sync?state,num_msgs;
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
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef errChan) {
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
			:: errChan.async_send!0;
			:: errChan.sync!false,0 -> 
				errChan.sending?state
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
			:: errChan.sync!false,0 -> 
				errChan.sending?state
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: errChan.async_send!0;
			:: errChan.sync!false,0 -> 
				errChan.sending?state
			fi;
			goto stop_process
		:: true;
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	

	if
	:: errChan.async_send!0;
	:: errChan.sync!false,0 -> 
		errChan.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef errChan;int trees;int commits;int tags) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: trees-1 != -3 -> 
				for(i : 0.. trees-1) {
			for30: skip;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
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
			for301194: skip;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			for30_end1194: skip
		:: true -> 
			break
		od;
		for30_exit1194: skip
	fi;
	

	if
	:: 0 != -2 && commits-1 != -3 -> 
				for(i : 0.. commits-1) {
			for401195: skip;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			for40_end1195: skip
		};
		for40_exit1195: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
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
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
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
			for501196: skip;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			for50_end1196: skip
		:: true -> 
			break
		od;
		for50_exit1196: skip
	fi;
	

	if
	:: errChan.async_send!0;
	:: errChan.sync!false,0 -> 
		errChan.sending?state
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
