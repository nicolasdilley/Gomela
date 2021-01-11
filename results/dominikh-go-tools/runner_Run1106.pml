
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example335729286/lintcmd/runner/runner.go
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
	Chandef queue;
	bool state = false;
	int i;
	int all=3;
	

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
	run sync_monitor(queue);
	run go_Anonymous0(queue,all);
	do
	:: queue.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: queue.async_rcv?0;
			:: queue.sync?0;
			fi;
			for50: skip;
			run go_genericHandle(queue);
			for50_end: skip
		fi
	od;
	for50_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef queue;int all) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: all-1 != -3 -> 
				for(i : 0.. all-1) {
			for40: skip;
			

			if
			:: true -> 
				

				if
				:: queue.async_send!0;
				:: queue.sync!0 -> 
					queue.sending?0
				fi
			:: true;
			fi;
			for40_end: skip
		};
		for40_exit: skip
	:: else -> 
		do
		:: true -> 
			for401520: skip;
			

			if
			:: true -> 
				

				if
				:: queue.async_send!0;
				:: queue.sync!0 -> 
					queue.sending?0
				fi
			:: true;
			fi;
			for40_end1520: skip
		:: true -> 
			break
		od;
		for40_exit1520: skip
	fi;
	stop_process: skip
}
proctype go_genericHandle(Chandef queue) {
	bool closed; 
	int i;
	bool state;
	int a_Triggers77220=3;
	

	if
	:: true -> 
		queue.closing!true;
		goto stop_process
	:: true;
	fi;
	

	if
	:: a_Triggers77220-1 != -3 -> 
				for(i : 0.. a_Triggers77220-1) {
			for52: skip;
			

			if
			:: true -> 
				

				if
				:: queue.async_send!0;
				:: queue.sync!0 -> 
					queue.sending?0
				fi
			:: true;
			fi;
			for52_end: skip
		};
		for52_exit: skip
	:: else -> 
		do
		:: true -> 
			for521521: skip;
			

			if
			:: true -> 
				

				if
				:: queue.async_send!0;
				:: queue.sync!0 -> 
					queue.sending?0
				fi
			:: true;
			fi;
			for52_end1521: skip
		:: true -> 
			break
		od;
		for52_exit1521: skip
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


