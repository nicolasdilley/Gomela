
// https://github.com/hashicorp/vault/blob/master/helper/mfa/duo/duo_test.go#L91
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDuoHandlerReject910 = [1] of {int};
	run TestDuoHandlerReject91(child_TestDuoHandlerReject910)
stop_process:skip
}

proctype TestDuoHandlerReject91(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef resp_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef successResp_Auth_Alias_state_atomicMessageInfo_initMu;
	run mutexMonitor(successResp_Auth_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(resp_Auth_Alias_state_atomicMessageInfo_initMu);
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

