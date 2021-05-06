
// https://github.com/jaegertracing/jaeger/blob/master/pkg/config/tlscfg/cert_watcher_test.go#L247
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAddCertsToWatch_err2470 = [1] of {int};
	run TestAddCertsToWatch_err247(child_TestAddCertsToWatch_err2470)
stop_process:skip
}

proctype TestAddCertsToWatch_err247(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close700 = [1] of {int};
	chan child_addCertsToWatch1321 = [1] of {int};
	chan child_addCertsToWatch1322 = [1] of {int};
	Mutexdef watcher_mu;
	int tests = -2;
	run mutexMonitor(watcher_mu);
	

	if
	:: tests-1 != -3 -> 
				for(i : 0.. tests-1) {
			for10: skip;
			run addCertsToWatch132(watcher_mu,child_addCertsToWatch1321);
			child_addCertsToWatch1321?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run addCertsToWatch132(watcher_mu,child_addCertsToWatch1322);
			child_addCertsToWatch1322?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
		run Close70(watcher_mu,child_Close700);
	child_Close700?0;
	child!0
}
proctype Close70(Mutexdef w_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype addCertsToWatch132(Mutexdef watcher_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

