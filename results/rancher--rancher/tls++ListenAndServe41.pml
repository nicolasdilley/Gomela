
// https://github.com/rancher/rancher/blob/master/pkg/tls/tls.go#L41
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ListenAndServe410 = [1] of {int};
	run ListenAndServe41(child_ListenAndServe410)
stop_process:skip
}

proctype ListenAndServe41(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef serverOptions_TLSListenerConfig_TLSConfig_mutex;
	chan child_migrateConfig1210 = [1] of {int};
	Mutexdef opts_TLSListenerConfig_TLSConfig_mutex;
	run mutexMonitor(opts_TLSListenerConfig_TLSConfig_mutex);
	

	if
	:: true -> 
		goto stop_process
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
	run migrateConfig121(opts_TLSListenerConfig_TLSConfig_mutex,child_migrateConfig1210);
	child_migrateConfig1210?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(serverOptions_TLSListenerConfig_TLSConfig_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype migrateConfig121(Mutexdef opts_TLSListenerConfig_TLSConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

