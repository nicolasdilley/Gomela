#define executeBulkSetRowAttrs_nodes  3

// https://github.com/pilosa/pilosa/blob/d960d2fda97521711a6b7d2542a8bd1a41112378/executor.go#L2267
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
	Chandef resp;
	int num_msgs = 0;
	bool state = false;
	int i;
	int nodes = executeBulkSetRowAttrs_nodes;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: nodes > 0 -> 
		resp.size = nodes;
		run AsyncChan(resp)
	:: else -> 
		run sync_monitor(resp)
	fi;
		for(i : 0.. nodes-1) {
		for30: skip;
		run go_Anonymous0(resp);
		for30_end: skip
	};
	for30_exit: skip;
	

	if
	:: nodes-1 != -3 -> 
				for(i : 0.. nodes-1) {
			for40: skip;
			

			if
			:: resp.async_rcv?state,num_msgs;
			:: resp.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for40_end: skip
		};
		for40_exit: skip
	:: else -> 
		do
		:: true -> 
			for40796: skip;
			

			if
			:: resp.async_rcv?state,num_msgs;
			:: resp.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for40_end796: skip
		:: true -> 
			break
		od;
		for40_exit796: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef resp) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: resp.async_send!0;
	:: resp.sync!false,0 -> 
		resp.sending?state
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

