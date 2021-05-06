
// https://github.com/istio/istio/blob/master/pkg/envoy/instance_test.go#L206
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHotRestart2060 = [1] of {int};
	run TestHotRestart206(child_TestHotRestart2060)
stop_process:skip
}

proctype TestHotRestart206(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef info_Node_Locality_state_atomicMessageInfo_initMu;
	Mutexdef info_Node_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef info_Node_state_atomicMessageInfo_initMu;
	Mutexdef info_CommandLineOptions_ParentShutdownTime_state_atomicMessageInfo_initMu;
	Mutexdef info_CommandLineOptions_DrainTime_state_atomicMessageInfo_initMu;
	Mutexdef info_CommandLineOptions_FileFlushInterval_state_atomicMessageInfo_initMu;
	Mutexdef info_CommandLineOptions_state_atomicMessageInfo_initMu;
	Mutexdef info_UptimeAllEpochs_state_atomicMessageInfo_initMu;
	Mutexdef info_UptimeCurrentEpoch_state_atomicMessageInfo_initMu;
	Mutexdef info_state_atomicMessageInfo_initMu;
	run mutexMonitor(info_state_atomicMessageInfo_initMu);
	run mutexMonitor(info_UptimeCurrentEpoch_state_atomicMessageInfo_initMu);
	run mutexMonitor(info_UptimeAllEpochs_state_atomicMessageInfo_initMu);
	run mutexMonitor(info_CommandLineOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(info_CommandLineOptions_FileFlushInterval_state_atomicMessageInfo_initMu);
	run mutexMonitor(info_CommandLineOptions_DrainTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(info_CommandLineOptions_ParentShutdownTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(info_Node_state_atomicMessageInfo_initMu);
	run mutexMonitor(info_Node_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(info_Node_Locality_state_atomicMessageInfo_initMu);
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

