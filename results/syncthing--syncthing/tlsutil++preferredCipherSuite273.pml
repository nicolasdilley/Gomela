
// https://github.com/syncthing/syncthing/blob/master/lib/tlsutil/tlsutil.go#L273
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_preferredCipherSuite2730 = [1] of {int};
	run preferredCipherSuite273(child_preferredCipherSuite2730)
stop_process:skip
}

proctype preferredCipherSuite273(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef s_config_mutex;
	Mutexdef s_handshakeMutex;
	chan child_AnonymouspreferredCipherSuite3132990 = [1] of {int};
	Mutexdef c_config_mutex;
	Mutexdef c_handshakeMutex;
	Mutexdef clientCfg_mutex;
	Mutexdef serverCfg_mutex;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(serverCfg_mutex);
	run mutexMonitor(clientCfg_mutex);
	run mutexMonitor(c_handshakeMutex);
	run mutexMonitor(c_config_mutex);
	run AnonymouspreferredCipherSuite313299(serverCfg_mutex,clientCfg_mutex,c_handshakeMutex,c_config_mutex,child_AnonymouspreferredCipherSuite3132990);
	run mutexMonitor(s_handshakeMutex);
	run mutexMonitor(s_config_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymouspreferredCipherSuite313299(Mutexdef serverCfg_mutex;Mutexdef clientCfg_mutex;Mutexdef c_handshakeMutex;Mutexdef c_config_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

