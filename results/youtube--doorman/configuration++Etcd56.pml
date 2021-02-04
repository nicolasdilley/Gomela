#define ub_for63_0  -2
#define ub_for86_1  -2

// https://github.com/youtube/doorman/blob/e2b69e17fa85f7ccda14032ebf0daed034e2e7f7/go/configuration/configuration.go#L56
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
	Chandef req;
	Chandef updates;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 1 > 0 -> 
		updates.size = 1;
		run AsyncChan(updates)
	:: else -> 
		run sync_monitor(updates)
	fi;
	run sync_monitor(req);
	run go_Anonymous0(updates,req);
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef updates;Chandef req) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && ub_for63_0 != -2 -> 
				for(i : 0.. ub_for63_0) {
			for1022: skip;
			

			if
			:: true -> 
				

				if
				:: updates.async_send!0;
				:: updates.sync!false,0 -> 
					updates.sending?state
				fi;
				goto for10_end22
			:: true;
			fi;
			break;
			for10_end22: skip
		};
		for10_exit22: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: updates.async_send!0;
				:: updates.sync!false,0 -> 
					updates.sending?state
				fi;
				goto for10_end
			:: true;
			fi;
			break;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: req.async_rcv?0;
	:: req.sync?state,num_msgs;
	fi;
	

	if
	:: true -> 
		

		if
		:: updates.async_send!0;
		:: updates.sync!false,0 -> 
			updates.sending?state
		fi
	:: true -> 
		

		if
		:: updates.async_send!0;
		:: updates.sync!false,0 -> 
			updates.sending?state
		fi
	fi;
	

	if
	:: 0 != -2 && ub_for86_1 != -2 -> 
				for(i : 0.. ub_for86_1) {
			for2023: skip;
			

			if
			:: req.async_rcv?state,num_msgs;
			:: req.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				

				if
				:: updates.async_send!0;
				:: updates.sync!false,0 -> 
					updates.sending?state
				fi;
				goto for20_end23
			:: true;
			fi;
			

			if
			:: updates.async_send!0;
			:: updates.sync!false,0 -> 
				updates.sending?state
			fi;
			for20_end23: skip
		};
		for20_exit23: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: req.async_rcv?state,num_msgs;
			:: req.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				

				if
				:: updates.async_send!0;
				:: updates.sync!false,0 -> 
					updates.sending?state
				fi;
				goto for20_end
			:: true;
			fi;
			

			if
			:: updates.async_send!0;
			:: updates.sync!false,0 -> 
				updates.sending?state
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
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

