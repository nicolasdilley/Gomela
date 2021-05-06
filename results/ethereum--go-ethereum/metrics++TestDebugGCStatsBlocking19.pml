
// https://github.com/ethereum/go-ethereum/blob/master/metrics/debug_test.go#L19
typedef Chandef {
	chan sync = [0] of {bool};
	chan enq = [0] of {int};
	chan deq = [0] of {bool,int};
	chan sending = [0] of {bool};
	chan rcving = [0] of {bool};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	chan child_TestDebugGCStatsBlocking190 = [1] of {int};
	run TestDebugGCStatsBlocking19(child_TestDebugGCStatsBlocking190)
stop_process:skip
}

proctype TestDebugGCStatsBlocking19(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testDebugGCStatsBlocking381 = [1] of {int};
	chan child_testDebugGCStatsBlocking380 = [1] of {int};
	Chandef ch;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(ch);
	run testDebugGCStatsBlocking38(ch,child_testDebugGCStatsBlocking380);
	

	if
	:: ch.deq?state,num_msgs;
	:: ch.sync?state -> 
		ch.rcving!false
	fi;
	run testDebugGCStatsBlocking38(ch,child_testDebugGCStatsBlocking381);
	

	if
	:: ch.deq?state,num_msgs;
	:: ch.sync?state -> 
		ch.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype testDebugGCStatsBlocking38(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		do
		:: ch.enq!0 -> 
			goto stop_process
		:: ch.sync!false,0 -> 
			ch.sending!false;
			goto stop_process
		:: true -> 
			break
		od;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.rcving?false;
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.sync!true -> 
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.deq!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		    ch.closed = true
		   :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.enq?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.rcving?false ->
 		    ch.sending?false;
		fi;
		:: else -> 
		end3: if
		  :: ch.enq?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.deq!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		     ch.closed = true
		  :: ch.rcving?false ->
 		    ch.sending?false;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.rcving?false;
  :: ch.sync!true; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.rcving?false ->
       ch.sending?false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

