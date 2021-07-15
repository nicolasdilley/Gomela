
// https://github.com/go-gitea/gitea/blob/master/modules/git/repo_blob_test.go#L16
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRepository_GetBlob_Found160 = [1] of {int};
	run TestRepository_GetBlob_Found16(child_TestRepository_GetBlob_Found160)
stop_process:skip
}

proctype TestRepository_GetBlob_Found16(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close390 = [1] of {int};
	chan child_GetBlob81 = [1] of {int};
	chan child_GetBlob82 = [1] of {int};
	Mutexdef r_tagCache_lock;
	int testCases = -2;
	run mutexMonitor(r_tagCache_lock);
	

	if
	:: testCases-1 != -3 -> 
				for(i : 0.. testCases-1) {
			for10: skip;
			run GetBlob8(r_tagCache_lock,child_GetBlob81);
			child_GetBlob81?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run GetBlob8(r_tagCache_lock,child_GetBlob82);
			child_GetBlob82?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
		run Close39(r_tagCache_lock,child_Close390);
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
proctype GetBlob8(Mutexdef repo_tagCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getBlob91 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getBlob9(repo_tagCache_lock,child_getBlob91);
	child_getBlob91?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getBlob9(Mutexdef repo_tagCache_lock;chan child) {
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

