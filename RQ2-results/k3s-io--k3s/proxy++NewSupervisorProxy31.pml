
// https://github.com/k3s-io/k3s/blob/master/pkg/agent/proxy/apiproxy.go#L31
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewSupervisorProxy310 = [1] of {int};
	run NewSupervisorProxy31(child_NewSupervisorProxy310)
stop_process:skip
}

proctype NewSupervisorProxy31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef lb_dialer_Resolver_lookupGroup_mu;
	Mutexdef lb_mutex;
	Mutexdef p_supervisorLB_dialer_Resolver_lookupGroup_mu;
	Mutexdef p_supervisorLB_mutex;
	Mutexdef p_apiServerLB_dialer_Resolver_lookupGroup_mu;
	Mutexdef p_apiServerLB_mutex;
	run mutexMonitor(p_apiServerLB_mutex);
	run mutexMonitor(p_apiServerLB_dialer_Resolver_lookupGroup_mu);
	run mutexMonitor(p_supervisorLB_mutex);
	run mutexMonitor(p_supervisorLB_dialer_Resolver_lookupGroup_mu);
	

	if
	:: true -> 
		run mutexMonitor(lb_mutex);
		run mutexMonitor(lb_dialer_Resolver_lookupGroup_mu);
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

