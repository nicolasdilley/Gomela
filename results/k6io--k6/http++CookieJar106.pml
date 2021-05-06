
// https://github.com/k6io/k6/blob/master/js/modules/k6/http/http.go#L106
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_CookieJar1060 = [1] of {int};
	run CookieJar106(child_CookieJar1060)
stop_process:skip
}

proctype CookieJar106(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef state_RPSLimit_mu;
	Mutexdef state_TLSConfig_mutex;
	Mutexdef state_CookieJar_mu;
	Mutexdef state_Group_checkMutex;
	Mutexdef state_Group_groupMutex;
	Mutexdef state_Logger_mu_lock;
	run mutexMonitor(state_Logger_mu_lock);
	run mutexMonitor(state_Group_groupMutex);
	run mutexMonitor(state_Group_checkMutex);
	run mutexMonitor(state_CookieJar_mu);
	run mutexMonitor(state_TLSConfig_mutex);
	run mutexMonitor(state_RPSLimit_mu);
	

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

