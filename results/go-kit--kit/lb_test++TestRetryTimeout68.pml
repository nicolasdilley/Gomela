
// https://github.com/go-kit/kit/blob/master/sd/lb/retry_test.go#L68
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
	chan child_TestRetryTimeout680 = [1] of {int};
	run TestRetryTimeout68(child_TestRetryTimeout680)
stop_process:skip
}

proctype TestRetryTimeout68(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRetryTimeout84701 = [1] of {int};
	chan child_AnonymousTestRetryTimeout78700 = [1] of {int};
	Chandef errs;
	Chandef step;
	run sync_monitor(step);
	

	if
	:: 1 > 0 -> 
		errs.size = 1;
		run AsyncChan(errs)
	:: else -> 
		run sync_monitor(errs)
	fi;
	run AnonymousTestRetryTimeout7870(step,errs,child_AnonymousTestRetryTimeout78700);
	

	if
	:: errs.deq?state,num_msgs;
	:: errs.sync?state -> 
		errs.rcving!false
	fi;
	run AnonymousTestRetryTimeout8470(step,errs,child_AnonymousTestRetryTimeout84701);
	

	if
	:: errs.deq?state,num_msgs;
	:: errs.sync?state -> 
		errs.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRetryTimeout7870(Chandef step;Chandef errs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: step.enq!0;
	:: step.sync!false -> 
		step.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRetryTimeout8470(Chandef step;Chandef errs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: step.enq!0;
	:: step.sync!false -> 
		step.sending!false
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

