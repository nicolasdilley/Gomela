
// https://github.com/go-gitea/gitea/blob/master/modules/test/context_tests.go#L27
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_MockContext270 = [1] of {int};
	run MockContext27(child_MockContext270)
stop_process:skip
}

proctype MockContext27(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ctx_Repo_GitRepo_tagCache_lock;
	Mutexdef ctx_Repo_Tag_repo_tagCache_lock;
	Mutexdef ctx_Repo_Commit_submoduleCache_lock;
	run mutexMonitor(ctx_Repo_Commit_submoduleCache_lock);
	run mutexMonitor(ctx_Repo_Tag_repo_tagCache_lock);
	run mutexMonitor(ctx_Repo_GitRepo_tagCache_lock);
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

