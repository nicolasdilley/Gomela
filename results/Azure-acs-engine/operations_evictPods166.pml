#define evictPods_pods  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example151688771/pkg/operations/cordondrainvm.go
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
	Chandef errCh;
	Chandef doneCh;
	bool state = false;
	int i;
	int pods = evictPods_pods;
	

	if
	:: pods > 0 -> 
		doneCh.size = pods;
		run AsyncChan(doneCh)
	:: else -> 
		run sync_monitor(doneCh)
	fi;
	

	if
	:: 1 > 0 -> 
		errCh.size = 1;
		run AsyncChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
		for(i : 0.. pods-1) {
		for10: skip;
		run go_Anonymous0(doneCh,errCh);
		for10_end: skip
	};
	for10_exit: skip;
	do
	:: true -> 
		for20: skip;
		do
		:: errCh.async_rcv?0 -> 
			goto stop_process
		:: errCh.sync?0 -> 
			goto stop_process
		:: doneCh.async_rcv?0 -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: doneCh.sync?0 -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: true -> 
			goto stop_process
		od;
		for20_end: skip
	od;
	for20_exit: skip
stop_process:skip
}

proctype go_Anonymous0(Chandef doneCh;Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for11: skip;
		

		if
		:: true -> 
			break
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: doneCh.async_send!0;
				:: doneCh.sync!0 -> 
					doneCh.sending?0
				fi;
				goto stop_process
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: errCh.async_send!0;
					:: errCh.sync!0 -> 
						errCh.sending?0
					fi;
					goto stop_process
				:: true -> 
					

					if
					:: errCh.async_send!0;
					:: errCh.sync!0 -> 
						errCh.sending?0
					fi;
					goto stop_process
				fi
			fi
		fi;
		for11_end: skip
	od;
	for11_exit: skip;
	

	if
	:: true -> 
		

		if
		:: doneCh.async_send!0;
		:: doneCh.sync!0 -> 
			doneCh.sending?0
		fi
	:: true -> 
		

		if
		:: errCh.async_send!0;
		:: errCh.sync!0 -> 
			errCh.sending?0
		fi
	:: true -> 
		

		if
		:: errCh.async_send!0;
		:: errCh.sync!0 -> 
			errCh.sending?0
		fi
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

