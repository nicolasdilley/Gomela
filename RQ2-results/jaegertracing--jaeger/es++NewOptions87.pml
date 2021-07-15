#define otherNamespaces87  -2

// https://github.com/jaegertracing/jaeger/blob/master/plugin/storage/es/options.go#L87
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewOptions870 = [1] of {int};
	run NewOptions87(otherNamespaces87,child_NewOptions870)
stop_process:skip
}

proctype NewOptions87(int otherNamespaces;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef defaultConfig_TLS_certWatcher_mu;
	Mutexdef defaultConfig_TLS_certWatcher_watcher_mu;
	run mutexMonitor(defaultConfig_TLS_certWatcher_watcher_mu);
	run mutexMonitor(defaultConfig_TLS_certWatcher_mu);
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

