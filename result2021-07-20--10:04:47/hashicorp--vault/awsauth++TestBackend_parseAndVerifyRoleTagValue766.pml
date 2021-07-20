// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/builtin/credential/aws/backend_test.go#L766
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBackend_parseAndVerifyRoleTagValue7660 = [1] of {int};
	run TestBackend_parseAndVerifyRoleTagValue766(child_TestBackend_parseAndVerifyRoleTagValue7660);
	run receiver(child_TestBackend_parseAndVerifyRoleTagValue7660)
stop_process:skip
}

proctype TestBackend_parseAndVerifyRoleTagValue766(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parseAndVerifyRoleTagValue2930 = [1] of {int};
	Mutexdef b_denyListMutex;
	Mutexdef b_roleMutex;
	Mutexdef b_configMutex;
	Mutexdef storage_once_m;
	run mutexMonitor(storage_once_m);
	run mutexMonitor(b_configMutex);
	run mutexMonitor(b_roleMutex);
	run mutexMonitor(b_denyListMutex);
	run parseAndVerifyRoleTagValue293(b_configMutex,b_denyListMutex,b_roleMutex,storage_once_m,child_parseAndVerifyRoleTagValue2930);
	child_parseAndVerifyRoleTagValue2930?0;
	stop_process: skip;
	child!0
}
proctype parseAndVerifyRoleTagValue293(Mutexdef b_configMutex;Mutexdef b_denyListMutex;Mutexdef b_roleMutex;Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_role2390 = [1] of {int};
	int var_tagItemstagItems = -2; // opt var_tagItemstagItems
	

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
	run role239(b_configMutex,b_denyListMutex,b_roleMutex,s_once_m,child_role2390);
	child_role2390?0;
	

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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype role239(Mutexdef b_configMutex;Mutexdef b_denyListMutex;Mutexdef b_roleMutex;Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_roleInternal2630 = [1] of {int};
	

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
	b_roleMutex.Lock!false;
	run roleInternal263(b_configMutex,b_denyListMutex,b_roleMutex,s_once_m,child_roleInternal2630);
	child_roleInternal2630?0;
	goto defer1;
		defer1: skip;
	b_roleMutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype roleInternal263(Mutexdef b_configMutex;Mutexdef b_denyListMutex;Mutexdef b_roleMutex;Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setRole3071 = [1] of {int};
	chan child_upgradeRole4450 = [1] of {int};
	

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
	run upgradeRole445(b_configMutex,b_denyListMutex,b_roleMutex,s_once_m,child_upgradeRole4450);
	child_upgradeRole4450?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run setRole307(b_configMutex,b_denyListMutex,b_roleMutex,s_once_m,child_setRole3071);
		child_setRole3071?0;
		

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
proctype upgradeRole445(Mutexdef b_configMutex;Mutexdef b_denyListMutex;Mutexdef b_roleMutex;Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_roleEntry_BoundIamInstanceProfileARNsroleEntry_BoundIamInstanceProfileARNs = -2; // opt var_roleEntry_BoundIamInstanceProfileARNsroleEntry_BoundIamInstanceProfileARNs
	int var_roleEntry_BoundIamRoleARNsroleEntry_BoundIamRoleARNs = -2; // opt var_roleEntry_BoundIamRoleARNsroleEntry_BoundIamRoleARNs
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

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
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	:: true -> 
		goto stop_process
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype setRole307(Mutexdef b_configMutex;Mutexdef b_denyListMutex;Mutexdef b_roleMutex;Mutexdef s_once_m;chan child) {
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

proctype receiver(chan c) {
c?0
}
