#define TestNoConflictQuery1_in  3

// https://github.com/dgraph-io/dgraph/blob/master/query/query4_test.go#L308
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
	chan child_TestNoConflictQuery13080 = [1] of {int};
	run TestNoConflictQuery1308(child_TestNoConflictQuery13080)
stop_process:skip
}

proctype TestNoConflictQuery1308(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestNoConflictQuery13423420 = [1] of {int};
	Chandef errChan;
	int in = TestNoConflictQuery1_in;
	run sync_monitor(errChan);
		for(i : 0.. in-1) {
		for20: skip;
		run AnonymousTestNoConflictQuery1342342(errChan,child_AnonymousTestNoConflictQuery13423420);
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: 0 != -2 && in-1 != -3 -> 
				for(i : 0.. in-1) {
			for31: skip;
			

			if
			:: errChan.deq?state,num_msgs;
			:: errChan.sync?state -> 
				errChan.rcving!false
			fi;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: errChan.deq?state,num_msgs;
			:: errChan.sync?state -> 
				errChan.rcving!false
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNoConflictQuery1342342(Chandef errChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: errChan.enq!0;
	:: errChan.sync!false -> 
		errChan.sending!false
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

