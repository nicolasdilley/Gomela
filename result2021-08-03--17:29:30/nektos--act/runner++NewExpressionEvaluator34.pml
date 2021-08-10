// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/nektos/act/blob/020d6a60832a324e46b72be92ac5754537e57a17/pkg/runner/expression.go#L34
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewExpressionEvaluator340 = [1] of {int};
	run NewExpressionEvaluator34(child_NewExpressionEvaluator340);
	run receiver(child_NewExpressionEvaluator340)
stop_process:skip
}

proctype NewExpressionEvaluator34(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef vm_runtime_lck;
	int var_configers = -2; // opt var_configers
	run mutexMonitor(vm_runtime_lck);
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

