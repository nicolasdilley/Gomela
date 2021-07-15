
// https://github.com/hashicorp/vault/blob/master/builtin/logical/database/version_wrapper.go#L77
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewUser770 = [1] of {int};
	run NewUser77(child_NewUser770)
stop_process:skip
}

proctype NewUser77(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CreateUser520 = [1] of {int};
	Mutexdef usernameConfig_state_atomicMessageInfo_initMu;
	Mutexdef stmts_state_atomicMessageInfo_initMu;
	

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
	run mutexMonitor(stmts_state_atomicMessageInfo_initMu);
	run mutexMonitor(usernameConfig_state_atomicMessageInfo_initMu);
	run CreateUser52(stmts_state_atomicMessageInfo_initMu,usernameConfig_state_atomicMessageInfo_initMu,child_CreateUser520);
	child_CreateUser520?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype CreateUser52(Mutexdef statements_state_atomicMessageInfo_initMu;Mutexdef usernameConfig_state_atomicMessageInfo_initMu;chan child) {
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

