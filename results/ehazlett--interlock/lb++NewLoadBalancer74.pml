
// https://github.com/ehazlett/interlock/blob/275b8dcc68ad7d3792364aca23c0dd40f744f7fc/ext/lb/lb.go#L74
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
	Chandef proxyNetworkCleanupChan;
	Chandef lbUpdateChan;
	Chandef errChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	run sync_monitor(errChan);
	run go_Anonymous0(errChan);
	run sync_monitor(lbUpdateChan);
	run sync_monitor(proxyNetworkCleanupChan);
	

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
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		goto stop_process
	fi;
	run go_Anonymous1(errChan,lbUpdateChan,proxyNetworkCleanupChan);
	run go_Anonymous2(errChan,lbUpdateChan,proxyNetworkCleanupChan);
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef errChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: errChan.async_rcv?state,num_msgs;
		:: errChan.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for10: skip;
			for10_end: skip
		fi
	od;
	for10_exit: skip;
	stop_process: skip
}
proctype go_Anonymous1(Chandef errChan;Chandef lbUpdateChan;Chandef proxyNetworkCleanupChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for20: skip;
		

		if
		:: proxyNetworkCleanupChan.async_rcv?state,num_msgs;
		:: proxyNetworkCleanupChan.sync?state,num_msgs;
		fi;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip
}
proctype go_Anonymous2(Chandef errChan;Chandef lbUpdateChan;Chandef proxyNetworkCleanupChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: lbUpdateChan.async_rcv?state,num_msgs;
		:: lbUpdateChan.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for30: skip;
			

			if
			:: true -> 
				goto for30_end
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto for30_end
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto for30_end
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto for30_end
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto for30_end
			:: true;
			fi;
			

			if
			:: true;
			:: true;
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto for30_end
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto for30_end
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto for30_end
			:: true;
			fi;
			for30_end: skip
		fi
	od;
	for30_exit: skip;
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

