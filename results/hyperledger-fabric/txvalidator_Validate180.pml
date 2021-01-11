
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example852762459/core/committer/txvalidator/v20/validator.go
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
	Chandef results;
	bool state = false;
	int i;
	int block_Data_Data = -2;
	run sync_monitor(results);
	run go_Anonymous0(results,block_Data_Data);
	

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

proctype go_Anonymous0(Chandef results;int block_Data_Data) {
	bool closed; 
	int i;
	bool state;
		for(i : 0.. block_Data_Data-1) {
		for10: skip;
		run go_Anonymous1(results);
		for10_end: skip
	};
	for10_exit: skip;
	stop_process: skip
}
proctype go_Anonymous1(Chandef results) {
	bool closed; 
	int i;
	bool state;
	chan child_validateTx0 = [0] of {int};
	run validateTx(results,child_validateTx0);
	child_validateTx0?0;
	stop_process: skip
}
proctype validateTx(Chandef results;chan child) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: results.async_send!0;
		:: results.sync!0 -> 
			results.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: results.async_send!0;
		:: results.sync!0 -> 
			results.sending?0
		fi;
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: results.async_send!0;
				:: results.sync!0 -> 
					results.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: results.async_send!0;
				:: results.sync!0 -> 
					results.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: results.async_send!0;
				:: results.sync!0 -> 
					results.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: results.async_send!0;
					:: results.sync!0 -> 
						results.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						

						if
						:: results.async_send!0;
						:: results.sync!0 -> 
							results.sending?0
						fi;
						goto stop_process
					:: true;
					fi;
					

					if
					:: true -> 
						

						if
						:: results.async_send!0;
						:: results.sync!0 -> 
							results.sending?0
						fi;
						goto stop_process
					:: true;
					fi
				:: true -> 
					

					if
					:: results.async_send!0;
					:: results.sync!0 -> 
						results.sending?0
					fi;
					goto stop_process
				:: true -> 
					

					if
					:: results.async_send!0;
					:: results.sync!0 -> 
						results.sending?0
					fi;
					goto stop_process
				fi
			fi;
			

			if
			:: true -> 
				

				if
				:: results.async_send!0;
				:: results.sync!0 -> 
					results.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: results.async_send!0;
			:: results.sync!0 -> 
				results.sending?0
			fi;
			goto stop_process
		:: true -> 
			

			if
			:: results.async_send!0;
			:: results.sync!0 -> 
				results.sending?0
			fi;
			goto stop_process
		:: true -> 
			

			if
			:: results.async_send!0;
			:: results.sync!0 -> 
				results.sending?0
			fi;
			goto stop_process
		fi
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

