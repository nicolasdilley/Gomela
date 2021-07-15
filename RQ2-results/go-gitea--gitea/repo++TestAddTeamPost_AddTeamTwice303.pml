
// https://github.com/go-gitea/gitea/blob/master/routers/repo/settings_test.go#L303
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAddTeamPost_AddTeamTwice3030 = [1] of {int};
	run TestAddTeamPost_AddTeamTwice303(child_TestAddTeamPost_AddTeamTwice3030)
stop_process:skip
}

proctype TestAddTeamPost_AddTeamTwice303(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AddTeamPost7471 = [1] of {int};
	chan child_AddTeamPost7470 = [1] of {int};
	Mutexdef repo_GitRepo_tagCache_lock;
	Mutexdef repo_Tag_repo_tagCache_lock;
	Mutexdef repo_Commit_submoduleCache_lock;
	Mutexdef ctx_Repo_GitRepo_tagCache_lock;
	Mutexdef ctx_Repo_Tag_repo_tagCache_lock;
	Mutexdef ctx_Repo_Commit_submoduleCache_lock;
	run mutexMonitor(ctx_Repo_Commit_submoduleCache_lock);
	run mutexMonitor(ctx_Repo_Tag_repo_tagCache_lock);
	run mutexMonitor(ctx_Repo_GitRepo_tagCache_lock);
	run mutexMonitor(repo_Commit_submoduleCache_lock);
	run mutexMonitor(repo_Tag_repo_tagCache_lock);
	run mutexMonitor(repo_GitRepo_tagCache_lock);
	run AddTeamPost747(ctx_Repo_Commit_submoduleCache_lock,ctx_Repo_Tag_repo_tagCache_lock,ctx_Repo_GitRepo_tagCache_lock,child_AddTeamPost7470);
	child_AddTeamPost7470?0;
	run AddTeamPost747(ctx_Repo_Commit_submoduleCache_lock,ctx_Repo_Tag_repo_tagCache_lock,ctx_Repo_GitRepo_tagCache_lock,child_AddTeamPost7471);
	child_AddTeamPost7471?0;
	stop_process: skip;
	child!0
}
proctype AddTeamPost747(Mutexdef ctx_Repo_Commit_submoduleCache_lock;Mutexdef ctx_Repo_Tag_repo_tagCache_lock;Mutexdef ctx_Repo_GitRepo_tagCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

