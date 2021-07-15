
// https://github.com/matryer/xbar/blob/master/pkg/plugins/install_test.go#L15
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
	chan child_TestInstall150 = [1] of {int};
	run TestInstall15(child_TestInstall150)
stop_process:skip
}

proctype TestInstall15(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef srv_mu;
	Wgdef srv_wg;
	Mutexdef srv_Config_mu;
	Mutexdef srv_Config_nextProtoOnce_m;
	Mutexdef srv_Config_ErrorLog_mu;
	Mutexdef srv_Config_TLSConfig_mutex;
	Mutexdef srv_TLS_mutex;
	run mutexMonitor(srv_TLS_mutex);
	run mutexMonitor(srv_Config_TLSConfig_mutex);
	run mutexMonitor(srv_Config_ErrorLog_mu);
	run mutexMonitor(srv_Config_nextProtoOnce_m);
	run mutexMonitor(srv_Config_mu);
	run wgMonitor(srv_wg);
	run mutexMonitor(srv_mu);
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

