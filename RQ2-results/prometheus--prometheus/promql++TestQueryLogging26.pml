#define not_found_34  1

// https://github.com/prometheus/prometheus/blob/master/promql/query_logger_test.go#L26
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
	chan child_TestQueryLogging260 = [1] of {int};
	run TestQueryLogging26(child_TestQueryLogging260)
stop_process:skip
}

proctype TestQueryLogging26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Delete1794 = [1] of {int};
	chan child_Delete1793 = [1] of {int};
	chan child_Insert1842 = [1] of {int};
	chan child_Insert1841 = [1] of {int};
	chan child_generateIndices1690 = [1] of {int};
	Chandef queryLogger_getNextIndex;
	

	if
	:: 4 > 0 -> 
		queryLogger_getNextIndex.size = 4;
		run AsyncChan(queryLogger_getNextIndex)
	:: else -> 
		run sync_monitor(queryLogger_getNextIndex)
	fi;
	run generateIndices169(queryLogger_getNextIndex,not_found_34,child_generateIndices1690);
	child_generateIndices1690?0;
	

	if
	:: 0 != -2 && 4-1 != -3 -> 
				for(i : 0.. 4-1) {
			for21: skip;
			run Insert184(queryLogger_getNextIndex,child_Insert1842);
			child_Insert1842?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Insert184(queryLogger_getNextIndex,child_Insert1841);
			child_Insert1841?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	

	if
	:: 0 != -2 && 4-1 != -3 -> 
				for(i : 0.. 4-1) {
			for31: skip;
			run Delete179(queryLogger_getNextIndex,child_Delete1794);
			child_Delete1794?0;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			run Delete179(queryLogger_getNextIndex,child_Delete1793);
			child_Delete1793?0;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype generateIndices169(Chandef tracker_getNextIndex;int maxConcurrent;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && maxConcurrent-1 != -3 -> 
				for(i : 0.. maxConcurrent-1) {
			for11: skip;
			

			if
			:: tracker_getNextIndex.enq!0;
			:: tracker_getNextIndex.sync!false -> 
				tracker_getNextIndex.sending!false
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: tracker_getNextIndex.enq!0;
			:: tracker_getNextIndex.sync!false -> 
				tracker_getNextIndex.sending!false
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Insert184(Chandef tracker_getNextIndex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: tracker_getNextIndex.deq?state,num_msgs -> 
		goto stop_process
	:: tracker_getNextIndex.sync?state -> 
		tracker_getNextIndex.rcving!false;
		goto stop_process
	:: true -> 
		goto stop_process
	od;
	stop_process: skip;
	child!0
}
proctype Delete179(Chandef tracker_getNextIndex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: tracker_getNextIndex.enq!0;
	:: tracker_getNextIndex.sync!false -> 
		tracker_getNextIndex.sending!false
	fi;
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


