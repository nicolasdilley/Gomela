// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/chrislusf/seaweedfs/blob//weed/shell/command_volume_balance_test.go#L175
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBalance1750 = [1] of {int};
	run TestBalance175(child_TestBalance1750);
	run receiver(child_TestBalance1750)
stop_process:skip
}

proctype TestBalance175(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_collectVolumeDiskTypes1592 = [1] of {int};
	chan child_collectVolumeReplicaLocations1561 = [1] of {int};
	chan child_collectVolumeServersByDc1410 = [1] of {int};
	Mutexdef topologyInfo_state_atomicMessageInfo_initMu;
	run mutexMonitor(topologyInfo_state_atomicMessageInfo_initMu);
	run collectVolumeServersByDc141(topologyInfo_state_atomicMessageInfo_initMu,child_collectVolumeServersByDc1410);
	child_collectVolumeServersByDc1410?0;
	run collectVolumeReplicaLocations156(topologyInfo_state_atomicMessageInfo_initMu,child_collectVolumeReplicaLocations1561);
	child_collectVolumeReplicaLocations1561?0;
	run collectVolumeDiskTypes159(topologyInfo_state_atomicMessageInfo_initMu,child_collectVolumeDiskTypes1592);
	child_collectVolumeDiskTypes1592?0;
	stop_process: skip;
	child!0
}
proctype collectVolumeServersByDc141(Mutexdef t_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_r_DataNodeInfos = -2; // opt var_r_DataNodeInfos
	int var_dc_RackInfos = -2; // opt var_dc_RackInfos
	int var_t_DataCenterInfos = -2; // opt var_t_DataCenterInfos
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype collectVolumeReplicaLocations156(Mutexdef topologyInfo_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_eachDataNode1081 = [1] of {int};
	int var_diskInfo_VolumeInfos = -2; // opt var_diskInfo_VolumeInfos
	int var_dn_DiskInfos = -2; // opt var_dn_DiskInfos
	run eachDataNode108(topologyInfo_state_atomicMessageInfo_initMu,child_eachDataNode1081);
	child_eachDataNode1081?0;
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
proctype collectVolumeDiskTypes159(Mutexdef t_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_knownTypes = -2; // opt var_knownTypes
	int var_dn_DiskInfos = -2; // opt var_dn_DiskInfos
	int var_r_DataNodeInfos = -2; // opt var_r_DataNodeInfos
	int var_dc_RackInfos = -2; // opt var_dc_RackInfos
	int var_t_DataCenterInfos = -2; // opt var_t_DataCenterInfos
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

proctype receiver(chan c) {
c?0
}

