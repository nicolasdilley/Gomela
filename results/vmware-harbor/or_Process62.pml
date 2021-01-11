#define Process_p_evaluators  0
#define not_found_162  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example335058053/src/pkg/retention/policy/alg/or/processor.go
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
	Chandef done;
	Chandef errChan;
	Chandef resChan;
	bool state = false;
	int i;
	int p_evaluators = Process_p_evaluators;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 1 > 0 -> 
		resChan.size = 1;
		run AsyncChan(resChan)
	:: else -> 
		run sync_monitor(resChan)
	fi;
	

	if
	:: 1 > 0 -> 
		errChan.size = 1;
		run AsyncChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	

	if
	:: 1 > 0 -> 
		done.size = 1;
		run AsyncChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	run go_Anonymous0(resChan,errChan,done);
		for(i : 0.. p_evaluators-1) {
		for20: skip;
		run go_Anonymous1(resChan,errChan,done,not_found_162);
		for20_end: skip
	};
	for20_exit: skip;
	resChan.closing!true;
	

	if
	:: done.async_rcv?0;
	:: done.sync?0;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef resChan;Chandef errChan;Chandef done) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for10: skip;
		do
		:: resChan.async_rcv?0 -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: resChan.sync?0 -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: errChan.async_rcv?0 -> 
			break
		:: errChan.sync?0 -> 
			break
		od;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
	

	if
	:: done.async_send!0;
	:: done.sync!0 -> 
		done.sending?0
	fi
}
proctype go_Anonymous1(Chandef resChan;Chandef errChan;Chandef done;int selectors) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: selectors-1 != -3 -> 
						for(i : 0.. selectors-1) {
				for21: skip;
				

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
				for21_end: skip
			};
			for21_exit: skip
		:: else -> 
			do
			:: true -> 
				for21655: skip;
				

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
				for21_end655: skip
			:: true -> 
				break
			od;
			for21_exit655: skip
		fi
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
	:: resChan.async_send!0;
	:: resChan.sync!0 -> 
		resChan.sending?0
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

