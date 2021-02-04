#define resolveParallelHarness_input  0

// https://github.com/tenta-browser/tenta-dns/blob/8a8ab0bbeb86f54d3a26606118d06ca03e49dfdd/responder/recursive_dns_resolver.go#L251
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
	Chandef achan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int input = resolveParallelHarness_input;
	

	if
	:: true -> 
		goto stop_process
	fi;
	

	if
	:: input > 0 -> 
		achan.size = input;
		run AsyncChan(achan)
	:: else -> 
		run sync_monitor(achan)
	fi;
		for(i : 0.. input-1) {
		for30: skip;
		run go_Anonymous0(achan);
		for30_end: skip
	};
	for30_exit: skip;
	do
	:: true -> 
		for40: skip;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		do
		:: achan.async_rcv?state,num_msgs -> 
			break
		:: achan.sync?state,num_msgs -> 
			break
		:: true -> 
			goto for40_exit
		od;
		for40_end: skip
	od;
	for40_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef achan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: achan.async_send!0;
	:: achan.sync!false,0 -> 
		achan.sending?state
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

