// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/test/e2e/storage/testsuites/volumelimits.go#L88
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
	chan child_DefineTests880 = [1] of {int};
	run DefineTests88(child_DefineTests880);
	run receiver(child_DefineTests880)
stop_process:skip
}

proctype DefineTests88(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef f_flakeReport_lock;
	Wgdef f_logsSizeVerifier_wg;
	Wgdef f_logsSizeWaitGroup;
	Wgdef f_gatherer_workerWg;
	int var_pod_Status_Conditionspod_Status_Conditions = -2; // opt var_pod_Status_Conditionspod_Status_Conditions
	int var_limitlimit = -2; // opt var_limitlimit
	run wgMonitor(f_gatherer_workerWg);
	run wgMonitor(f_logsSizeWaitGroup);
	run wgMonitor(f_logsSizeVerifier_wg);
	run mutexMonitor(f_flakeReport_lock);
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

