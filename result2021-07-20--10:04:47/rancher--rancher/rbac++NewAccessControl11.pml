// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rancher/rancher/blob/91a6f51f259acd5670ff167d6bcf1916da7406f1/pkg/rbac/access_control.go#L11
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewAccessControl110 = [1] of {int};
	run NewAccessControl11(child_NewAccessControl110);
	run receiver(child_NewAccessControl110)
stop_process:skip
}

proctype NewAccessControl11(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewAccessControlWithASL160 = [1] of {int};
	Mutexdef asl_cache_lock;
	run mutexMonitor(asl_cache_lock);
	run NewAccessControlWithASL16(asl_cache_lock,child_NewAccessControlWithASL160);
	child_NewAccessControlWithASL160?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewAccessControlWithASL16(Mutexdef asl_cache_lock;chan child) {
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

