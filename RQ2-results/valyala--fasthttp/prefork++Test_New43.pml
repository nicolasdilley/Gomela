
// https://github.com/valyala/fasthttp/blob/master/prefork/prefork_test.go#L43
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_New430 = [1] of {int};
	run Test_New43(child_Test_New430)
stop_process:skip
}

proctype Test_New43(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_New880 = [1] of {int};
	Mutexdef s_mu;
	Mutexdef s_perIPConnCounter_lock;
	Mutexdef s_tlsConfig_mutex;
	run mutexMonitor(s_tlsConfig_mutex);
	run mutexMonitor(s_perIPConnCounter_lock);
	run mutexMonitor(s_mu);
	run New88(s_tlsConfig_mutex,s_perIPConnCounter_lock,s_mu,child_New880);
	child_New880?0;
	stop_process: skip;
	child!0
}
proctype New88(Mutexdef s_tlsConfig_mutex;Mutexdef s_perIPConnCounter_lock;Mutexdef s_mu;chan child) {
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

