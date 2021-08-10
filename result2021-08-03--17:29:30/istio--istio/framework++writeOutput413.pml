// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pkg/test/framework/suite.go#L413
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_writeOutput4130 = [1] of {int};
	run writeOutput413(child_writeOutput4130);
	run receiver(child_writeOutput4130)
stop_process:skip
}

proctype writeOutput413(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ctx_outcomeMu;
	Mutexdef ctx_contextMu;
	Mutexdef ctx_globalScope_mu;
	

	if
	:: true -> 
		run mutexMonitor(ctx_globalScope_mu);
		run mutexMonitor(ctx_contextMu);
		run mutexMonitor(ctx_outcomeMu);
		ctx_outcomeMu.RLock!false;
		ctx_outcomeMu.RUnlock!false
	:: true;
	fi;
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

