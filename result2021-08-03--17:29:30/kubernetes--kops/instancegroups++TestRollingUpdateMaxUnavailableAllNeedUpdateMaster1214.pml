// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kops/blob/e3fbc2ad043e58cfdcf934e015ef8d5d9e42273e/pkg/instancegroups/rollingupdate_test.go#L1214
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRollingUpdateMaxUnavailableAllNeedUpdateMaster12140 = [1] of {int};
	run TestRollingUpdateMaxUnavailableAllNeedUpdateMaster1214(child_TestRollingUpdateMaxUnavailableAllNeedUpdateMaster12140);
	run receiver(child_TestRollingUpdateMaxUnavailableAllNeedUpdateMaster12140)
stop_process:skip
}

proctype TestRollingUpdateMaxUnavailableAllNeedUpdateMaster1214(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AssertComplete11380 = [1] of {int};
	Mutexdef concurrentTest_mutex;
	run mutexMonitor(concurrentTest_mutex);
	run AssertComplete1138(concurrentTest_mutex,child_AssertComplete11380);
	child_AssertComplete11380?0;
	stop_process: skip;
	child!0
}
proctype AssertComplete1138(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mutex.Lock!false;
		defer1: skip;
	c_mutex.Unlock!false;
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

