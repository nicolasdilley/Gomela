
// https://github.com/istio/istio/blob/master/security/pkg/stsservice/tokenmanager/tokenmanager.go#L82
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_CreateTokenManager820 = [1] of {int};
	run CreateTokenManager82(child_CreateTokenManager820)
stop_process:skip
}

proctype CreateTokenManager82(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef p_mutex;
	Mutexdef p_tokens_mu;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run mutexMonitor(p_tokens_mu);
			run mutexMonitor(p_mutex)
		:: true;
		fi
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

