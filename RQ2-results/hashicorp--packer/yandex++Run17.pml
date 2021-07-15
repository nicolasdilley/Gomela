
// https://github.com/hashicorp/packer/blob/master/builder/yandex/step_instance_info.go#L17
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
	chan child_Run170 = [1] of {int};
	run Run17(child_Run170)
stop_process:skip
}

proctype Run17(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getInstanceIPAddress470 = [1] of {int};
	Mutexdef instance_PlacementPolicy_state_atomicMessageInfo_initMu;
	Mutexdef instance_NetworkSettings_state_atomicMessageInfo_initMu;
	Mutexdef instance_SchedulingPolicy_state_atomicMessageInfo_initMu;
	Mutexdef instance_BootDisk_state_atomicMessageInfo_initMu;
	Mutexdef instance_Resources_state_atomicMessageInfo_initMu;
	Mutexdef instance_CreatedAt_state_atomicMessageInfo_initMu;
	Mutexdef instance_state_atomicMessageInfo_initMu;
	Mutexdef sdk_muErr;
	Wgdef sdk_initCall_callState_wg;
	Mutexdef sdk_initCall_mu;
	Mutexdef sdk_endpoints_mu;
	Mutexdef sdk_conf_TLSConfig_mutex;
	run mutexMonitor(sdk_conf_TLSConfig_mutex);
	run mutexMonitor(sdk_endpoints_mu);
	run mutexMonitor(sdk_initCall_mu);
	run wgMonitor(sdk_initCall_callState_wg);
	run mutexMonitor(sdk_muErr);
	run mutexMonitor(instance_state_atomicMessageInfo_initMu);
	run mutexMonitor(instance_CreatedAt_state_atomicMessageInfo_initMu);
	run mutexMonitor(instance_Resources_state_atomicMessageInfo_initMu);
	run mutexMonitor(instance_BootDisk_state_atomicMessageInfo_initMu);
	run mutexMonitor(instance_SchedulingPolicy_state_atomicMessageInfo_initMu);
	run mutexMonitor(instance_NetworkSettings_state_atomicMessageInfo_initMu);
	run mutexMonitor(instance_PlacementPolicy_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getInstanceIPAddress47(instance_state_atomicMessageInfo_initMu,instance_CreatedAt_state_atomicMessageInfo_initMu,instance_Resources_state_atomicMessageInfo_initMu,instance_BootDisk_state_atomicMessageInfo_initMu,instance_SchedulingPolicy_state_atomicMessageInfo_initMu,instance_NetworkSettings_state_atomicMessageInfo_initMu,instance_PlacementPolicy_state_atomicMessageInfo_initMu,child_getInstanceIPAddress470);
	child_getInstanceIPAddress470?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getInstanceIPAddress47(Mutexdef instance_state_atomicMessageInfo_initMu;Mutexdef instance_CreatedAt_state_atomicMessageInfo_initMu;Mutexdef instance_Resources_state_atomicMessageInfo_initMu;Mutexdef instance_BootDisk_state_atomicMessageInfo_initMu;Mutexdef instance_SchedulingPolicy_state_atomicMessageInfo_initMu;Mutexdef instance_NetworkSettings_state_atomicMessageInfo_initMu;Mutexdef instance_PlacementPolicy_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_instanceAddresses740 = [1] of {int};
	run instanceAddresses74(instance_state_atomicMessageInfo_initMu,instance_CreatedAt_state_atomicMessageInfo_initMu,instance_Resources_state_atomicMessageInfo_initMu,instance_BootDisk_state_atomicMessageInfo_initMu,instance_SchedulingPolicy_state_atomicMessageInfo_initMu,instance_NetworkSettings_state_atomicMessageInfo_initMu,instance_PlacementPolicy_state_atomicMessageInfo_initMu,child_instanceAddresses740);
	child_instanceAddresses740?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype instanceAddresses74(Mutexdef instance_state_atomicMessageInfo_initMu;Mutexdef instance_CreatedAt_state_atomicMessageInfo_initMu;Mutexdef instance_Resources_state_atomicMessageInfo_initMu;Mutexdef instance_BootDisk_state_atomicMessageInfo_initMu;Mutexdef instance_SchedulingPolicy_state_atomicMessageInfo_initMu;Mutexdef instance_NetworkSettings_state_atomicMessageInfo_initMu;Mutexdef instance_PlacementPolicy_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

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

