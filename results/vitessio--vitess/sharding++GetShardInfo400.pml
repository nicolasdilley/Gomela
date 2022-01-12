// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/test/endtoend/sharding/base_sharding.go#L400
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_GetShardInfo4000 = [1] of {int};
	run GetShardInfo400(child_GetShardInfo4000);
	run receiver(child_GetShardInfo4000)
stop_process:skip
}

proctype GetShardInfo400(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef shard_KeyRange_state_atomicMessageInfo_initMu;
	Mutexdef shard_PrimaryTermStartTime_state_atomicMessageInfo_initMu;
	Mutexdef shard_PrimaryAlias_state_atomicMessageInfo_initMu;
	Mutexdef shard_state_atomicMessageInfo_initMu;
	run mutexMonitor(shard_state_atomicMessageInfo_initMu);
	run mutexMonitor(shard_PrimaryAlias_state_atomicMessageInfo_initMu);
	run mutexMonitor(shard_PrimaryTermStartTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(shard_KeyRange_state_atomicMessageInfo_initMu);
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

