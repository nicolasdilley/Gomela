// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/auth/access_test.go#L31
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUpsertDeleteRoleEventsEmitted310 = [1] of {int};
	run TestUpsertDeleteRoleEventsEmitted31(child_TestUpsertDeleteRoleEventsEmitted310);
	run receiver(child_TestUpsertDeleteRoleEventsEmitted310)
stop_process:skip
}

proctype TestUpsertDeleteRoleEventsEmitted31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DeleteRole533 = [1] of {int};
	chan child_DeleteRole532 = [1] of {int};
	chan child_UpsertRole301 = [1] of {int};
	chan child_UpsertRole300 = [1] of {int};
	Mutexdef p_mockEmitter_mtx;
	Mutexdef p_a_lock;
	run mutexMonitor(p_a_lock);
	run mutexMonitor(p_mockEmitter_mtx);
	run UpsertRole30(p_a_lock,child_UpsertRole300);
	child_UpsertRole300?0;
	run UpsertRole30(p_a_lock,child_UpsertRole301);
	child_UpsertRole301?0;
	run DeleteRole53(p_a_lock,child_DeleteRole532);
	child_DeleteRole532?0;
	run DeleteRole53(p_a_lock,child_DeleteRole533);
	child_DeleteRole533?0;
	stop_process: skip;
	child!0
}
proctype UpsertRole30(Mutexdef a_lock;chan child) {
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
proctype DeleteRole53(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_a_GetRoles = -2; // opt var_a_GetRoles
	int var_cas = -2; // opt var_cas
	int var_u_GetRoles = -2; // opt var_u_GetRoles
	int var_users = -2; // opt var_users
	

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

