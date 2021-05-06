
// https://github.com/kubernetes/kubernetes/blob/master/test/integration/scheduler/extender_test.go#L282
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
	chan child_TestSchedulerExtender2820 = [1] of {int};
	run TestSchedulerExtender282(child_TestSchedulerExtender2820)
stop_process:skip
}

proctype TestSchedulerExtender282(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef es3_mu;
	Wgdef es3_wg;
	Mutexdef es3_Config_mu;
	Mutexdef es3_Config_nextProtoOnce_m;
	Mutexdef es3_Config_ErrorLog_mu;
	Mutexdef es3_Config_TLSConfig_mutex;
	Mutexdef es3_TLS_mutex;
	Mutexdef es2_mu;
	Wgdef es2_wg;
	Mutexdef es2_Config_mu;
	Mutexdef es2_Config_nextProtoOnce_m;
	Mutexdef es2_Config_ErrorLog_mu;
	Mutexdef es2_Config_TLSConfig_mutex;
	Mutexdef es2_TLS_mutex;
	Mutexdef es1_mu;
	Wgdef es1_wg;
	Mutexdef es1_Config_mu;
	Mutexdef es1_Config_nextProtoOnce_m;
	Mutexdef es1_Config_ErrorLog_mu;
	Mutexdef es1_Config_TLSConfig_mutex;
	Mutexdef es1_TLS_mutex;
	Mutexdef testCtx_HTTPServer_mu;
	Wgdef testCtx_HTTPServer_wg;
	Mutexdef testCtx_HTTPServer_Config_mu;
	Mutexdef testCtx_HTTPServer_Config_nextProtoOnce_m;
	Mutexdef testCtx_HTTPServer_Config_ErrorLog_mu;
	Mutexdef testCtx_HTTPServer_Config_TLSConfig_mutex;
	Mutexdef testCtx_HTTPServer_TLS_mutex;
	run mutexMonitor(testCtx_HTTPServer_TLS_mutex);
	run mutexMonitor(testCtx_HTTPServer_Config_TLSConfig_mutex);
	run mutexMonitor(testCtx_HTTPServer_Config_ErrorLog_mu);
	run mutexMonitor(testCtx_HTTPServer_Config_nextProtoOnce_m);
	run mutexMonitor(testCtx_HTTPServer_Config_mu);
	run wgMonitor(testCtx_HTTPServer_wg);
	run mutexMonitor(testCtx_HTTPServer_mu);
	run mutexMonitor(es1_TLS_mutex);
	run mutexMonitor(es1_Config_TLSConfig_mutex);
	run mutexMonitor(es1_Config_ErrorLog_mu);
	run mutexMonitor(es1_Config_nextProtoOnce_m);
	run mutexMonitor(es1_Config_mu);
	run wgMonitor(es1_wg);
	run mutexMonitor(es1_mu);
	run mutexMonitor(es2_TLS_mutex);
	run mutexMonitor(es2_Config_TLSConfig_mutex);
	run mutexMonitor(es2_Config_ErrorLog_mu);
	run mutexMonitor(es2_Config_nextProtoOnce_m);
	run mutexMonitor(es2_Config_mu);
	run wgMonitor(es2_wg);
	run mutexMonitor(es2_mu);
	run mutexMonitor(es3_TLS_mutex);
	run mutexMonitor(es3_Config_TLSConfig_mutex);
	run mutexMonitor(es3_Config_ErrorLog_mu);
	run mutexMonitor(es3_Config_nextProtoOnce_m);
	run mutexMonitor(es3_Config_mu);
	run wgMonitor(es3_wg);
	run mutexMonitor(es3_mu);
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

