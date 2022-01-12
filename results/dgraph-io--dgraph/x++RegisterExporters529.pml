// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/dgraph-io/dgraph/blob//x/metrics.go#L529
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_RegisterExporters5290 = [1] of {int};
	run RegisterExporters529(child_RegisterExporters5290);
	run receiver(child_RegisterExporters5290)
stop_process:skip
}

proctype RegisterExporters529(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef je_bundler_mu2;
	Mutexdef je_bundler_semOnce_m;
	Mutexdef je_bundler_sem_mu;
	Mutexdef je_bundler_mu;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run mutexMonitor(je_bundler_mu);
			run mutexMonitor(je_bundler_sem_mu);
			run mutexMonitor(je_bundler_semOnce_m);
			run mutexMonitor(je_bundler_mu2)
		:: true;
		fi
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

