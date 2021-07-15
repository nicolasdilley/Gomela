
// https://github.com/hashicorp/vault/blob/master/vault/expiration_test.go#L2092
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLeaseEntry20920 = [1] of {int};
	run TestLeaseEntry2092(child_TestLeaseEntry20920)
stop_process:skip
}

proctype TestLeaseEntry2092(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_renewable23216 = [1] of {int};
	chan child_renewable23215 = [1] of {int};
	chan child_renewable23214 = [1] of {int};
	chan child_renewable23213 = [1] of {int};
	chan child_renewable23212 = [1] of {int};
	chan child_renewable23211 = [1] of {int};
	Mutexdef out_Auth_Alias_state_atomicMessageInfo_initMu;
	chan child_encode23170 = [1] of {int};
	Mutexdef le_Auth_Alias_state_atomicMessageInfo_initMu;
	run mutexMonitor(le_Auth_Alias_state_atomicMessageInfo_initMu);
	run encode2317(le_Auth_Alias_state_atomicMessageInfo_initMu,child_encode23170);
	child_encode23170?0;
	run mutexMonitor(out_Auth_Alias_state_atomicMessageInfo_initMu);
	run renewable2321(le_Auth_Alias_state_atomicMessageInfo_initMu,child_renewable23211);
	child_renewable23211?0;
	run renewable2321(le_Auth_Alias_state_atomicMessageInfo_initMu,child_renewable23212);
	child_renewable23212?0;
	run renewable2321(le_Auth_Alias_state_atomicMessageInfo_initMu,child_renewable23213);
	child_renewable23213?0;
	run renewable2321(le_Auth_Alias_state_atomicMessageInfo_initMu,child_renewable23214);
	child_renewable23214?0;
	run renewable2321(le_Auth_Alias_state_atomicMessageInfo_initMu,child_renewable23215);
	child_renewable23215?0;
	run renewable2321(le_Auth_Alias_state_atomicMessageInfo_initMu,child_renewable23216);
	child_renewable23216?0;
	stop_process: skip;
	child!0
}
proctype encode2317(Mutexdef le_Auth_Alias_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype renewable2321(Mutexdef le_Auth_Alias_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
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

