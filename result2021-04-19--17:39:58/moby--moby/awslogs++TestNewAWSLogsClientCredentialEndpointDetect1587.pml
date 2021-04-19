
// https://github.com/moby/moby/blob/master/daemon/logger/awslogs/cloudwatchlogs_test.go#L1587
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
	chan child_TestNewAWSLogsClientCredentialEndpointDetect15870 = [1] of {int};
	run TestNewAWSLogsClientCredentialEndpointDetect1587(child_TestNewAWSLogsClientCredentialEndpointDetect15870)
stop_process:skip
}

proctype TestNewAWSLogsClientCredentialEndpointDetect1587(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef testServer_mu;
	Wgdef testServer_wg;
	Mutexdef testServer_Config_mu;
	Mutexdef testServer_Config_nextProtoOnce_m;
	Mutexdef testServer_Config_ErrorLog_mu;
	Mutexdef testServer_Config_TLSConfig_mutex;
	Mutexdef testServer_TLS_mutex;
	run mutexMonitor(testServer_TLS_mutex);
	run mutexMonitor(testServer_Config_TLSConfig_mutex);
	run mutexMonitor(testServer_Config_ErrorLog_mu);
	run mutexMonitor(testServer_Config_nextProtoOnce_m);
	run mutexMonitor(testServer_Config_mu);
	run wgMonitor(testServer_wg);
	run mutexMonitor(testServer_mu);
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

