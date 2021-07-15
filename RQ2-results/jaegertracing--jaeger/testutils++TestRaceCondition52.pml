
// https://github.com/jaegertracing/jaeger/blob/master/pkg/testutils/logger_test.go#L52
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
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestRaceCondition520 = [1] of {int};
	run TestRaceCondition52(child_TestRaceCondition520)
stop_process:skip
}

proctype TestRaceCondition52(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRaceCondition65551 = [1] of {int};
	chan child_AnonymousTestRaceCondition59550 = [1] of {int};
	Wgdef finish;
	Chandef start;
	run sync_monitor(start);
	run wgMonitor(finish);
	finish.update!2;
	run AnonymousTestRaceCondition5955(start,finish,child_AnonymousTestRaceCondition59550);
	run AnonymousTestRaceCondition6555(start,finish,child_AnonymousTestRaceCondition65551);
	start.closing!true;
	finish.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRaceCondition5955(Chandef start;Wgdef finish;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: start.deq?state,num_msgs;
	:: start.sync?state -> 
		start.rcving!false
	fi;
	finish.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRaceCondition6555(Chandef start;Wgdef finish;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: start.deq?state,num_msgs;
	:: start.sync?state -> 
		start.rcving!false
	fi;
	finish.update!-1;
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

proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

