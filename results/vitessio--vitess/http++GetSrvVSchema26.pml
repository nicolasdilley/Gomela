// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtadmin/http/srvvschemas.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_GetSrvVSchema260 = [1] of {int};
	run GetSrvVSchema26(child_GetSrvVSchema260);
	run receiver(child_GetSrvVSchema260)
stop_process:skip
}

proctype GetSrvVSchema26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewJSONResponse450 = [1] of {int};
	Mutexdef sv_SrvVSchema_state_atomicMessageInfo_initMu;
	Mutexdef sv_Cluster_state_atomicMessageInfo_initMu;
	Mutexdef sv_state_atomicMessageInfo_initMu;
	run mutexMonitor(sv_state_atomicMessageInfo_initMu);
	run mutexMonitor(sv_Cluster_state_atomicMessageInfo_initMu);
	run mutexMonitor(sv_SrvVSchema_state_atomicMessageInfo_initMu);
	run NewJSONResponse45(sv_Cluster_state_atomicMessageInfo_initMu,sv_SrvVSchema_state_atomicMessageInfo_initMu,sv_state_atomicMessageInfo_initMu,child_NewJSONResponse450);
	child_NewJSONResponse450?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewJSONResponse45(Mutexdef value_Cluster_state_atomicMessageInfo_initMu;Mutexdef value_SrvVSchema_state_atomicMessageInfo_initMu;Mutexdef value_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
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

