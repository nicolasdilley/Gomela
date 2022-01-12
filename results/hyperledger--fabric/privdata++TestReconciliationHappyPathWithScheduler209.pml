// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//gossip/privdata/reconcile_test.go#L209
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
	chan child_TestReconciliationHappyPathWithScheduler2090 = [1] of {int};
	run TestReconciliationHappyPathWithScheduler209(child_TestReconciliationHappyPathWithScheduler2090);
	run receiver(child_TestReconciliationHappyPathWithScheduler2090)
stop_process:skip
}

proctype TestReconciliationHappyPathWithScheduler209(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop1011 = [1] of {int};
	chan child_Start1070 = [1] of {int};
	Mutexdef r_stopOnce_m;
	Mutexdef r_startOnce_m;
	Wgdef wg;
	int var_dig2CollectionConfig = -2; // opt var_dig2CollectionConfig
	run wgMonitor(wg);
	wg.update!1;
	run mutexMonitor(r_startOnce_m);
	run mutexMonitor(r_stopOnce_m);
	run Start107(r_startOnce_m,r_stopOnce_m,child_Start1070);
	child_Start1070?0;
	wg.wait?0;
	run Stop101(r_startOnce_m,r_stopOnce_m,child_Stop1011);
	child_Stop1011?0;
	stop_process: skip;
	child!0
}
proctype Start107(Mutexdef r_startOnce_m;Mutexdef r_stopOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Stop101(Mutexdef r_startOnce_m;Mutexdef r_stopOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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

