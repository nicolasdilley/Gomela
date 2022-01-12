// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//runtime/trace/trace_test.go#L498
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
	chan child_AnonymousTestTraceFutileWakeup5405103 = [1] of {int};
	chan child_AnonymousTestTraceFutileWakeup5305092 = [1] of {int};
	chan child_AnonymousTestTraceFutileWakeup5235081 = [1] of {int};
	chan child_AnonymousTestTraceFutileWakeup5165080 = [1] of {int};
	Wgdef done;
	Chandef c2_ch;
	Chandef c1_ch;
	Chandef c0_ch;
	int var_events = -2; // opt var_events
	

	if
	:: 1 > 0 -> 
		c0_ch.size = 1;
		run AsyncChan(c0_ch)
	:: else -> 
		run sync_monitor(c0_ch)
	fi;
	

	if
	:: 1 > 0 -> 
		c1_ch.size = 1;
		run AsyncChan(c1_ch)
	:: else -> 
		run sync_monitor(c1_ch)
	fi;
	

	if
	:: 1 > 0 -> 
		c2_ch.size = 1;
		run AsyncChan(c2_ch)
	:: else -> 
		run sync_monitor(c2_ch)
	fi;
	run wgMonitor(done);
	done.update!4*2;
		for(i : 0.. 2-1) {
		for10: skip;
		run AnonymousTestTraceFutileWakeup516508(c0_ch,c1_ch,c2_ch,done,child_AnonymousTestTraceFutileWakeup5165080);
		run receiver(child_AnonymousTestTraceFutileWakeup5165080);
		run AnonymousTestTraceFutileWakeup523508(c0_ch,c1_ch,c2_ch,done,child_AnonymousTestTraceFutileWakeup5235081);
		run receiver(child_AnonymousTestTraceFutileWakeup5235081);
		run AnonymousTestTraceFutileWakeup530509(c1_ch,c2_ch,c0_ch,done,child_AnonymousTestTraceFutileWakeup5305092);
		run receiver(child_AnonymousTestTraceFutileWakeup5305092);
		run AnonymousTestTraceFutileWakeup540510(c2_ch,c0_ch,c1_ch,done,child_AnonymousTestTraceFutileWakeup5405103);
		run receiver(child_AnonymousTestTraceFutileWakeup5405103);
		for10_end: skip
	};
	for10_exit: skip;
	done.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceFutileWakeup516508(Chandef c0_ch;Chandef c1_ch;Chandef c2_ch;Wgdef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_iters = -2; // opt var_iters
	

	if
	:: 0 != -2 && var_iters-1 != -3 -> 
				for(i : 0.. var_iters-1) {
			for12: skip;
			

			if
			:: c0_ch.enq!0;
			:: c0_ch.sync!false -> 
				c0_ch.sending!false
			fi;
			for12_end: skip
		};
		for12_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			

			if
			:: c0_ch.enq!0;
			:: c0_ch.sync!false -> 
				c0_ch.sending!false
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
proctype AnonymousTestTraceFutileWakeup523508(Chandef c0_ch;Chandef c1_ch;Chandef c2_ch;Wgdef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_iters = -2; // opt var_iters
	

	if
	:: 0 != -2 && var_iters-1 != -3 -> 
				for(i : 0.. var_iters-1) {
			for14: skip;
			

			if
			:: c0_ch.deq?state,num_msgs;
			:: c0_ch.sync?state -> 
				c0_ch.rcving!false
			fi;
			for14_end: skip
		};
		for14_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			

			if
			:: c0_ch.deq?state,num_msgs;
			:: c0_ch.sync?state -> 
				c0_ch.rcving!false
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
proctype AnonymousTestTraceFutileWakeup530509(Chandef c1_ch;Chandef c2_ch;Chandef c0_ch;Wgdef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_iters = -2; // opt var_iters
	

	if
	:: 0 != -2 && var_iters-1 != -3 -> 
				for(i : 0.. var_iters-1) {
			for17: skip;
			do
			:: c1_ch.enq!0 -> 
				break
			:: c1_ch.sync!false -> 
				c1_ch.sending!false;
				break
			:: c2_ch.enq!0 -> 
				break
			:: c2_ch.sync!false -> 
				c2_ch.sending!false;
				break
			od;
			for18_exit: skip;
			for18_end: skip;
			for17_end: skip
		};
		for17_exit: skip
	:: else -> 
		do
		:: true -> 
			for15: skip;
			do
			:: c1_ch.enq!0 -> 
				break
			:: c1_ch.sync!false -> 
				c1_ch.sending!false;
				break
			:: c2_ch.enq!0 -> 
				break
			:: c2_ch.sync!false -> 
				c2_ch.sending!false;
				break
			od;
			for16_exit: skip;
			for16_end: skip;
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
proctype AnonymousTestTraceFutileWakeup540510(Chandef c2_ch;Chandef c0_ch;Chandef c1_ch;Wgdef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_iters = -2; // opt var_iters
	

	if
	:: 0 != -2 && var_iters-1 != -3 -> 
				for(i : 0.. var_iters-1) {
			for111: skip;
			do
			:: c1_ch.deq?state,num_msgs -> 
				break
			:: c1_ch.sync?state -> 
				c1_ch.rcving!false;
				break
			:: c2_ch.deq?state,num_msgs -> 
				break
			:: c2_ch.sync?state -> 
				c2_ch.rcving!false;
				break
			od;
			for112_exit: skip;
			for112_end: skip;
			for111_end: skip
		};
		for111_exit: skip
	:: else -> 
		do
		:: true -> 
			for19: skip;
			do
			:: c1_ch.deq?state,num_msgs -> 
				break
			:: c1_ch.sync?state -> 
				c1_ch.rcving!false;
				break
			:: c2_ch.deq?state,num_msgs -> 
				break
			:: c2_ch.sync?state -> 
				c2_ch.rcving!false;
				break
			od;
			for110_exit: skip;
			for110_end: skip;
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

