// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/stretchr/testify/blob/6241f9ab994219cafb009b160a20acf4a62063aa/assert/assertions_test.go#L2423
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNotErrorIs24230 = [1] of {int};
	run TestNotErrorIs2423(child_TestNotErrorIs24230);
	run receiver(child_TestNotErrorIs24230)
stop_process:skip
}

proctype TestNotErrorIs2423(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef mockT_context_mu;
	int var_teststests = -2; // opt var_teststests
	run mutexMonitor(mockT_context_mu);
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
