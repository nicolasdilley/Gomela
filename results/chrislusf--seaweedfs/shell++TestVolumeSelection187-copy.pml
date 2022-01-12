// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/chrislusf/seaweedfs/blob//weed/shell/command_volume_balance_test.go#L187
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestVolumeSelection1870 = [1] of {int};
	run TestVolumeSelection187(child_TestVolumeSelection1870);
	run receiver(child_TestVolumeSelection1870)
stop_process:skip
}

proctype TestVolumeSelection187(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_collectVolumeIdsForTierChange2050 = [1] of {int};
	Mutexdef topologyInfo_state_atomicMessageInfo_initMu;
	run mutexMonitor(topologyInfo_state_atomicMessageInfo_initMu);
	run collectVolumeIdsForTierChange205(topologyInfo_state_atomicMessageInfo_initMu,child_collectVolumeIdsForTierChange2050);
	child_collectVolumeIdsForTierChange2050?0;
	stop_process: skip;
	child!0
}
proctype collectVolumeIdsForTierChange205(Mutexdef topologyInfo_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_eachDataNode1080 = [1] of {int};
	int var_vidMap = -2; // opt var_vidMap
	int var_diskInfo_VolumeInfos = -2; // opt var_diskInfo_VolumeInfos
	int var_dn_DiskInfos = -2; // opt var_dn_DiskInfos
	run eachDataNode108(topologyInfo_state_atomicMessageInfo_initMu,child_eachDataNode1080);
	child_eachDataNode1080?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype eachDataNode108(Mutexdef topo_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_rack_DataNodeInfos = -2; // opt var_rack_DataNodeInfos
	int var_dc_RackInfos = -2; // opt var_dc_RackInfos
	int var_topo_DataCenterInfos = -2; // opt var_topo_DataCenterInfos
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

proctype receiver(chan c) {
c?0
}

