// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/galley/pkg/config/source/kube/rt/known_test.go#L175
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_parse1750 = [1] of {int};
	run parse175(child_parse1750);
	run receiver(child_parse1750)
stop_process:skip
}

proctype parse175(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetAdapter670 = [1] of {int};
	Mutexdef pr_mu;
	run mutexMonitor(pr_mu);
	run GetAdapter67(pr_mu,child_GetAdapter670);
	child_GetAdapter670?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetAdapter67(Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getDynamicAdapter340 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getDynamicAdapter34(p_mu,child_getDynamicAdapter340);
	child_getDynamicAdapter340?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getDynamicAdapter34(Mutexdef p_mu;chan child) {
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

