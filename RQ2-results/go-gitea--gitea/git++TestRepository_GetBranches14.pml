
// https://github.com/go-gitea/gitea/blob/master/modules/git/repo_branch_test.go#L14
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRepository_GetBranches140 = [1] of {int};
	run TestRepository_GetBranches14(child_TestRepository_GetBranches140)
stop_process:skip
}

proctype TestRepository_GetBranches14(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close390 = [1] of {int};
	chan child_GetBranches263 = [1] of {int};
	chan child_GetBranches262 = [1] of {int};
	chan child_GetBranches261 = [1] of {int};
	Mutexdef bareRepo1_tagCache_lock;
	run mutexMonitor(bareRepo1_tagCache_lock);
	run GetBranches26(bareRepo1_tagCache_lock,child_GetBranches261);
	child_GetBranches261?0;
	run GetBranches26(bareRepo1_tagCache_lock,child_GetBranches262);
	child_GetBranches262?0;
	run GetBranches26(bareRepo1_tagCache_lock,child_GetBranches263);
	child_GetBranches263?0;
	stop_process: skip;
		run Close39(bareRepo1_tagCache_lock,child_Close390);
	child_Close390?0;
	child!0
}
proctype Close39(Mutexdef repo_tagCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype GetBranches26(Mutexdef repo_tagCache_lock;chan child) {
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

