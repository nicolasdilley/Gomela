
// https://github.com/hashicorp/vault/blob/master/http/handler_test.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHandler_parseMFAHandler260 = [1] of {int};
	run TestHandler_parseMFAHandler26(child_TestHandler_parseMFAHandler260)
stop_process:skip
}

proctype TestHandler_parseMFAHandler26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parseMFAHeader10454 = [1] of {int};
	chan child_parseMFAHeader10453 = [1] of {int};
	chan child_parseMFAHeader10452 = [1] of {int};
	chan child_parseMFAHeader10451 = [1] of {int};
	chan child_parseMFAHeader10450 = [1] of {int};
	Mutexdef req_Auth_Alias_state_atomicMessageInfo_initMu;
	run mutexMonitor(req_Auth_Alias_state_atomicMessageInfo_initMu);
	run parseMFAHeader1045(req_Auth_Alias_state_atomicMessageInfo_initMu,child_parseMFAHeader10450);
	child_parseMFAHeader10450?0;
	run parseMFAHeader1045(req_Auth_Alias_state_atomicMessageInfo_initMu,child_parseMFAHeader10451);
	child_parseMFAHeader10451?0;
	run parseMFAHeader1045(req_Auth_Alias_state_atomicMessageInfo_initMu,child_parseMFAHeader10452);
	child_parseMFAHeader10452?0;
	run parseMFAHeader1045(req_Auth_Alias_state_atomicMessageInfo_initMu,child_parseMFAHeader10453);
	child_parseMFAHeader10453?0;
	run parseMFAHeader1045(req_Auth_Alias_state_atomicMessageInfo_initMu,child_parseMFAHeader10454);
	child_parseMFAHeader10454?0;
	stop_process: skip;
	child!0
}
proctype parseMFAHeader1045(Mutexdef req_Auth_Alias_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

