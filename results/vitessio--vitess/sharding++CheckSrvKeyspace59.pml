// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/test/endtoend/sharding/base_sharding.go#L59
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_CheckSrvKeyspace590 = [1] of {int};
	run CheckSrvKeyspace59(child_CheckSrvKeyspace590);
	run receiver(child_CheckSrvKeyspace590)
stop_process:skip
}

proctype CheckSrvKeyspace59(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef srvKeyspace_state_atomicMessageInfo_initMu;
	int var_partition_ShardReferences = -2; // opt var_partition_ShardReferences
	int var_srvKeyspace_Partitions = -2; // opt var_srvKeyspace_Partitions
	run mutexMonitor(srvKeyspace_state_atomicMessageInfo_initMu);
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

