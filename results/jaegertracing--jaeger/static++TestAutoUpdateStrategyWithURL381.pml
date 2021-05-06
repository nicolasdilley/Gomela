
// https://github.com/jaegertracing/jaeger/blob/master/plugin/sampling/strategystore/static/strategy_store_test.go#L381
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAutoUpdateStrategyWithURL3810 = [1] of {int};
	run TestAutoUpdateStrategyWithURL381(child_TestAutoUpdateStrategyWithURL3810)
stop_process:skip
}

proctype TestAutoUpdateStrategyWithURL381(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef mockServer_mu;
	Wgdef mockServer_wg;
	Mutexdef mockServer_Config_mu;
	Mutexdef mockServer_Config_nextProtoOnce_m;
	Mutexdef mockServer_Config_ErrorLog_mu;
	Mutexdef mockServer_Config_TLSConfig_mutex;
	Mutexdef mockServer_TLS_mutex;
	run mutexMonitor(mockServer_TLS_mutex);
	run mutexMonitor(mockServer_Config_TLSConfig_mutex);
	run mutexMonitor(mockServer_Config_ErrorLog_mu);
	run mutexMonitor(mockServer_Config_nextProtoOnce_m);
	run mutexMonitor(mockServer_Config_mu);
	run wgMonitor(mockServer_wg);
	run mutexMonitor(mockServer_mu);
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

