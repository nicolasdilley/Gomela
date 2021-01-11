#define runAnalyzers_all  3

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
	chan child_runnergenericHandle0 = [0] of {int};
	Chandef queue;
	bool state = false;
	int i;
	int all = runAnalyzers_all;
	

	if
	:: all > 0 -> 
		queue.size = all;
		run AsyncChan(queue)
	:: else -> 
		run sync_monitor(queue)
	fi;
	

	if
	:: all-1 != -3 -> 
				for(i : 0.. all-1) {
			for30: skip;
			

			if
			:: true -> 
				

				if
				:: queue.async_send!0;
				:: queue.sync!0 -> 
					queue.sending?0
				fi
			:: true;
			fi;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for301517: skip;
			

			if
			:: true -> 
				

				if
				:: queue.async_send!0;
				:: queue.sync!0 -> 
					queue.sending?0
				fi
			:: true;
			fi;
			for30_end1517: skip
		:: true -> 
			break
		od;
		for30_exit1517: skip
	fi;
	

	if
	:: true -> 
		queue.closing!true
	:: true;
	fi;
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
			for40: skip;
			

			if
			:: true -> 
				run go_genericHandle(queue)
			:: true -> 
				run runnergenericHandle(queue,child_runnergenericHandle0);
				child_runnergenericHandle0?0
			:: true -> 
				run runnergenericHandle(queue,child_runnergenericHandle0);
				child_runnergenericHandle0?0
			fi;
			for40_end: skip
		fi
	od;
	for40_exit: skip;
	goto stop_process
stop_process:skip
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
			for42: skip;
			

			if
			:: true -> 
				

				if
				:: queue.async_send!0;
				:: queue.sync!0 -> 
					queue.sending?0
				fi
			:: true;
			fi;
			for42_end: skip
		};
		for42_exit: skip
	:: else -> 
		do
		:: true -> 
			for421518: skip;
			

			if
			:: true -> 
				

				if
				:: queue.async_send!0;
				:: queue.sync!0 -> 
					queue.sending?0
				fi
			:: true;
			fi;
			for42_end1518: skip
		:: true -> 
			break
		od;
		for42_exit1518: skip
	fi;
	stop_process: skip
}
proctype runnergenericHandle(Chandef queue;chan child) {
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
			for44: skip;
			

			if
			:: true -> 
				

				if
				:: queue.async_send!0;
				:: queue.sync!0 -> 
					queue.sending?0
				fi
			:: true;
			fi;
			for44_end: skip
		};
		for44_exit: skip
	:: else -> 
		do
		:: true -> 
			for441519: skip;
			

			if
			:: true -> 
				

				if
				:: queue.async_send!0;
				:: queue.sync!0 -> 
					queue.sending?0
				fi
			:: true;
			fi;
			for44_end1519: skip
		:: true -> 
			break
		od;
		for44_exit1519: skip
	fi;
	stop_process: skip;
	child!0
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


