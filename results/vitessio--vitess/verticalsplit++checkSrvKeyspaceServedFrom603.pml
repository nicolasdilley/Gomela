// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/test/endtoend/sharding/verticalsplit/vertical_split_test.go#L603
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_checkSrvKeyspaceServedFrom6030 = [1] of {int};
	run checkSrvKeyspaceServedFrom603(child_checkSrvKeyspaceServedFrom6030);
	run receiver(child_checkSrvKeyspaceServedFrom6030)
stop_process:skip
}

proctype checkSrvKeyspaceServedFrom603(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetShardingColumnName9762 = [1] of {int};
	chan child_GetShardingColumnName9761 = [1] of {int};
	chan child_GetServedFrom9900 = [1] of {int};
	Mutexdef srvKeyspace_state_atomicMessageInfo_initMu;
	int var_srvKeyspace_GetServedFrom = -2; // opt var_srvKeyspace_GetServedFrom
	run mutexMonitor(srvKeyspace_state_atomicMessageInfo_initMu);
	run GetServedFrom990(srvKeyspace_state_atomicMessageInfo_initMu,child_GetServedFrom9900);
	child_GetServedFrom9900?0;
	run GetShardingColumnName976(srvKeyspace_state_atomicMessageInfo_initMu,child_GetShardingColumnName9761);
	child_GetShardingColumnName9761?0;
	run GetShardingColumnName976(srvKeyspace_state_atomicMessageInfo_initMu,child_GetShardingColumnName9762);
	child_GetShardingColumnName9762?0;
	stop_process: skip;
	child!0
}
proctype GetServedFrom990(Mutexdef x_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetShardingColumnName976(Mutexdef x_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

