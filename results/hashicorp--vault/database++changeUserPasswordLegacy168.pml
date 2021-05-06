
// https://github.com/hashicorp/vault/blob/master/builtin/logical/database/version_wrapper.go#L168
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_changeUserPasswordLegacy1680 = [1] of {int};
	run changeUserPasswordLegacy168(child_changeUserPasswordLegacy1680)
stop_process:skip
}

proctype changeUserPasswordLegacy168(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetCredentials970 = [1] of {int};
	Mutexdef staticConfig_state_atomicMessageInfo_initMu;
	Mutexdef stmts_state_atomicMessageInfo_initMu;
	run mutexMonitor(stmts_state_atomicMessageInfo_initMu);
	run mutexMonitor(staticConfig_state_atomicMessageInfo_initMu);
	run SetCredentials97(stmts_state_atomicMessageInfo_initMu,staticConfig_state_atomicMessageInfo_initMu,child_SetCredentials970);
	child_SetCredentials970?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetCredentials97(Mutexdef statements_state_atomicMessageInfo_initMu;Mutexdef staticConfig_state_atomicMessageInfo_initMu;chan child) {
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

