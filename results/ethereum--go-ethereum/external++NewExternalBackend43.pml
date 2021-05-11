
// https://github.com/ethereum/go-ethereum/blob/master/accounts/external/backend.go#L43
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewExternalBackend430 = [1] of {int};
	run NewExternalBackend43(child_NewExternalBackend430)
stop_process:skip
}

proctype NewExternalBackend43(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef signer_cacheMu;
	Mutexdef signer_client_services_mu;
	run mutexMonitor(signer_client_services_mu);
	run mutexMonitor(signer_cacheMu);
	

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
