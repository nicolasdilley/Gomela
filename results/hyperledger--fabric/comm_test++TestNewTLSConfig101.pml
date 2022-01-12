// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//internal/pkg/comm/creds_test.go#L101
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewTLSConfig1010 = [1] of {int};
	run TestNewTLSConfig101(child_TestNewTLSConfig1010);
	run receiver(child_TestNewTLSConfig1010)
stop_process:skip
}

proctype TestNewTLSConfig101(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewTLSConfig650 = [1] of {int};
	Mutexdef config_lock;
	Mutexdef config_config_mutex;
	Mutexdef tlsConfig_mutex;
	run mutexMonitor(tlsConfig_mutex);
	run mutexMonitor(config_config_mutex);
	run mutexMonitor(config_lock);
	run NewTLSConfig65(tlsConfig_mutex,child_NewTLSConfig650);
	child_NewTLSConfig650?0;
	stop_process: skip;
	child!0
}
proctype NewTLSConfig65(Mutexdef config_mutex;chan child) {
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

proctype receiver(chan c) {
c?0
}

