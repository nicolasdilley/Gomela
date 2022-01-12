// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//internal/pkg/gateway/config/options_test.go#L32
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDefaultOptions320 = [1] of {int};
	run TestDefaultOptions32(child_TestDefaultOptions320);
	run receiver(child_TestDefaultOptions320)
stop_process:skip
}

proctype TestDefaultOptions32(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetOptions320 = [1] of {int};
	Mutexdef v_envKeyReplacer_once_m;
	run mutexMonitor(v_envKeyReplacer_once_m);
	run GetOptions32(v_envKeyReplacer_once_m,child_GetOptions320);
	child_GetOptions320?0;
	stop_process: skip;
	child!0
}
proctype GetOptions32(Mutexdef v_envKeyReplacer_once_m;chan child) {
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

