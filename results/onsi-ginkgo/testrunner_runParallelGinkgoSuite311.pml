#define runParallelGinkgoSuite_t_numCPU  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example714288950/ginkgo/testrunner/test_runner.go
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
	chan child_NewAggregator0 = [0] of {int};
	Chandef completions;
	Chandef result;
	int num_msgs = 0;
	bool state = false;
	int i;
	int t_numCPU = runParallelGinkgoSuite_t_numCPU;
	run sync_monitor(result);
	run sync_monitor(completions);
	run NewAggregator(result,child_NewAggregator0);
	child_NewAggregator0?0;
		for(i : 0.. t_numCPU-1) {
		for10: skip;
		run go_run(completions);
		for10_end: skip
	};
	for10_exit: skip;
	do
	:: result.async_rcv?state,num_msgs -> 
		break
	:: result.sync?state,num_msgs -> 
		break
	:: true -> 
		break
	od;
	goto stop_process
stop_process:skip
}

proctype NewAggregator(Chandef result;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef aggregator_suiteEndings;
	Chandef aggregator_specCompletions;
	Chandef aggregator_afterSuites;
	Chandef aggregator_beforeSuites;
	Chandef aggregator_suiteBeginnings;
	run sync_monitor(aggregator_suiteBeginnings);
	run sync_monitor(aggregator_beforeSuites);
	run sync_monitor(aggregator_afterSuites);
	run sync_monitor(aggregator_specCompletions);
	run sync_monitor(aggregator_suiteEndings);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype go_run(Chandef completions) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	

	if
	:: true -> 
		

		if
		:: completions.async_send!0;
		:: completions.sync!false,0 -> 
			completions.sending?state
		fi
	:: true;
	fi
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

