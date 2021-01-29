#define checkPodsCondition_podNames  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example122051410/test/e2e/framework/pod/resource.go
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
	Chandef result;
	int num_msgs = 0;
	bool state = false;
	int i;
	int podNames = checkPodsCondition_podNames;
	

	if
	:: podNames > 0 -> 
		result.size = podNames;
		run AsyncChan(result)
	:: else -> 
		run sync_monitor(result)
	fi;
		for(i : 0.. podNames-1) {
		for10: skip;
		run go_Anonymous0(result);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: podNames-1 != -3 -> 
				for(i : 0.. podNames-1) {
			for20: skip;
			

			if
			:: result.async_rcv?state,num_msgs;
			:: result.sync?state,num_msgs;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20818: skip;
			

			if
			:: result.async_rcv?state,num_msgs;
			:: result.sync?state,num_msgs;
			fi;
			for20_end818: skip
		:: true -> 
			break
		od;
		for20_exit818: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef result) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: result.async_send!0;
	:: result.sync!false,0 -> 
		result.sending?state
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

