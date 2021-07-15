
// https://github.com/hashicorp/terraform/blob/master/backend/remote-state/artifactory/client_test.go#L16
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestArtifactoryFactory160 = [1] of {int};
	run TestArtifactoryFactory16(child_TestArtifactoryFactory160)
stop_process:skip
}

proctype TestArtifactoryFactory16(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef artifactoryClient_nativeClient_Transport_nextProtoOnce_m;
	Mutexdef artifactoryClient_nativeClient_Transport_TLSClientConfig_mutex;
	Mutexdef artifactoryClient_nativeClient_Transport_connsPerHostMu;
	Mutexdef artifactoryClient_nativeClient_Transport_altMu;
	Mutexdef artifactoryClient_nativeClient_Transport_reqMu;
	Mutexdef artifactoryClient_nativeClient_Transport_idleMu;
	Mutexdef artifactoryClient_nativeClient_Config_Transport_nextProtoOnce_m;
	Mutexdef artifactoryClient_nativeClient_Config_Transport_TLSClientConfig_mutex;
	Mutexdef artifactoryClient_nativeClient_Config_Transport_connsPerHostMu;
	Mutexdef artifactoryClient_nativeClient_Config_Transport_altMu;
	Mutexdef artifactoryClient_nativeClient_Config_Transport_reqMu;
	Mutexdef artifactoryClient_nativeClient_Config_Transport_idleMu;
	run mutexMonitor(artifactoryClient_nativeClient_Config_Transport_idleMu);
	run mutexMonitor(artifactoryClient_nativeClient_Config_Transport_reqMu);
	run mutexMonitor(artifactoryClient_nativeClient_Config_Transport_altMu);
	run mutexMonitor(artifactoryClient_nativeClient_Config_Transport_connsPerHostMu);
	run mutexMonitor(artifactoryClient_nativeClient_Config_Transport_TLSClientConfig_mutex);
	run mutexMonitor(artifactoryClient_nativeClient_Config_Transport_nextProtoOnce_m);
	run mutexMonitor(artifactoryClient_nativeClient_Transport_idleMu);
	run mutexMonitor(artifactoryClient_nativeClient_Transport_reqMu);
	run mutexMonitor(artifactoryClient_nativeClient_Transport_altMu);
	run mutexMonitor(artifactoryClient_nativeClient_Transport_connsPerHostMu);
	run mutexMonitor(artifactoryClient_nativeClient_Transport_TLSClientConfig_mutex);
	run mutexMonitor(artifactoryClient_nativeClient_Transport_nextProtoOnce_m);
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

