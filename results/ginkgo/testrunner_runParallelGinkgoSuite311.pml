#define runParallelGinkgoSuite_t_numCPU  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example739026736/ginkgo/testrunner/test_runner.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef result;
	int writers = -2;
	chan child_NewAggregator0 = [0] of {int};
	int i;
	Chandef completions;
	int t_numCPU = runParallelGinkgoSuite_t_numCPU;
	int reports = -2;
	bool state = false;
	run sync_monitor(result);
	run sync_monitor(completions);
	run NewAggregator(result,child_NewAggregator0);
	child_NewAggregator0?0;
for10_exit:	
	if
	:: 0 != -2 && t_numCPU-1 != -3 -> 
				for(i : 0.. t_numCPU-1) {
for20:			
			if
			:: completions.async_rcv?0;
			:: completions.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: completions.async_rcv?0;
			:: completions.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	do
	:: result.async_rcv?0 -> 
		break
	:: result.sync?0 -> 
		break
	:: true -> 
				for(i : 0.. writers-1) {
for30:
		};
				for(i : 0.. reports-1) {
for40:
		};
		break
	od;
	goto stop_process
stop_process:}

proctype NewAggregator(Chandef result;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef aggregator_specCompletions;
	Chandef aggregator_beforeSuites;
	Chandef aggregator_suiteBeginnings;
	Chandef aggregator_afterSuites;
	Chandef aggregator_suiteEndings;
	run sync_monitor(aggregator_suiteBeginnings);
	run sync_monitor(aggregator_beforeSuites);
	run sync_monitor(aggregator_afterSuites);
	run sync_monitor(aggregator_specCompletions);
	run sync_monitor(aggregator_suiteEndings);
	goto stop_process;
stop_process:	child!0
}
proctype go_run(Chandef completions) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	
	if
	:: true -> 
		
		if
		:: completions.async_send!0;
		:: completions.sync!0 -> 
			completions.sending?0
		fi
	:: true;
	fi
}
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

