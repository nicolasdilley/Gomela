#define not_found_107  -2

// https://github.com/hashicorp/vault/blob/master/vault/dynamic_system_view.go#L65
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_SudoPrivilege650 = [1] of {int};
	run SudoPrivilege65(child_SudoPrivilege650)
stop_process:skip
}

proctype SudoPrivilege65(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AllowOperation3181 = [1] of {int};
	Mutexdef req_Auth_Alias_state_atomicMessageInfo_initMu;
	chan child_ACL7530 = [1] of {int};
	Mutexdef entity_LastUpdateTime_state_atomicMessageInfo_initMu;
	Mutexdef entity_CreationTime_state_atomicMessageInfo_initMu;
	Mutexdef entity_state_atomicMessageInfo_initMu;
	

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
	run mutexMonitor(entity_state_atomicMessageInfo_initMu);
	run mutexMonitor(entity_CreationTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(entity_LastUpdateTime_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run ACL753(entity_state_atomicMessageInfo_initMu,entity_CreationTime_state_atomicMessageInfo_initMu,entity_LastUpdateTime_state_atomicMessageInfo_initMu,not_found_107,child_ACL7530);
	child_ACL7530?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(req_Auth_Alias_state_atomicMessageInfo_initMu);
	run AllowOperation318(req_Auth_Alias_state_atomicMessageInfo_initMu,child_AllowOperation3181);
	child_AllowOperation3181?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ACL753(Mutexdef entity_state_atomicMessageInfo_initMu;Mutexdef entity_CreationTime_state_atomicMessageInfo_initMu;Mutexdef entity_LastUpdateTime_state_atomicMessageInfo_initMu;int policyNames;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parseACLPolicyWithTemplating2320 = [1] of {int};
	chan child_parseACLPolicyWithTemplating2321 = [1] of {int};
	int policies = -2;
	

	if
	:: policies-1 != -3 -> 
				for(i : 0.. policies-1) {
			for30: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						

						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					:: true;
					fi
				:: true;
				fi;
				run parseACLPolicyWithTemplating232(entity_state_atomicMessageInfo_initMu,entity_CreationTime_state_atomicMessageInfo_initMu,entity_LastUpdateTime_state_atomicMessageInfo_initMu,child_parseACLPolicyWithTemplating2320);
				child_parseACLPolicyWithTemplating2320?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for323: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						

						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					:: true;
					fi
				:: true;
				fi;
				run parseACLPolicyWithTemplating232(entity_state_atomicMessageInfo_initMu,entity_CreationTime_state_atomicMessageInfo_initMu,entity_LastUpdateTime_state_atomicMessageInfo_initMu,child_parseACLPolicyWithTemplating2321);
				child_parseACLPolicyWithTemplating2321?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			for323_end: skip
		:: true -> 
			break
		od;
		for323_exit: skip
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
proctype parseACLPolicyWithTemplating232(Mutexdef entity_state_atomicMessageInfo_initMu;Mutexdef entity_CreationTime_state_atomicMessageInfo_initMu;Mutexdef entity_LastUpdateTime_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parsePaths2730 = [1] of {int};
	

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
		run parsePaths273(entity_state_atomicMessageInfo_initMu,entity_CreationTime_state_atomicMessageInfo_initMu,entity_LastUpdateTime_state_atomicMessageInfo_initMu,child_parsePaths2730);
		child_parsePaths2730?0;
		

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
proctype parsePaths273(Mutexdef entity_state_atomicMessageInfo_initMu;Mutexdef entity_CreationTime_state_atomicMessageInfo_initMu;Mutexdef entity_LastUpdateTime_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
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

