// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//net/http/transfer_test.go#L71
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDetectInMemoryReaders710 = [1] of {int};
	run TestDetectInMemoryReaders71(child_TestDetectInMemoryReaders710);
	run receiver(child_TestDetectInMemoryReaders710)
stop_process:skip
}

proctype TestDetectInMemoryReaders71(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __p_once_m;
	Mutexdef __p_wrMu;
	Mutexdef pr_p_once_m;
	Mutexdef pr_p_wrMu;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(pr_p_wrMu);
	run mutexMonitor(pr_p_once_m);
	run mutexMonitor(__p_wrMu);
	run mutexMonitor(__p_once_m);
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

