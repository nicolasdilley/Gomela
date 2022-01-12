// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/grafana/k6/blob//lib/netext/httpext/request_test.go#L316
#define def_var_testCases329  3 // mand testCases line 329
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
	chan child_TestTrailFailed3160 = [1] of {int};
	run TestTrailFailed316(child_TestTrailFailed3160);
	run receiver(child_TestTrailFailed3160)
stop_process:skip
}

proctype TestTrailFailed316(chan child) {
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
	int var_sample_GetSamples = -2; // opt var_sample_GetSamples
	int var_testCases = def_var_testCases329; // mand var_testCases
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

proctype receiver(chan c) {
c?0
}

