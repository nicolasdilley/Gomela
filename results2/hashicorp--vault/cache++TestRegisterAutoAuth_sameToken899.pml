// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/command/agent/cache/lease_cache_test.go#L899
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRegisterAutoAuth_sameToken8990 = [1] of {int};
	run TestRegisterAutoAuth_sameToken899(child_TestRegisterAutoAuth_sameToken8990);
	run receiver(child_TestRegisterAutoAuth_sameToken8990)
stop_process:skip
}

proctype TestRegisterAutoAuth_sameToken899(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RegisterAutoAuthToken11781 = [1] of {int};
	chan child_RegisterAutoAuthToken11780 = [1] of {int};
	Mutexdef lc_l;
	Mutexdef lc_client_modifyLock;
	run mutexMonitor(lc_client_modifyLock);
	run mutexMonitor(lc_l);
	run RegisterAutoAuthToken1178(lc_client_modifyLock,lc_l,child_RegisterAutoAuthToken11780);
	child_RegisterAutoAuthToken11780?0;
	run RegisterAutoAuthToken1178(lc_client_modifyLock,lc_l,child_RegisterAutoAuthToken11781);
	child_RegisterAutoAuthToken11781?0;
	stop_process: skip;
	child!0
}
proctype RegisterAutoAuthToken1178(Mutexdef c_client_modifyLock;Mutexdef c_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Set9181 = [1] of {int};
	chan child_createCtxInfo4450 = [1] of {int};
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run createCtxInfo445(c_client_modifyLock,c_l,child_createCtxInfo4450);
	child_createCtxInfo4450?0;
	run Set918(c_client_modifyLock,c_l,child_Set9181);
	child_Set9181?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype createCtxInfo445(Mutexdef c_client_modifyLock;Mutexdef c_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		c_l.RLock!false;
		c_l.RUnlock!false
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Set918(Mutexdef c_client_modifyLock;Mutexdef c_l;chan child) {
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

proctype receiver(chan c) {
c?0
}

