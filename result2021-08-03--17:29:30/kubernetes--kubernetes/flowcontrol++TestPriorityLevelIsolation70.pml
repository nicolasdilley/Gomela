// num_comm_params=4
// num_mand_comm_params=4
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/test/integration/apiserver/flowcontrol/concurrency_test.go#L70
#define def_var_concurrencyShares110  ?? // mand concurrencyShares line 110
#define def_var_queueLength110  ?? // mand queueLength line 110
#define not_found_110  ?? // mand parallel line 315
#define not_found_117  ?? // mand parallel line 315
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
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPriorityLevelIsolation700 = [1] of {int};
	run TestPriorityLevelIsolation70(child_TestPriorityLevelIsolation700);
	run receiver(child_TestPriorityLevelIsolation700)
stop_process:skip
}

proctype TestPriorityLevelIsolation70(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_streamRequests3151 = [1] of {int};
	chan child_streamRequests3150 = [1] of {int};
	Chandef stopCh_ch;
	Mutexdef __mu;
	Wgdef __wg;
	Mutexdef __Config_mu;
	Mutexdef __TLS_mutex;
	int var_queueLength = def_var_queueLength110; // mand var_queueLength
	int var_concurrencyShares = def_var_concurrencyShares110; // mand var_concurrencyShares
	run mutexMonitor(__TLS_mutex);
	run mutexMonitor(__Config_mu);
	run wgMonitor(__wg);
	run mutexMonitor(__mu);
	run sync_monitor(stopCh_ch);
	run streamRequests315(stopCh_ch,not_found_110,child_streamRequests3150);
	child_streamRequests3150?0;
	run streamRequests315(stopCh_ch,not_found_117,child_streamRequests3151);
	child_streamRequests3151?0;
		defer1: skip;
	stopCh_ch.closing!true;
	stop_process: skip;
	child!0
}
proctype streamRequests315(Chandef stopCh_ch;int var_parallel;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousstreamRequests3173150 = [1] of {int};
		for(i : 0.. var_parallel-1) {
		for10: skip;
		run AnonymousstreamRequests317315(stopCh_ch,child_AnonymousstreamRequests3173150);
		run receiver(child_AnonymousstreamRequests3173150);
		for10_end: skip
	};
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousstreamRequests317315(Chandef stopCh_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for11: skip;
		do
		:: stopCh_ch.deq?state,num_msgs -> 
			goto stop_process
		:: stopCh_ch.sync?state -> 
			stopCh_ch.rcving!false;
			goto stop_process
		:: true -> 
			break
		od;
		for12_exit: skip;
		for12_end: skip;
		for11_end: skip
	od;
	for11_exit: skip;
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

