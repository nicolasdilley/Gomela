
// https://github.com/hashicorp/consul/blob/master/agent/auto-config/auto_encrypt_test.go#L196
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAutoEncrypt_InitialCerts1960 = [1] of {int};
	run TestAutoEncrypt_InitialCerts196(child_TestAutoEncrypt_InitialCerts1960)
stop_process:skip
}

proctype TestAutoEncrypt_InitialCerts196(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef mcfg_cache_lock;
	run mutexMonitor(mcfg_cache_lock);
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

