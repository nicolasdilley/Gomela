
// https://github.com/hashicorp/vault/blob/master/vault/seal/envelope_test.go#L8
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEnvelope80 = [1] of {int};
	run TestEnvelope8(child_TestEnvelope80)
stop_process:skip
}

proctype TestEnvelope8(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Decrypt310 = [1] of {int};
	Mutexdef env_state_atomicMessageInfo_initMu;
	run mutexMonitor(env_state_atomicMessageInfo_initMu);
	run Decrypt31(env_state_atomicMessageInfo_initMu,child_Decrypt310);
	child_Decrypt310?0;
	stop_process: skip;
	child!0
}
proctype Decrypt31(Mutexdef data_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Decrypt310 = [1] of {int};
	run Decrypt31(data_state_atomicMessageInfo_initMu,child_Decrypt310);
	child_Decrypt310?0;
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

