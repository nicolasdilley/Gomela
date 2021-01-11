#define ub_for165_2  -2
#define ub_for190_3  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example474308639/apiserver/apiserver.go
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
	Chandef workerDoneCh;
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
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
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
		run sync_monitor(errCh);
		run sync_monitor(workerDoneCh);
		run go_replyStreamWorker(errCh,workerDoneCh);
		

		if
		:: true -> 
			

			if
			:: 0 != -2 && ub_for165_2 != -2 -> 
								for(i : 0.. ub_for165_2) {
					for302237: skip;
					

					if
					:: true -> 
						

						if
						:: true -> 
							

							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							

							if
							:: workerDoneCh.async_rcv?0;
							:: workerDoneCh.sync?0;
							fi;
							goto stop_process
						:: true -> 
							

							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							

							if
							:: workerDoneCh.async_rcv?0;
							:: workerDoneCh.sync?0;
							fi;
							goto stop_process
						fi
					:: true;
					fi;
					

					if
					:: true -> 
						

						if
						:: true -> 
							

							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							

							if
							:: workerDoneCh.async_rcv?0;
							:: workerDoneCh.sync?0;
							fi;
							goto stop_process
						:: true;
						fi
					:: true;
					fi;
					for30_end2237: skip
				};
				for30_exit2237: skip
			:: else -> 
				do
				:: true -> 
					for30: skip;
					

					if
					:: true -> 
						

						if
						:: true -> 
							

							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							

							if
							:: workerDoneCh.async_rcv?0;
							:: workerDoneCh.sync?0;
							fi;
							goto stop_process
						:: true -> 
							

							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							

							if
							:: workerDoneCh.async_rcv?0;
							:: workerDoneCh.sync?0;
							fi;
							goto stop_process
						fi
					:: true;
					fi;
					

					if
					:: true -> 
						

						if
						:: true -> 
							

							if
							:: errCh.async_send!0;
							:: errCh.sync!0 -> 
								errCh.sending?0
							fi;
							

							if
							:: workerDoneCh.async_rcv?0;
							:: workerDoneCh.sync?0;
							fi;
							goto stop_process
						:: true;
						fi
					:: true;
					fi;
					for30_end: skip
				:: true -> 
					break
				od;
				for30_exit: skip
			fi
		:: true -> 
			

			if
			:: 0 != -2 && ub_for190_3 != -2 -> 
								for(i : 0.. ub_for190_3) {
					for402238: skip;
					

					if
					:: true -> 
						

						if
						:: errCh.async_send!0;
						:: errCh.sync!0 -> 
							errCh.sending?0
						fi;
						

						if
						:: workerDoneCh.async_rcv?0;
						:: workerDoneCh.sync?0;
						fi;
						goto stop_process
					:: true;
					fi;
					for40_end2238: skip
				};
				for40_exit2238: skip
			:: else -> 
				do
				:: true -> 
					for40: skip;
					

					if
					:: true -> 
						

						if
						:: errCh.async_send!0;
						:: errCh.sync!0 -> 
							errCh.sending?0
						fi;
						

						if
						:: workerDoneCh.async_rcv?0;
						:: workerDoneCh.sync?0;
						fi;
						goto stop_process
					:: true;
					fi;
					for40_end: skip
				:: true -> 
					break
				od;
				for40_exit: skip
			fi
		:: true -> 
			

			if
			:: 0 != -2 && ub_for190_3 != -2 -> 
								for(i : 0.. ub_for190_3) {
					for402238: skip;
					

					if
					:: true -> 
						

						if
						:: errCh.async_send!0;
						:: errCh.sync!0 -> 
							errCh.sending?0
						fi;
						

						if
						:: workerDoneCh.async_rcv?0;
						:: workerDoneCh.sync?0;
						fi;
						goto stop_process
					:: true;
					fi;
					for40_end2238: skip
				};
				for40_exit2238: skip
			:: else -> 
				do
				:: true -> 
					for40: skip;
					

					if
					:: true -> 
						

						if
						:: errCh.async_send!0;
						:: errCh.sync!0 -> 
							errCh.sending?0
						fi;
						

						if
						:: workerDoneCh.async_rcv?0;
						:: workerDoneCh.sync?0;
						fi;
						goto stop_process
					:: true;
					fi;
					for40_end: skip
				:: true -> 
					break
				od;
				for40_exit: skip
			fi
		fi;
		

		if
		:: true -> 
			

			if
			:: errCh.async_send!0;
			:: errCh.sync!0 -> 
				errCh.sending?0
			fi;
			

			if
			:: workerDoneCh.async_rcv?0;
			:: workerDoneCh.sync?0;
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: errCh.async_send!0;
		:: errCh.sync!0 -> 
			errCh.sending?0
		fi;
		

		if
		:: workerDoneCh.async_rcv?0;
		:: workerDoneCh.sync?0;
		fi
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			fi
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			fi
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi
stop_process:skip
}

proctype go_replyStreamWorker(Chandef errCh;Chandef workerDoneCh) {
	bool closed; 
	int i;
	bool state;
	Chandef receiveErrCh;
	Chandef receiveCh;
	run sync_monitor(receiveCh);
	run sync_monitor(receiveErrCh);
	run go_streamReceiveWorker(receiveCh,receiveErrCh);
	do
	:: true -> 
		for20: skip;
		do
		:: receiveCh.async_rcv?0 -> 
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi;
			break
		:: receiveCh.sync?0 -> 
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi;
			break
		:: receiveErrCh.async_rcv?0 -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: receiveErrCh.sync?0 -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: errCh.async_rcv?0 -> 
			goto stop_process
		:: errCh.sync?0 -> 
			goto stop_process
		od;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip;
	workerDoneCh.closing!true
}
proctype go_streamReceiveWorker(Chandef receiveCh;Chandef receiveErrCh) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: receiveErrCh.async_send!0;
			:: receiveErrCh.sync!0 -> 
				receiveErrCh.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: receiveCh.async_send!0;
		:: receiveCh.sync!0 -> 
			receiveCh.sending?0
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
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

