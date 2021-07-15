
// https://github.com/matryer/xbar/blob/master/pkg/update/update_test.go#L46
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
	chan child_TestUpdate460 = [1] of {int};
	run TestUpdate46(child_TestUpdate460)
stop_process:skip
}

proctype TestUpdate46(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef apiServer_mu;
	Wgdef apiServer_wg;
	Mutexdef apiServer_Config_mu;
	Mutexdef apiServer_Config_nextProtoOnce_m;
	Mutexdef apiServer_Config_ErrorLog_mu;
	Mutexdef apiServer_Config_TLSConfig_mutex;
	Mutexdef apiServer_TLS_mutex;
	Mutexdef downloadServer_mu;
	Wgdef downloadServer_wg;
	Mutexdef downloadServer_Config_mu;
	Mutexdef downloadServer_Config_nextProtoOnce_m;
	Mutexdef downloadServer_Config_ErrorLog_mu;
	Mutexdef downloadServer_Config_TLSConfig_mutex;
	Mutexdef downloadServer_TLS_mutex;
	run mutexMonitor(downloadServer_TLS_mutex);
	run mutexMonitor(downloadServer_Config_TLSConfig_mutex);
	run mutexMonitor(downloadServer_Config_ErrorLog_mu);
	run mutexMonitor(downloadServer_Config_nextProtoOnce_m);
	run mutexMonitor(downloadServer_Config_mu);
	run wgMonitor(downloadServer_wg);
	run mutexMonitor(downloadServer_mu);
	run mutexMonitor(apiServer_TLS_mutex);
	run mutexMonitor(apiServer_Config_TLSConfig_mutex);
	run mutexMonitor(apiServer_Config_ErrorLog_mu);
	run mutexMonitor(apiServer_Config_nextProtoOnce_m);
	run mutexMonitor(apiServer_Config_mu);
	run wgMonitor(apiServer_wg);
	run mutexMonitor(apiServer_mu);
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

