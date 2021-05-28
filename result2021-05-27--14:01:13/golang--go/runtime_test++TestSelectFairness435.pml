// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/chan_test.go#L435
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
	chan child_TestSelectFairness4350 = [1] of {int};
	run TestSelectFairness435(child_TestSelectFairness4350);
	run receiver(child_TestSelectFairness4350)
stop_process:skip
}

proctype TestSelectFairness435(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestSelectFairness4524460 = [1] of {int};
	Wgdef wg;
	Chandef done;
	Chandef out;
	Chandef c4;
	Chandef c3;
	Chandef c2;
	Chandef c1;
	

	if
	:: 10000 + 1 > 0 -> 
		c1.size = 10000 + 1;
		run AsyncChan(c1)
	:: else -> 
		run sync_monitor(c1)
	fi;
	

	if
	:: 10000 + 1 > 0 -> 
		c2.size = 10000 + 1;
		run AsyncChan(c2)
	:: else -> 
		run sync_monitor(c2)
	fi;
	

	if
	:: 0 != -2 && 10000 + 1-1 != -3 -> 
				for(i : 0.. 10000 + 1-1) {
			for11: skip;
			

			if
			:: c1.enq!0;
			:: c1.sync!false -> 
				c1.sending!false
			fi;
			

			if
			:: c2.enq!0;
			:: c2.sync!false -> 
				c2.sending!false
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: c1.enq!0;
			:: c1.sync!false -> 
				c1.sending!false
			fi;
			

			if
			:: c2.enq!0;
			:: c2.sync!false -> 
				c2.sending!false
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run sync_monitor(c3);
	run sync_monitor(c4);
	run sync_monitor(out);
	run sync_monitor(done);
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestSelectFairness452446(c3,c4,out,done,c1,c2,wg,child_AnonymousTestSelectFairness4524460);
	run receiver(child_AnonymousTestSelectFairness4524460);
	done.closing!true;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSelectFairness452446(Chandef c3;Chandef c4;Chandef out;Chandef done;Chandef c1;Chandef c2;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for20: skip;
		do
		:: c3.deq?state,num_msgs -> 
			break
		:: c3.sync?state -> 
			c3.rcving!false;
			break
		:: c4.deq?state,num_msgs -> 
			break
		:: c4.sync?state -> 
			c4.rcving!false;
			break
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
		for21_exit: skip;
		do
		:: out.enq!0 -> 
			break
		:: out.sync!false -> 
			out.sending!false;
			break
		:: done.deq?state,num_msgs -> 
			goto defer1
		:: done.sync?state -> 
			done.rcving!false;
			goto defer1
		od;
		for22_exit: skip;
		for20_end: skip
	od;
	for20_exit: skip;
		defer1: skip;
	wg.update!-1;
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

