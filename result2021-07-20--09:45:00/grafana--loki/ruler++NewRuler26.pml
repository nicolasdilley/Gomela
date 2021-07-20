// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grafana/loki/blob/aa544a9dffdb8e78f7d7ed8edafce466d333b0a8/pkg/ruler/ruler.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewRuler260 = [1] of {int};
	run NewRuler26(child_NewRuler260);
	run receiver(child_NewRuler260)
stop_process:skip
}

proctype NewRuler26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MultiTenantManagerAdapter720 = [1] of {int};
	Mutexdef mgr_notifiersMtx;
	Mutexdef mgr_userManagerMtx;
	run mutexMonitor(mgr_userManagerMtx);
	run mutexMonitor(mgr_notifiersMtx);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run MultiTenantManagerAdapter72(mgr_notifiersMtx,mgr_userManagerMtx,child_MultiTenantManagerAdapter720);
	child_MultiTenantManagerAdapter720?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MultiTenantManagerAdapter72(Mutexdef mgr_notifiersMtx;Mutexdef mgr_userManagerMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

