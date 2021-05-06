
// https://github.com/hashicorp/vault/blob/master/audit/format_test.go#L38
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFormatRequestErrors380 = [1] of {int};
	run TestFormatRequestErrors38(child_TestFormatRequestErrors380)
stop_process:skip
}

proctype TestFormatRequestErrors38(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FormatRequest360 = [1] of {int};
	Mutexdef in_Response_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef in_Request_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef in_Auth_Alias_state_atomicMessageInfo_initMu;
	run mutexMonitor(in_Auth_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(in_Request_Auth_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(in_Response_Auth_Alias_state_atomicMessageInfo_initMu);
	run FormatRequest36(in_Auth_Alias_state_atomicMessageInfo_initMu,in_Request_Auth_Alias_state_atomicMessageInfo_initMu,in_Response_Auth_Alias_state_atomicMessageInfo_initMu,child_FormatRequest360);
	child_FormatRequest360?0;
	stop_process: skip;
	child!0
}
proctype FormatRequest36(Mutexdef in_Auth_Alias_state_atomicMessageInfo_initMu;Mutexdef in_Request_Auth_Alias_state_atomicMessageInfo_initMu;Mutexdef in_Response_Auth_Alias_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_HashRequest411 = [1] of {int};
	chan child_HashAuth230 = [1] of {int};
	Mutexdef req_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef auth_Alias_state_atomicMessageInfo_initMu;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(auth_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_Auth_Alias_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		run HashAuth23(auth_Alias_state_atomicMessageInfo_initMu,child_HashAuth230);
		child_HashAuth230?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run HashRequest41(req_Auth_Alias_state_atomicMessageInfo_initMu,child_HashRequest411);
		child_HashRequest411?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
proctype HashAuth23(Mutexdef in_Alias_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef auth_Alias_state_atomicMessageInfo_initMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(auth_Alias_state_atomicMessageInfo_initMu);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype HashRequest41(Mutexdef in_Auth_Alias_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef req_Auth_Alias_state_atomicMessageInfo_initMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(req_Auth_Alias_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

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

