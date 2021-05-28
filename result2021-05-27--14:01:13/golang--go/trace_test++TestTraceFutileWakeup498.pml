// num_comm_params=5
// num_mand_comm_params=0
// num_opt_comm_params=5

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/trace/trace_test.go#L498
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
	chan child_TestTraceFutileWakeup4980 = [1] of {int};
	run TestTraceFutileWakeup498(child_TestTraceFutileWakeup4980);
	run receiver(child_TestTraceFutileWakeup4980)
stop_process:skip
}

proctype TestTraceFutileWakeup498(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestTraceFutileWakeup5405083 = [1] of {int};
	chan child_AnonymousTestTraceFutileWakeup5305082 = [1] of {int};
	chan child_AnonymousTestTraceFutileWakeup5235081 = [1] of {int};
	chan child_AnonymousTestTraceFutileWakeup5165080 = [1] of {int};
	Wgdef done;
	Chandef c2;
	Chandef c1;
	Chandef c0;
	int events = -2; // opt events
	

	if
	:: 1 > 0 -> 
		c0.size = 1;
		run AsyncChan(c0)
	:: else -> 
		run sync_monitor(c0)
	fi;
	

	if
	:: 1 > 0 -> 
		c1.size = 1;
		run AsyncChan(c1)
	:: else -> 
		run sync_monitor(c1)
	fi;
	

	if
	:: 1 > 0 -> 
		c2.size = 1;
		run AsyncChan(c2)
	:: else -> 
		run sync_monitor(c2)
	fi;
	run wgMonitor(done);
	done.update!4 * 2;
		for(i : 0.. 2-1) {
		for10: skip;
		run AnonymousTestTraceFutileWakeup516508(c0,c1,c2,done,child_AnonymousTestTraceFutileWakeup5165080);
		run receiver(child_AnonymousTestTraceFutileWakeup5165080);
		run AnonymousTestTraceFutileWakeup523508(c0,c1,c2,done,child_AnonymousTestTraceFutileWakeup5235081);
		run receiver(child_AnonymousTestTraceFutileWakeup5235081);
		run AnonymousTestTraceFutileWakeup530508(c0,c1,c2,done,child_AnonymousTestTraceFutileWakeup5305082);
		run receiver(child_AnonymousTestTraceFutileWakeup5305082);
		run AnonymousTestTraceFutileWakeup540508(c0,c1,c2,done,child_AnonymousTestTraceFutileWakeup5405083);
		run receiver(child_AnonymousTestTraceFutileWakeup5405083);
		for10_end: skip
	};
	for10_exit: skip;
	done.wait?0;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceFutileWakeup516508(Chandef c0;Chandef c1;Chandef c2;Wgdef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int iters = -2; // opt iters
	

	if
	:: 0 != -2 && iters-1 != -3 -> 
				for(i : 0.. iters-1) {
			for12: skip;
			

			if
			:: c0.enq!0;
			:: c0.sync!false -> 
				c0.sending!false
			fi;
			for12_end: skip
		};
		for12_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			

			if
			:: c0.enq!0;
			:: c0.sync!false -> 
				c0.sending!false
			fi;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	done.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceFutileWakeup523508(Chandef c0;Chandef c1;Chandef c2;Wgdef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int iters = -2; // opt iters
	

	if
	:: 0 != -2 && iters-1 != -3 -> 
				for(i : 0.. iters-1) {
			for14: skip;
			

			if
			:: c0.deq?state,num_msgs;
			:: c0.sync?state -> 
				c0.rcving!false
			fi;
			for14_end: skip
		};
		for14_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			

			if
			:: c0.deq?state,num_msgs;
			:: c0.sync?state -> 
				c0.rcving!false
			fi;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	done.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceFutileWakeup530508(Chandef c0;Chandef c1;Chandef c2;Wgdef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int iters = -2; // opt iters
	

	if
	:: 0 != -2 && iters-1 != -3 -> 
				for(i : 0.. iters-1) {
			for17: skip;
			do
			:: c1.enq!0 -> 
				break
			:: c1.sync!false -> 
				c1.sending!false;
				break
			:: c2.enq!0 -> 
				break
			:: c2.sync!false -> 
				c2.sending!false;
				break
			od;
			for18_exit: skip;
			for17_end: skip
		};
		for17_exit: skip
	:: else -> 
		do
		:: true -> 
			for15: skip;
			do
			:: c1.enq!0 -> 
				break
			:: c1.sync!false -> 
				c1.sending!false;
				break
			:: c2.enq!0 -> 
				break
			:: c2.sync!false -> 
				c2.sending!false;
				break
			od;
			for16_exit: skip;
			for15_end: skip
		:: true -> 
			break
		od;
		for15_exit: skip
	fi;
	done.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceFutileWakeup540508(Chandef c0;Chandef c1;Chandef c2;Wgdef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int iters = -2; // opt iters
	

	if
	:: 0 != -2 && iters-1 != -3 -> 
				for(i : 0.. iters-1) {
			for111: skip;
			do
			:: c1.deq?state,num_msgs -> 
				break
			:: c1.sync?state -> 
				c1.rcving!false;
				break
			:: c2.deq?state,num_msgs -> 
				break
			:: c2.sync?state -> 
				c2.rcving!false;
				break
			od;
			for112_exit: skip;
			for111_end: skip
		};
		for111_exit: skip
	:: else -> 
		do
		:: true -> 
			for19: skip;
			do
			:: c1.deq?state,num_msgs -> 
				break
			:: c1.sync?state -> 
				c1.rcving!false;
				break
			:: c2.deq?state,num_msgs -> 
				break
			:: c2.sync?state -> 
				c2.rcving!false;
				break
			od;
			for110_exit: skip;
			for19_end: skip
		:: true -> 
			break
		od;
		for19_exit: skip
	fi;
	done.update!-1;
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

