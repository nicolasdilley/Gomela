// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/groupcache/blob//groupcache_test.go#L388
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
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNoDedup3880 = [1] of {int};
	run TestNoDedup388(child_TestNoDedup3880);
	run receiver(child_TestNoDedup3880)
stop_process:skip
}

proctype TestNoDedup388(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_items4553 = [1] of {int};
	chan child_items4552 = [1] of {int};
	chan child_AnonymousTestNoDedup4103950 = [1] of {int};
	Chandef resc_ch;
	Mutexdef orderedGroup_mu;
	Chandef orderedGroup_stage2_ch;
	Chandef orderedGroup_stage1_ch;
	Mutexdef g_hotCache_mu;
	Mutexdef g_mainCache_mu;
	Mutexdef g_peersOnce_m;
	run mutexMonitor(g_peersOnce_m);
	run mutexMonitor(g_mainCache_mu);
	run mutexMonitor(g_hotCache_mu);
	run sync_monitor(orderedGroup_stage1_ch);
	run sync_monitor(orderedGroup_stage2_ch);
	run mutexMonitor(orderedGroup_mu);
	

	if
	:: 2 > 0 -> 
		resc_ch.size = 2;
		run AsyncChan(resc_ch)
	:: else -> 
		run sync_monitor(resc_ch)
	fi;
		for(i : 0.. 2-1) {
		for10: skip;
		run AnonymousTestNoDedup410395(orderedGroup_stage1_ch,orderedGroup_stage2_ch,resc_ch,g_peersOnce_m,g_mainCache_mu,g_hotCache_mu,orderedGroup_mu,child_AnonymousTestNoDedup4103950);
		run receiver(child_AnonymousTestNoDedup4103950);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: orderedGroup_stage1_ch.enq!0;
	:: orderedGroup_stage1_ch.sync!false -> 
		orderedGroup_stage1_ch.sending!false
	fi;
	

	if
	:: orderedGroup_stage1_ch.enq!0;
	:: orderedGroup_stage1_ch.sync!false -> 
		orderedGroup_stage1_ch.sending!false
	fi;
	

	if
	:: orderedGroup_stage2_ch.enq!0;
	:: orderedGroup_stage2_ch.sync!false -> 
		orderedGroup_stage2_ch.sending!false
	fi;
	

	if
	:: orderedGroup_stage2_ch.enq!0;
	:: orderedGroup_stage2_ch.sync!false -> 
		orderedGroup_stage2_ch.sending!false
	fi;
	

	if
	:: 0 != -2 && 2-1 != -3 -> 
				for(i : 0.. 2-1) {
			for21: skip;
			

			if
			:: resc_ch.deq?state,num_msgs;
			:: resc_ch.sync?state -> 
				resc_ch.rcving!false
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: resc_ch.deq?state,num_msgs;
			:: resc_ch.sync?state -> 
				resc_ch.rcving!false
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	run items455(g_mainCache_mu,child_items4552);
	child_items4552?0;
	

	if
	:: true -> 
		run items455(g_mainCache_mu,child_items4553);
		child_items4553?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNoDedup410395(Chandef orderedGroup_stage1_ch;Chandef orderedGroup_stage2_ch;Chandef resc_ch;Mutexdef g_peersOnce_m;Mutexdef g_mainCache_mu;Mutexdef g_hotCache_mu;Mutexdef orderedGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get2080 = [1] of {int};
	run Get208(g_hotCache_mu,g_mainCache_mu,g_peersOnce_m,child_Get2080);
	child_Get2080?0;
	

	if
	:: true -> 
		

		if
		:: resc_ch.enq!0;
		:: resc_ch.sync!false -> 
			resc_ch.sending!false
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: resc_ch.enq!0;
	:: resc_ch.sync!false -> 
		resc_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype Get208(Mutexdef g_hotCache_mu;Mutexdef g_mainCache_mu;Mutexdef g_peersOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_load2371 = [1] of {int};
	chan child_lookupCache3240 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run lookupCache324(g_hotCache_mu,g_mainCache_mu,g_peersOnce_m,child_lookupCache3240);
	child_lookupCache3240?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run load237(g_hotCache_mu,g_mainCache_mu,g_peersOnce_m,child_load2371);
	child_load2371?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype lookupCache324(Mutexdef g_hotCache_mu;Mutexdef g_mainCache_mu;Mutexdef g_peersOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get4261 = [1] of {int};
	chan child_get4260 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run get426(g_mainCache_mu,child_get4260);
	child_get4260?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run get426(g_hotCache_mu,child_get4261);
	child_get4261?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype get426(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype load237(Mutexdef g_hotCache_mu;Mutexdef g_mainCache_mu;Mutexdef g_peersOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype items455(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_itemsLocked4612 = [1] of {int};
	c_mu.RLock!false;
	run itemsLocked461(c_mu,child_itemsLocked4612);
	child_itemsLocked4612?0;
	goto defer1;
		defer1: skip;
	c_mu.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype itemsLocked461(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
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

proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

proctype receiver(chan c) {
c?0
}

