
// https://github.com/moby/moby/blob/master/distribution/registry_unit_test.go#L104
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
	chan child_TestTokenPassThruDifferentHost1040 = [1] of {int};
	run TestTokenPassThruDifferentHost104(child_TestTokenPassThruDifferentHost1040)
stop_process:skip
}

proctype TestTokenPassThruDifferentHost104(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close2940 = [1] of {int};
	chan child_Close2941 = [1] of {int};
	chan child_testTokenPassThru382 = [1] of {int};
	Mutexdef tsredirect_mu;
	Wgdef tsredirect_wg;
	Mutexdef tsredirect_Config_mu;
	Mutexdef tsredirect_Config_nextProtoOnce_m;
	Mutexdef tsredirect_Config_ErrorLog_mu;
	Mutexdef tsredirect_Config_TLSConfig_mutex;
	Mutexdef tsredirect_TLS_mutex;
	Mutexdef ts_mu;
	Wgdef ts_wg;
	Mutexdef ts_Config_mu;
	Mutexdef ts_Config_nextProtoOnce_m;
	Mutexdef ts_Config_ErrorLog_mu;
	Mutexdef ts_Config_TLSConfig_mutex;
	Mutexdef ts_TLS_mutex;
	run mutexMonitor(ts_TLS_mutex);
	run mutexMonitor(ts_Config_TLSConfig_mutex);
	run mutexMonitor(ts_Config_ErrorLog_mu);
	run mutexMonitor(ts_Config_nextProtoOnce_m);
	run mutexMonitor(ts_Config_mu);
	run wgMonitor(ts_wg);
	run mutexMonitor(ts_mu);
	run mutexMonitor(tsredirect_TLS_mutex);
	run mutexMonitor(tsredirect_Config_TLSConfig_mutex);
	run mutexMonitor(tsredirect_Config_ErrorLog_mu);
	run mutexMonitor(tsredirect_Config_nextProtoOnce_m);
	run mutexMonitor(tsredirect_Config_mu);
	run wgMonitor(tsredirect_wg);
	run mutexMonitor(tsredirect_mu);
	run testTokenPassThru38(tsredirect_wg,tsredirect_TLS_mutex,tsredirect_Config_TLSConfig_mutex,tsredirect_Config_ErrorLog_mu,tsredirect_Config_nextProtoOnce_m,tsredirect_Config_mu,tsredirect_mu,child_testTokenPassThru382);
	child_testTokenPassThru382?0;
	stop_process: skip;
		run Close294(tsredirect_wg,tsredirect_TLS_mutex,tsredirect_Config_TLSConfig_mutex,tsredirect_Config_ErrorLog_mu,tsredirect_Config_nextProtoOnce_m,tsredirect_Config_mu,tsredirect_mu,child_Close2941);
	child_Close2941?0;
		run Close294(ts_wg,ts_TLS_mutex,ts_Config_TLSConfig_mutex,ts_Config_ErrorLog_mu,ts_Config_nextProtoOnce_m,ts_Config_mu,ts_mu,child_Close2940);
	child_Close2940?0;
	child!0
}
proctype Close294(Wgdef ld_wg;Mutexdef ld_TLS_mutex;Mutexdef ld_Config_TLSConfig_mutex;Mutexdef ld_Config_ErrorLog_mu;Mutexdef ld_Config_nextProtoOnce_m;Mutexdef ld_Config_mu;Mutexdef ld_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype testTokenPassThru38(Wgdef ts_wg;Mutexdef ts_TLS_mutex;Mutexdef ts_Config_TLSConfig_mutex;Mutexdef ts_Config_ErrorLog_mu;Mutexdef ts_Config_nextProtoOnce_m;Mutexdef ts_Config_mu;Mutexdef ts_mu;chan child) {
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

