#define not_found_80  -2
#define ub_for59_0  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example328969469/test/e2e_node/services/apiserver.go
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
	chan child_servicesreadinessCheck0 = [0] of {int};
	Chandef errCh;
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
	run sync_monitor(errCh);
	run go_Anonymous0(errCh);
	run servicesreadinessCheck(errCh,not_found_80,child_servicesreadinessCheck0);
	child_servicesreadinessCheck0?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: errCh.async_send!0;
		:: errCh.sync!0 -> 
			errCh.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: errCh.async_send!0;
		:: errCh.sync!0 -> 
			errCh.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	errCh.closing!true
}
proctype servicesreadinessCheck(Chandef errCh;int urls;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef blockCh;
	run sync_monitor(blockCh);
	

	if
	:: 0 != -2 && ub_for59_0 != -2 -> 
				for(i : 0.. ub_for59_0) {
			for102334: skip;
			do
			:: errCh.async_rcv?0 -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				fi;
				break
			:: errCh.sync?0 -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				fi;
				break
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			od;
			for10_end2334: skip
		};
		for10_exit2334: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			do
			:: errCh.async_rcv?0 -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				fi;
				break
			:: errCh.sync?0 -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				fi;
				break
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			od;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	blockCh.closing!true;
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

