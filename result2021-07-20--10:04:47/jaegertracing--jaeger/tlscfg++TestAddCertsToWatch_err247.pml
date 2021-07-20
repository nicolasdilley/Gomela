// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/jaegertracing/jaeger/blob/12bba8c9b91cf4a29d314934bc08f4a80e43c042/pkg/config/tlscfg/cert_watcher_test.go#L247
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAddCertsToWatch_err2470 = [1] of {int};
	run TestAddCertsToWatch_err247(child_TestAddCertsToWatch_err2470);
	run receiver(child_TestAddCertsToWatch_err2470)
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
	int var_teststests = -2; // opt var_teststests
	run mutexMonitor(watcher_mu);
	

	if
	:: var_tests-1 != -3 -> 
				for(i : 0.. var_tests-1) {
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
		defer1: skip;
	run Close70(watcher_mu,child_Close700);
	child_Close700?0;
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

proctype receiver(chan c) {
c?0
}

