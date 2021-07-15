
// https://github.com/istio/istio/blob/master/pilot/pkg/xds/filters/filters.go#L172
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_buildHTTPMxFilter1720 = [1] of {int};
	run buildHTTPMxFilter172(child_buildHTTPMxFilter1720)
stop_process:skip
}

proctype buildHTTPMxFilter172(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef typed_state_atomicMessageInfo_initMu;
	Mutexdef httpMxConfigProto_Config_CapabilityRestrictionConfig_state_atomicMessageInfo_initMu;
	Mutexdef httpMxConfigProto_Config_Configuration_state_atomicMessageInfo_initMu;
	Mutexdef httpMxConfigProto_Config_state_atomicMessageInfo_initMu;
	Mutexdef httpMxConfigProto_state_atomicMessageInfo_initMu;
	Mutexdef vmConfig_VmConfig_EnvironmentVariables_state_atomicMessageInfo_initMu;
	Mutexdef vmConfig_VmConfig_Configuration_state_atomicMessageInfo_initMu;
	Mutexdef vmConfig_VmConfig_Code_state_atomicMessageInfo_initMu;
	Mutexdef vmConfig_VmConfig_state_atomicMessageInfo_initMu;
	run mutexMonitor(vmConfig_VmConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(vmConfig_VmConfig_Code_state_atomicMessageInfo_initMu);
	run mutexMonitor(vmConfig_VmConfig_Configuration_state_atomicMessageInfo_initMu);
	run mutexMonitor(vmConfig_VmConfig_EnvironmentVariables_state_atomicMessageInfo_initMu);
	run mutexMonitor(httpMxConfigProto_state_atomicMessageInfo_initMu);
	run mutexMonitor(httpMxConfigProto_Config_state_atomicMessageInfo_initMu);
	run mutexMonitor(httpMxConfigProto_Config_Configuration_state_atomicMessageInfo_initMu);
	run mutexMonitor(httpMxConfigProto_Config_CapabilityRestrictionConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(typed_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
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

