
// https://github.com/go-gitea/gitea/blob/master/modules/repofiles/diff.go#L15
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_GetDiffPreview150 = [1] of {int};
	run GetDiffPreview15(child_GetDiffPreview150)
stop_process:skip
}

proctype GetDiffPreview15(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close420 = [1] of {int};
	chan child_DiffIndex2885 = [1] of {int};
	chan child_AddObjectToIndex1444 = [1] of {int};
	chan child_HashObject1313 = [1] of {int};
	chan child_SetDefaultIndex772 = [1] of {int};
	chan child_Clone501 = [1] of {int};
	Mutexdef t_gitRepo_tagCache_lock;
	run mutexMonitor(t_gitRepo_tagCache_lock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Clone50(t_gitRepo_tagCache_lock,child_Clone501);
	child_Clone501?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run SetDefaultIndex77(t_gitRepo_tagCache_lock,child_SetDefaultIndex772);
	child_SetDefaultIndex772?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run HashObject131(t_gitRepo_tagCache_lock,child_HashObject1313);
	child_HashObject1313?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run AddObjectToIndex144(t_gitRepo_tagCache_lock,child_AddObjectToIndex1444);
	child_AddObjectToIndex1444?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run DiffIndex288(t_gitRepo_tagCache_lock,child_DiffIndex2885);
	child_DiffIndex2885?0;
	goto stop_process;
	stop_process: skip;
		run Close42(t_gitRepo_tagCache_lock,child_Close420);
	child_Close420?0;
	child!0
}
proctype Close42(Mutexdef t_gitRepo_tagCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close420 = [1] of {int};
	stop_process: skip;
		run Close42(t_gitRepo_tagCache_lock,child_Close420);
	child_Close420?0;
	child!0
}
proctype Clone50(Mutexdef t_gitRepo_tagCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef gitRepo_tagCache_lock;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
		fi
	:: true;
	fi;
	run mutexMonitor(gitRepo_tagCache_lock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetDefaultIndex77(Mutexdef t_gitRepo_tagCache_lock;chan child) {
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
proctype HashObject131(Mutexdef t_gitRepo_tagCache_lock;chan child) {
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
proctype AddObjectToIndex144(Mutexdef t_gitRepo_tagCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DiffIndex288(Mutexdef t_gitRepo_tagCache_lock;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
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

