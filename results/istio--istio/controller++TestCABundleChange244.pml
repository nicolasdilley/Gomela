// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob//pkg/webhooks/validation/controller/controller_test.go#L244
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCABundleChange2440 = [1] of {int};
	run TestCABundleChange244(child_TestCABundleChange2440);
	run receiver(child_TestCABundleChange2440)
stop_process:skip
}

proctype TestCABundleChange244(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_reconcileHelper1951 = [1] of {int};
	chan child_reconcileHelper1950 = [1] of {int};
	Mutexdef c_injectedMu;
	run mutexMonitor(c_injectedMu);
	run reconcileHelper195(c_injectedMu,child_reconcileHelper1950);
	child_reconcileHelper1950?0;
	c_injectedMu.Lock!false;
	c_injectedMu.Unlock!false;
	run reconcileHelper195(c_injectedMu,child_reconcileHelper1951);
	child_reconcileHelper1951?0;
	stop_process: skip;
	child!0
}
proctype reconcileHelper195(Mutexdef c_injectedMu;chan child) {
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

