#define ub_for915_0  -2

// https://github.com/prometheus/prometheus/blob/b7fe028740b7b36a31c2deda1e2b74aa566fc0ee/tsdb/wal.go#L867
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
	Chandef datac;
	Chandef donec;
	int num_msgs = 0;
	bool state = false;
	int i;
	run sync_monitor(donec);
	

	if
	:: 100 > 0 -> 
		datac.size = 100;
		run AsyncChan(datac)
	:: else -> 
		run sync_monitor(datac)
	fi;
	run go_Anonymous0(donec,datac);
	

	if
	:: 0 != -2 && ub_for915_0 != -2 -> 
				for(i : 0.. ub_for915_0) {
			for20522: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: datac.async_send!0;
				:: datac.sync!false,0 -> 
					datac.sending?state
				fi
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: datac.async_send!0;
				:: datac.sync!false,0 -> 
					datac.sending?state
				fi
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: datac.async_send!0;
				:: datac.sync!false,0 -> 
					datac.sending?state
				fi
			fi;
			for20_end522: skip
		};
		for20_exit522: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: datac.async_send!0;
				:: datac.sync!false,0 -> 
					datac.sending?state
				fi
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: datac.async_send!0;
				:: datac.sync!false,0 -> 
					datac.sending?state
				fi
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: datac.async_send!0;
				:: datac.sync!false,0 -> 
					datac.sending?state
				fi
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	datac.closing!true;
	

	if
	:: donec.async_rcv?state,num_msgs;
	:: donec.sync?state,num_msgs;
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
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef donec;Chandef datac) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: datac.async_rcv?state,num_msgs;
		:: datac.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for10: skip;
			

			if
			:: true;
			:: true;
			:: true;
			:: true;
			fi;
			for10_end: skip
		fi
	od;
	for10_exit: skip;
	stop_process: skip;
	donec.closing!true
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

