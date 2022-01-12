// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/auth/access_test.go#L71
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUpsertDeleteLockEventsEmitted710 = [1] of {int};
	run TestUpsertDeleteLockEventsEmitted71(child_TestUpsertDeleteLockEventsEmitted710);
	run receiver(child_TestUpsertDeleteLockEventsEmitted710)
stop_process:skip
}

proctype TestUpsertDeleteLockEventsEmitted71(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DeleteLock1334 = [1] of {int};
	chan child_DeleteLock1333 = [1] of {int};
	chan child_UpsertLock1092 = [1] of {int};
	chan child_UpsertLock1091 = [1] of {int};
	chan child_UpsertLock1090 = [1] of {int};
	Mutexdef p_mockEmitter_mtx;
	Mutexdef p_a_lock;
	run mutexMonitor(p_a_lock);
	run mutexMonitor(p_mockEmitter_mtx);
	run UpsertLock109(p_a_lock,child_UpsertLock1090);
	child_UpsertLock1090?0;
	run UpsertLock109(p_a_lock,child_UpsertLock1091);
	child_UpsertLock1091?0;
	run UpsertLock109(p_a_lock,child_UpsertLock1092);
	child_UpsertLock1092?0;
	run DeleteLock133(p_a_lock,child_DeleteLock1333);
	child_DeleteLock1333?0;
	run DeleteLock133(p_a_lock,child_DeleteLock1334);
	child_DeleteLock1334?0;
	stop_process: skip;
	child!0
}
proctype UpsertLock109(Mutexdef a_lock;chan child) {
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
proctype DeleteLock133(Mutexdef a_lock;chan child) {
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

