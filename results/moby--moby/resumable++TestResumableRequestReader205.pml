
// https://github.com/moby/moby/blob/master/registry/resumable/resumablerequestreader_test.go#L205
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
	chan child_TestResumableRequestReader2050 = [1] of {int};
	run TestResumableRequestReader205(child_TestResumableRequestReader2050)
stop_process:skip
}

proctype TestResumableRequestReader205(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close840 = [1] of {int};
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
	stop_process: skip;
		run Close84(ts_wg,ts_TLS_mutex,ts_Config_TLSConfig_mutex,ts_Config_ErrorLog_mu,ts_Config_nextProtoOnce_m,ts_Config_mu,ts_mu,child_Close840);
	child_Close840?0;
	child!0
}
proctype Close84(Wgdef r_wg;Mutexdef r_TLS_mutex;Mutexdef r_Config_TLSConfig_mutex;Mutexdef r_Config_ErrorLog_mu;Mutexdef r_Config_nextProtoOnce_m;Mutexdef r_Config_mu;Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_cleanUpResponse910 = [1] of {int};
	run cleanUpResponse91(r_wg,r_TLS_mutex,r_Config_TLSConfig_mutex,r_Config_ErrorLog_mu,r_Config_nextProtoOnce_m,r_Config_mu,r_mu,child_cleanUpResponse910);
	child_cleanUpResponse910?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype cleanUpResponse91(Wgdef r_wg;Mutexdef r_TLS_mutex;Mutexdef r_Config_TLSConfig_mutex;Mutexdef r_Config_ErrorLog_mu;Mutexdef r_Config_nextProtoOnce_m;Mutexdef r_Config_mu;Mutexdef r_mu;chan child) {
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

