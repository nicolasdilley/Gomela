#define maxConcurrent106  0

// https://github.com/prometheus/prometheus/blob/master/promql/query_logger.go#L106
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
	chan child_NewActiveQueryTracker1060 = [1] of {int};
	run NewActiveQueryTracker106(maxConcurrent106,child_NewActiveQueryTracker1060)
stop_process:skip
}

proctype NewActiveQueryTracker106(int maxConcurrent;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_generateIndices1690 = [1] of {int};
	Chandef activeQueryTracker_getNextIndex;
	

	if
	:: maxConcurrent > 0 -> 
		activeQueryTracker_getNextIndex.size = maxConcurrent;
		run AsyncChan(activeQueryTracker_getNextIndex)
	:: else -> 
		run sync_monitor(activeQueryTracker_getNextIndex)
	fi;
	run generateIndices169(activeQueryTracker_getNextIndex,maxConcurrent,child_generateIndices1690);
	child_generateIndices1690?0;
	goto stop_process;
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

