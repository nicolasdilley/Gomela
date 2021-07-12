// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/race/testdata/waitgroup_test.go#L131
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
	chan child_TestNoRaceWaitGroupMultipleWait1310 = [1] of {int};
	run TestNoRaceWaitGroupMultipleWait131(child_TestNoRaceWaitGroupMultipleWait1310);
	run receiver(child_TestNoRaceWaitGroupMultipleWait1310)
stop_process:skip
}

proctype TestNoRaceWaitGroupMultipleWait131(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestNoRaceWaitGroupMultipleWait1381321 = [1] of {int};
	chan child_AnonymousTestNoRaceWaitGroupMultipleWait1341320 = [1] of {int};
	Wgdef wg;
	Chandef c_ch;
	

	if
	:: 2 > 0 -> 
		c_ch.size = 2;
		run AsyncChan(c_ch)
	:: else -> 
		run sync_monitor(c_ch)
	fi;
	run wgMonitor(wg);
	run AnonymousTestNoRaceWaitGroupMultipleWait134132(c_ch,wg,child_AnonymousTestNoRaceWaitGroupMultipleWait1341320);
	run receiver(child_AnonymousTestNoRaceWaitGroupMultipleWait1341320);
	run AnonymousTestNoRaceWaitGroupMultipleWait138132(c_ch,wg,child_AnonymousTestNoRaceWaitGroupMultipleWait1381321);
	run receiver(child_AnonymousTestNoRaceWaitGroupMultipleWait1381321);
	wg.wait?0;
	

	if
	:: c_ch.deq?state,num_msgs;
	:: c_ch.sync?state -> 
		c_ch.rcving!false
	fi;
	

	if
	:: c_ch.deq?state,num_msgs;
	:: c_ch.sync?state -> 
		c_ch.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNoRaceWaitGroupMultipleWait134132(Chandef c_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.wait?0;
	

	if
	:: c_ch.enq!0;
	:: c_ch.sync!false -> 
		c_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNoRaceWaitGroupMultipleWait138132(Chandef c_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.wait?0;
	

	if
	:: c_ch.enq!0;
	:: c_ch.sync!false -> 
		c_ch.sending!false
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
  :: ch.num_msgs > 0 -> // cannot send on closed channel
    end4: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.deq!true,ch.num_msgs -> 
  		 ch.num_msgs = ch.num_msgs - 1
    fi;
  :: else ->    end5: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.sync!true; 
    fi;
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

proctype receiver(chan c) {
c?0
}

