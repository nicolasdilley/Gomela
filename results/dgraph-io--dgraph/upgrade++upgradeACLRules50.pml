
// https://github.com/dgraph-io/dgraph/blob/master/upgrade/change_v20.03.0.go#L50
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_upgradeACLRules500 = [1] of {int};
	run upgradeACLRules50(child_upgradeACLRules500)
stop_process:skip
}

proctype upgradeACLRules50(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_alterWithClient2252 = [1] of {int};
	chan child_mutateWithClient1991 = [1] of {int};
	chan child_getQueryResult1760 = [1] of {int};
	Mutexdef dg_jwtMutex;
	run mutexMonitor(dg_jwtMutex);
	run getQueryResult176(dg_jwtMutex,child_getQueryResult1760);
	child_getQueryResult1760?0;
	

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
	run mutateWithClient199(dg_jwtMutex,child_mutateWithClient1991);
	child_mutateWithClient1991?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run alterWithClient225(dg_jwtMutex,child_alterWithClient2252);
		child_alterWithClient2252?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getQueryResult176(Mutexdef dg_jwtMutex;chan child) {
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
proctype mutateWithClient199(Mutexdef dg_jwtMutex;chan child) {
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
proctype alterWithClient225(Mutexdef dg_jwtMutex;chan child) {
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

