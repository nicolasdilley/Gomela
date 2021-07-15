
// https://github.com/go-gitea/gitea/blob/master/services/pull/pull.go#L206
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_checkForInvalidation2060 = [1] of {int};
	run checkForInvalidation206(child_checkForInvalidation2060)
stop_process:skip
}

proctype checkForInvalidation206(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymouscheckForInvalidation2152110 = [1] of {int};
	Mutexdef gitRepo_tagCache_lock;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(gitRepo_tagCache_lock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run AnonymouscheckForInvalidation215211(gitRepo_tagCache_lock,child_AnonymouscheckForInvalidation2152110);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymouscheckForInvalidation215211(Mutexdef gitRepo_tagCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

