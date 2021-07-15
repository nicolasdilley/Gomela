
// https://github.com/go-gitea/gitea/blob/master/modules/git/tree_entry.go#L140
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Less1400 = [1] of {int};
	run Less140(child_Less1400)
stop_process:skip
}

proctype Less140(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef t2_ptree_repo_tagCache_lock;
	Mutexdef t1_ptree_repo_tagCache_lock;
	run mutexMonitor(t1_ptree_repo_tagCache_lock);
	run mutexMonitor(t2_ptree_repo_tagCache_lock);
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

