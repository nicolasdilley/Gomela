
// https://github.com/traefik/traefik/blob/master/pkg/middlewares/auth/forward_test.go#L101
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
	chan child_TestForwardAuthRedirect1010 = [1] of {int};
	run TestForwardAuthRedirect101(child_TestForwardAuthRedirect1010)
stop_process:skip
}

proctype TestForwardAuthRedirect101(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ts_mu;
	Wgdef ts_wg;
	Mutexdef ts_Config_mu;
	Mutexdef ts_Config_nextProtoOnce_m;
	Mutexdef ts_Config_ErrorLog_mu;
	Mutexdef ts_Config_TLSConfig_mutex;
	Mutexdef ts_TLS_mutex;
	Mutexdef authTs_mu;
	Wgdef authTs_wg;
	Mutexdef authTs_Config_mu;
	Mutexdef authTs_Config_nextProtoOnce_m;
	Mutexdef authTs_Config_ErrorLog_mu;
	Mutexdef authTs_Config_TLSConfig_mutex;
	Mutexdef authTs_TLS_mutex;
	run mutexMonitor(authTs_TLS_mutex);
	run mutexMonitor(authTs_Config_TLSConfig_mutex);
	run mutexMonitor(authTs_Config_ErrorLog_mu);
	run mutexMonitor(authTs_Config_nextProtoOnce_m);
	run mutexMonitor(authTs_Config_mu);
	run wgMonitor(authTs_wg);
	run mutexMonitor(authTs_mu);
	run mutexMonitor(ts_TLS_mutex);
	run mutexMonitor(ts_Config_TLSConfig_mutex);
	run mutexMonitor(ts_Config_ErrorLog_mu);
	run mutexMonitor(ts_Config_nextProtoOnce_m);
	run mutexMonitor(ts_Config_mu);
	run wgMonitor(ts_wg);
	run mutexMonitor(ts_mu);
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

