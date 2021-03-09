#define NewRound_servers  0

// https://github.com/vuvuzela/vuvuzela/blob/55ba49f81ad006877ae6b4d76c0958a3ee956441/mixnet/mixnet.go#L745
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
	Chandef errs;
	int num_msgs = 0;
	bool state = false;
	int i;
	int servers = NewRound_servers;
	

	if
	:: 1 > 0 -> 
		errs.size = 1;
		run AsyncChan(errs)
	:: else -> 
		run sync_monitor(errs)
	fi;
		for(i : 0.. servers-1) {
		for30: skip;
		run go_Anonymous0(errs);
		for30_end: skip
	};
	for30_exit: skip;
	

	if
	:: 0 != -2 && servers-1 != -3 -> 
				for(i : 0.. servers-1) {
			for40484: skip;
			

			if
			:: errs.async_rcv?state,num_msgs;
			:: errs.sync?state,num_msgs;
			fi;
			for40_end484: skip
		};
		for40_exit484: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			

			if
			:: errs.async_rcv?state,num_msgs;
			:: errs.sync?state,num_msgs;
			fi;
			for40_end: skip
		:: true -> 
			break
		od;
		for40_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. servers-1) {
		for50: skip;
		run go_Anonymous1(errs);
		for50_end: skip
	};
	for50_exit: skip;
	

	if
	:: 0 != -2 && servers-1 != -3 -> 
				for(i : 0.. servers-1) {
			for60485: skip;
			

			if
			:: errs.async_rcv?state,num_msgs;
			:: errs.sync?state,num_msgs;
			fi;
			for60_end485: skip
		};
		for60_exit485: skip
	:: else -> 
		do
		:: true -> 
			for60: skip;
			

			if
			:: errs.async_rcv?state,num_msgs;
			:: errs.sync?state,num_msgs;
			fi;
			for60_end: skip
		:: true -> 
			break
		od;
		for60_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef errs) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errs.async_send!0;
		:: errs.sync!false,0 -> 
			errs.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: errs.async_send!0;
	:: errs.sync!false,0 -> 
		errs.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef errs) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errs.async_send!0;
		:: errs.sync!false,0 -> 
			errs.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: errs.async_send!0;
	:: errs.sync!false,0 -> 
		errs.sending?state
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

