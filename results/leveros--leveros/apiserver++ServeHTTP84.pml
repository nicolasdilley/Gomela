#define ub_for165_2  -2
#define ub_for190_3  -2

// https://github.com/leveros/leveros/blob/ba032c212896a455baee282babb4c99699918b31/apiserver/apiserver.go#L84
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
	Chandef workerDoneCh;
	Chandef errCh;
	int num_msgs = 0;
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
					for30710: skip;
					

					if
					:: true -> 
						

						if
						:: true -> 
							

							if
							:: errCh.async_send!0;
							:: errCh.sync!false,0 -> 
								errCh.sending?state
							fi;
							

							if
							:: workerDoneCh.async_rcv?state,num_msgs;
							:: workerDoneCh.sync?state,num_msgs;
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
							:: errCh.sync!false,0 -> 
								errCh.sending?state
							fi;
							

							if
							:: workerDoneCh.async_rcv?state,num_msgs;
							:: workerDoneCh.sync?state,num_msgs;
							fi;
							goto stop_process
						:: true;
						fi
					:: true;
					fi;
					for30_end710: skip
				};
				for30_exit710: skip
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
							:: errCh.sync!false,0 -> 
								errCh.sending?state
							fi;
							

							if
							:: workerDoneCh.async_rcv?state,num_msgs;
							:: workerDoneCh.sync?state,num_msgs;
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
							:: errCh.sync!false,0 -> 
								errCh.sending?state
							fi;
							

							if
							:: workerDoneCh.async_rcv?state,num_msgs;
							:: workerDoneCh.sync?state,num_msgs;
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
					for40711: skip;
					

					if
					:: true -> 
						

						if
						:: errCh.async_send!0;
						:: errCh.sync!false,0 -> 
							errCh.sending?state
						fi;
						

						if
						:: workerDoneCh.async_rcv?state,num_msgs;
						:: workerDoneCh.sync?state,num_msgs;
						fi;
						goto stop_process
					:: true;
					fi;
					for40_end711: skip
				};
				for40_exit711: skip
			:: else -> 
				do
				:: true -> 
					for40: skip;
					

					if
					:: true -> 
						

						if
						:: errCh.async_send!0;
						:: errCh.sync!false,0 -> 
							errCh.sending?state
						fi;
						

						if
						:: workerDoneCh.async_rcv?state,num_msgs;
						:: workerDoneCh.sync?state,num_msgs;
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
			:: errCh.sync!false,0 -> 
				errCh.sending?state
			fi;
			

			if
			:: workerDoneCh.async_rcv?state,num_msgs;
			:: workerDoneCh.sync?state,num_msgs;
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: errCh.async_send!0;
		:: errCh.sync!false,0 -> 
			errCh.sending?state
		fi;
		

		if
		:: workerDoneCh.async_rcv?state,num_msgs;
		:: workerDoneCh.sync?state,num_msgs;
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
				goto stop_process
			:: true;
			fi
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
	int num_msgs;
	Chandef receiveErrCh;
	Chandef receiveCh;
	run sync_monitor(receiveCh);
	run sync_monitor(receiveErrCh);
	run go_streamReceiveWorker(receiveCh,receiveErrCh);
	do
	:: true -> 
		for20: skip;
		do
		:: receiveCh.async_rcv?state,num_msgs -> 
			

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
			fi;
			break
		:: receiveCh.sync?state,num_msgs -> 
			

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
			fi;
			break
		:: receiveErrCh.async_rcv?state,num_msgs -> 
			

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
				fi
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: receiveErrCh.sync?state,num_msgs -> 
			

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
				fi
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: errCh.async_rcv?state,num_msgs -> 
			goto stop_process
		:: errCh.sync?state,num_msgs -> 
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
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: receiveErrCh.async_send!0;
			:: receiveErrCh.sync!false,0 -> 
				receiveErrCh.sending?state
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: receiveCh.async_send!0;
		:: receiveCh.sync!false,0 -> 
			receiveCh.sending?state
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
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

