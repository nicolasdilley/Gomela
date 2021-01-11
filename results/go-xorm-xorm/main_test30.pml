#define test_size  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example186247943/examples/maxconnect.go
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
	int size = test_size;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: size > 0 -> 
		queue.size = size;
		run AsyncChan(queue)
	:: else -> 
		run sync_monitor(queue)
	fi;
		for(i : 0.. size-1) {
		for10: skip;
		run go_Anonymous0(queue);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && size-1 != -3 -> 
				for(i : 0.. size-1) {
			for20888: skip;
			

			if
			:: queue.async_rcv?0;
			:: queue.sync?0;
			fi;
			for20_end888: skip
		};
		for20_exit888: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: queue.async_rcv?0;
			:: queue.sync?0;
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi
stop_process:skip
}

proctype go_Anonymous0(Chandef queue) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: 0 != -2 && 10-1 != -3 -> 
						for(i : 0.. 10-1) {
				for11887: skip;
				

				if
				:: true -> 
					

					if
					:: queue.async_send!0;
					:: queue.sync!0 -> 
						queue.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				for11_end887: skip
			};
			for11_exit887: skip
		:: else -> 
			do
			:: true -> 
				for11: skip;
				

				if
				:: true -> 
					

					if
					:: queue.async_send!0;
					:: queue.sync!0 -> 
						queue.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				for11_end: skip
			:: true -> 
				break
			od;
			for11_exit: skip
		fi
	:: true -> 
		

		if
		:: 0 != -2 && 10-1 != -3 -> 
						for(i : 0.. 10-1) {
				for11887: skip;
				

				if
				:: true -> 
					

					if
					:: queue.async_send!0;
					:: queue.sync!0 -> 
						queue.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				for11_end887: skip
			};
			for11_exit887: skip
		:: else -> 
			do
			:: true -> 
				for11: skip;
				

				if
				:: true -> 
					

					if
					:: queue.async_send!0;
					:: queue.sync!0 -> 
						queue.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				for11_end: skip
			:: true -> 
				break
			od;
			for11_exit: skip
		fi
	fi;
	

	if
	:: queue.async_send!0;
	:: queue.sync!0 -> 
		queue.sending?0
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

