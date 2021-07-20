// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/internal/legacy/helper/schema/set_test.go#L132
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHashEqual1320 = [1] of {int};
	run TestHashEqual132(child_TestHashEqual1320);
	run receiver(child_TestHashEqual1320)
stop_process:skip
}

proctype TestHashEqual132(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef s4_once_m;
	Mutexdef s3_once_m;
	Mutexdef s2_once_m;
	Mutexdef s1_once_m;
	int var_casescases = -2; // opt var_casescases
	run mutexMonitor(s1_once_m);
	run mutexMonitor(s2_once_m);
	run mutexMonitor(s3_once_m);
	run mutexMonitor(s4_once_m);
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

