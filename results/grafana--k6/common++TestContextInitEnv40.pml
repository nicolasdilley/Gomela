// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grafana/k6/blob//js/common/context_test.go#L40
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextInitEnv400 = [1] of {int};
	run TestContextInitEnv40(child_TestContextInitEnv400);
	run receiver(child_TestContextInitEnv400)
stop_process:skip
}

proctype TestContextInitEnv40(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WithInitEnv510 = [1] of {int};
	Mutexdef ie_Registry_l;
	run mutexMonitor(ie_Registry_l);
	run WithInitEnv51(ie_Registry_l,child_WithInitEnv510);
	child_WithInitEnv510?0;
	stop_process: skip;
	child!0
}
proctype WithInitEnv51(Mutexdef initEnv_Registry_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
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

