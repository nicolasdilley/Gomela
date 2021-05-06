
// https://github.com/hashicorp/vault/blob/master/vault/acl_test.go#L158
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testACLRoot1580 = [1] of {int};
	run testACLRoot158(child_testACLRoot1580)
stop_process:skip
}

proctype testACLRoot158(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AllowOperation3180 = [1] of {int};
	Mutexdef request_Auth_Alias_state_atomicMessageInfo_initMu;
	run mutexMonitor(request_Auth_Alias_state_atomicMessageInfo_initMu);
	run AllowOperation318(request_Auth_Alias_state_atomicMessageInfo_initMu,child_AllowOperation3180);
	child_AllowOperation3180?0;
	stop_process: skip;
	child!0
}
proctype AllowOperation318(Mutexdef req_Auth_Alias_state_atomicMessageInfo_initMu;chan child) {
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto CHECK
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto CHECK
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto CHECK
	:: true;
	fi;
	goto stop_process;
	CHECK: skip;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
		goto stop_process
	fi;
	

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
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

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
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto ALLOWED_PARAMETERS
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		ALLOWED_PARAMETERS: skip;
		

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

