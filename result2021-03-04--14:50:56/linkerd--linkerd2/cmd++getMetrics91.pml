#define pods91  3

// https://github.com/linkerd/linkerd2/blob/c416e7826125b94a4c047bf21a63b49130a7b14e/cli/cmd/metrics_diagnostics_util.go#L91
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
	run go_getMetrics(pods91)
stop_process:skip
}

proctype go_getMetrics(int pods) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef resultChan;
	run sync_monitor(resultChan);
		for(i : 0.. pods-1) {
		for10: skip;
		run go_Anonymous1(resultChan);
		for10_end: skip
	};
	for10_exit: skip;
	do
	:: true -> 
		for20: skip;
		do
		:: resultChan.async_rcv?state,num_msgs -> 
			break
		:: resultChan.sync?state,num_msgs -> 
			break
		:: true -> 
			goto for20_exit
		od;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		for20_end: skip
	od;
	for20_exit: skip;
	goto stop_process;
	stop_process: skip
}
proctype go_Anonymous1(Chandef resultChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int containers=1;
	

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
	:: containers-1 != -3 -> 
				for(i : 0.. containers-1) {
			for11: skip;
			

			if
			:: resultChan.async_send!0;
			:: resultChan.sync!false,0 -> 
				resultChan.sending?state
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for12: skip;
			

			if
			:: resultChan.async_send!0;
			:: resultChan.sync!false,0 -> 
				resultChan.sending?state
			fi;
			for12_end: skip
		:: true -> 
			break
		od;
		for12_exit: skip
	fi;
	stop_process: skip;
	
}
proctype go_Anonymous2(Chandef resultChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int containers=3;
	

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
	:: containers-1 != -3 -> 
				for(i : 0.. containers-1) {
			for14: skip;
			

			if
			:: resultChan.async_send!0;
			:: resultChan.sync!false,0 -> 
				resultChan.sending?state
			fi;
			for14_end: skip
		};
		for14_exit: skip
	:: else -> 
		do
		:: true -> 
			for15: skip;
			

			if
			:: resultChan.async_send!0;
			:: resultChan.sync!false,0 -> 
				resultChan.sending?state
			fi;
			for15_end: skip
		:: true -> 
			break
		od;
		for15_exit: skip
	fi;
	stop_process: skip;
	
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


