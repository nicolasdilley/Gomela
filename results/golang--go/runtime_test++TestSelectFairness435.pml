// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//runtime/chan_test.go#L435
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
	chan child_AnonymousTestSelectFairness4524490 = [1] of {int};
	Wgdef wg;
	Chandef done_ch;
	Chandef out_ch;
	Chandef c4_ch;
	Chandef c3_ch;
	Chandef c2_ch;
	Chandef c1_ch;
	

	if
	:: 10000+1 > 0 -> 
		c1_ch.size = 10000+1;
		run AsyncChan(c1_ch)
	:: else -> 
		run sync_monitor(c1_ch)
	fi;
	

	if
	:: 10000+1 > 0 -> 
		c2_ch.size = 10000+1;
		run AsyncChan(c2_ch)
	:: else -> 
		run sync_monitor(c2_ch)
	fi;
	

	if
	:: 0 != -2 && 10000+1-1 != -3 -> 
				for(i : 0.. 10000+1-1) {
			for11: skip;
			

			if
			:: c1_ch.enq!0;
			:: c1_ch.sync!false -> 
				c1_ch.sending!false
			fi;
			

			if
			:: c2_ch.enq!0;
			:: c2_ch.sync!false -> 
				c2_ch.sending!false
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: c1_ch.enq!0;
			:: c1_ch.sync!false -> 
				c1_ch.sending!false
			fi;
			

			if
			:: c2_ch.enq!0;
			:: c2_ch.sync!false -> 
				c2_ch.sending!false
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run sync_monitor(c3_ch);
	run sync_monitor(c4_ch);
	run sync_monitor(out_ch);
	run sync_monitor(done_ch);
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestSelectFairness452449(done_ch,c1_ch,c2_ch,c3_ch,c4_ch,out_ch,wg,child_AnonymousTestSelectFairness4524490);
	run receiver(child_AnonymousTestSelectFairness4524490);
	done_ch.closing!true;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSelectFairness452449(Chandef done_ch;Chandef c1_ch;Chandef c2_ch;Chandef c3_ch;Chandef c4_ch;Chandef out_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for20: skip;
		do
		:: c3_ch.deq?state,num_msgs -> 
			break
		:: c3_ch.sync?state -> 
			c3_ch.rcving!false;
			break
		:: c4_ch.deq?state,num_msgs -> 
			break
		:: c4_ch.sync?state -> 
			c4_ch.rcving!false;
			break
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
		for21_exit: skip;
		for21_end: skip;
		do
		:: out_ch.enq!0 -> 
			break
		:: out_ch.sync!false -> 
			out_ch.sending!false;
			break
		:: done_ch.deq?state,num_msgs -> 
			goto defer1
		:: done_ch.sync?state -> 
			done_ch.rcving!false;
			goto defer1
		od;
		for22_exit: skip;
		for22_end: skip;
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

