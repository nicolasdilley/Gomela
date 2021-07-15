
// https://github.com/hashicorp/vault/blob/master/command/server/server_seal_transit_acc_test.go#L18
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTransitWrapper_Lifecycle180 = [1] of {int};
	run TestTransitWrapper_Lifecycle18(child_TestTransitWrapper_Lifecycle180)
stop_process:skip
}

proctype TestTransitWrapper_Lifecycle18(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef swi_KeyInfo_state_atomicMessageInfo_initMu;
	Mutexdef swi_state_atomicMessageInfo_initMu;
	run mutexMonitor(swi_state_atomicMessageInfo_initMu);
	run mutexMonitor(swi_KeyInfo_state_atomicMessageInfo_initMu);
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

