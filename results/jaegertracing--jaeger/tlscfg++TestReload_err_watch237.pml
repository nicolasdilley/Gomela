
// https://github.com/jaegertracing/jaeger/blob/master/pkg/config/tlscfg/cert_watcher_test.go#L237
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestReload_err_watch2370 = [1] of {int};
	run TestReload_err_watch237(child_TestReload_err_watch2370)
stop_process:skip
}

proctype TestReload_err_watch237(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newCertWatcher430 = [1] of {int};
	Mutexdef watcher_mu;
	Mutexdef watcher_watcher_mu;
	Mutexdef opts_certWatcher_mu;
	Mutexdef opts_certWatcher_watcher_mu;
	run mutexMonitor(opts_certWatcher_watcher_mu);
	run mutexMonitor(opts_certWatcher_mu);
	run mutexMonitor(watcher_watcher_mu);
	run mutexMonitor(watcher_mu);
	run newCertWatcher43(opts_certWatcher_watcher_mu,opts_certWatcher_mu,child_newCertWatcher430);
	child_newCertWatcher430?0;
	stop_process: skip;
	child!0
}
proctype newCertWatcher43(Mutexdef opts_certWatcher_watcher_mu;Mutexdef opts_certWatcher_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close701 = [1] of {int};
	chan child_addCertsToWatch1320 = [1] of {int};
	Mutexdef watcher_mu;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run mutexMonitor(watcher_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run addCertsToWatch132(watcher_mu,opts_certWatcher_watcher_mu,opts_certWatcher_mu,child_addCertsToWatch1320);
	child_addCertsToWatch1320?0;
	

	if
	:: true -> 
		run Close70(watcher_mu,child_Close701);
		child_Close701?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype addCertsToWatch132(Mutexdef watcher_mu;Mutexdef opts_certWatcher_watcher_mu;Mutexdef opts_certWatcher_mu;chan child) {
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
proctype Close70(Mutexdef w_mu;chan child) {
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

