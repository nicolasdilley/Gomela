
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example947444294/control/plugin_manager.go
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
	Chandef resultChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	run sync_monitor(resultChan);
	run go_Anonymous0(resultChan);
	do
	:: resultChan.async_rcv?state,num_msgs -> 
		goto stop_process
	:: resultChan.sync?state,num_msgs -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od
stop_process:skip
}

proctype go_Anonymous0(Chandef resultChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int metricTypes=3;
	int lPlugin_ConfigPolicy_GetAll51129=0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: resultChan.async_send!0;
			:: resultChan.sync!false,0 -> 
				resultChan.sending?state
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: resultChan.async_send!0;
			:: resultChan.sync!false,0 -> 
				resultChan.sending?state
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: resultChan.async_send!0;
			:: resultChan.sync!false,0 -> 
				resultChan.sending?state
			fi
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: resultChan.async_send!0;
			:: resultChan.sync!false,0 -> 
				resultChan.sending?state
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: resultChan.async_send!0;
			:: resultChan.sync!false,0 -> 
				resultChan.sending?state
			fi;
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		

		if
		:: resultChan.async_send!0;
		:: resultChan.sync!false,0 -> 
			resultChan.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: resultChan.async_send!0;
		:: resultChan.sync!false,0 -> 
			resultChan.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: resultChan.async_send!0;
		:: resultChan.sync!false,0 -> 
			resultChan.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: resultChan.async_send!0;
		:: resultChan.sync!false,0 -> 
			resultChan.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: lPlugin_ConfigPolicy_GetAll51129-1 != -3 -> 
								for(i : 0.. lPlugin_ConfigPolicy_GetAll51129-1) {
					for20: skip;
					

					if
					:: true -> 
						

						if
						:: resultChan.async_send!0;
						:: resultChan.sync!false,0 -> 
							resultChan.sending?state
						fi;
						goto stop_process
					:: true;
					fi;
					for20_end: skip
				};
				for20_exit: skip
			:: else -> 
				do
				:: true -> 
					for20346: skip;
					

					if
					:: true -> 
						

						if
						:: resultChan.async_send!0;
						:: resultChan.sync!false,0 -> 
							resultChan.sending?state
						fi;
						goto stop_process
					:: true;
					fi;
					for20_end346: skip
				:: true -> 
					break
				od;
				for20_exit346: skip
			fi;
			

			if
			:: true -> 
				

				if
				:: resultChan.async_send!0;
				:: resultChan.sync!false,0 -> 
					resultChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: resultChan.async_send!0;
			:: resultChan.sync!false,0 -> 
				resultChan.sending?state
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: metricTypes-1 != -3 -> 
						for(i : 0.. metricTypes-1) {
				for30: skip;
				

				if
				:: true -> 
					

					if
					:: resultChan.async_send!0;
					:: resultChan.sync!false,0 -> 
						resultChan.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: resultChan.async_send!0;
					:: resultChan.sync!false,0 -> 
						resultChan.sending?state
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
				for30347: skip;
				

				if
				:: true -> 
					

					if
					:: resultChan.async_send!0;
					:: resultChan.sync!false,0 -> 
						resultChan.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: resultChan.async_send!0;
					:: resultChan.sync!false,0 -> 
						resultChan.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				for30_end347: skip
			:: true -> 
				break
			od;
			for30_exit347: skip
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: resultChan.async_send!0;
			:: resultChan.sync!false,0 -> 
				resultChan.sending?state
			fi;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: resultChan.async_send!0;
		:: resultChan.sync!false,0 -> 
			resultChan.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: resultChan.async_send!0;
		:: resultChan.sync!false,0 -> 
			resultChan.sending?state
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		run go_Anonymous1(resultChan)
	:: true;
	fi;
	

	if
	:: resultChan.async_send!0;
	:: resultChan.sync!false,0 -> 
		resultChan.sending?state
	fi;
	goto stop_process;
	stop_process: skip
}
proctype go_Anonymous1(Chandef resultChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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


