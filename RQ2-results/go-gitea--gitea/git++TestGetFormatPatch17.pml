
// https://github.com/go-gitea/gitea/blob/master/modules/git/repo_compare_test.go#L17
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetFormatPatch170 = [1] of {int};
	run TestGetFormatPatch17(child_TestGetFormatPatch170)
stop_process:skip
}

proctype TestGetFormatPatch17(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close390 = [1] of {int};
	chan child_GetPatch2211 = [1] of {int};
	Mutexdef repo_tagCache_lock;
	run mutexMonitor(repo_tagCache_lock);
	run GetPatch221(repo_tagCache_lock,child_GetPatch2211);
	child_GetPatch2211?0;
	stop_process: skip;
		run Close39(repo_tagCache_lock,child_Close390);
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
proctype GetPatch221(Mutexdef repo_tagCache_lock;chan child) {
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

