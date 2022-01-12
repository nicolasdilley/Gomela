// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/chrislusf/seaweedfs/blob//weed/topology/volume_growth_test.go#L316
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFindEmptySlotsForOneVolumeScheduleByWeight3160 = [1] of {int};
	run TestFindEmptySlotsForOneVolumeScheduleByWeight316(child_TestFindEmptySlotsForOneVolumeScheduleByWeight3160);
	run receiver(child_TestFindEmptySlotsForOneVolumeScheduleByWeight3160)
stop_process:skip
}

proctype TestFindEmptySlotsForOneVolumeScheduleByWeight316(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_findEmptySlotsForOneVolume1231 = [1] of {int};
	chan child_findEmptySlotsForOneVolume1230 = [1] of {int};
	Mutexdef vg_accessLock;
	Mutexdef topo_ecShardMapLock;
	int var_distribution = -2; // opt var_distribution
	int var_servers = -2; // opt var_servers
	run mutexMonitor(topo_ecShardMapLock);
	run mutexMonitor(vg_accessLock);
	

	if
	:: 0 != -2 && 1000-1 != -3 -> 
				for(i : 0.. 1000-1) {
			for19: skip;
			run findEmptySlotsForOneVolume123(vg_accessLock,topo_ecShardMapLock,child_findEmptySlotsForOneVolume1231);
			child_findEmptySlotsForOneVolume1231?0;
			for19_end: skip
		};
		for19_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run findEmptySlotsForOneVolume123(vg_accessLock,topo_ecShardMapLock,child_findEmptySlotsForOneVolume1230);
			child_findEmptySlotsForOneVolume1230?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype findEmptySlotsForOneVolume123(Mutexdef vg_accessLock;Mutexdef topo_ecShardMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_otherDataCenters = -2; // opt var_otherDataCenters
	int var_otherRacks = -2; // opt var_otherRacks
	int var_otherServers = -2; // opt var_otherServers
	int var_rack_Children = -2; // opt var_rack_Children
	int var_node_Children = -2; // opt var_node_Children
	

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

proctype receiver(chan c) {
c?0
}

