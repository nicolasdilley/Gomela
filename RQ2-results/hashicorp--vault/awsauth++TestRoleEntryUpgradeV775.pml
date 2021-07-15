
// https://github.com/hashicorp/vault/blob/master/builtin/credential/aws/path_role_test.go#L775
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRoleEntryUpgradeV7750 = [1] of {int};
	run TestRoleEntryUpgradeV775(child_TestRoleEntryUpgradeV7750)
stop_process:skip
}

proctype TestRoleEntryUpgradeV775(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_upgradeRole4460 = [1] of {int};
	Mutexdef b_deprecatedTerms_once_m;
	Mutexdef b_denyListMutex;
	Mutexdef b_roleMutex;
	Mutexdef b_configMutex;
	Mutexdef storage_once_m;
	run mutexMonitor(storage_once_m);
	run mutexMonitor(b_configMutex);
	run mutexMonitor(b_roleMutex);
	run mutexMonitor(b_denyListMutex);
	run mutexMonitor(b_deprecatedTerms_once_m);
	run upgradeRole446(b_configMutex,b_roleMutex,b_denyListMutex,b_deprecatedTerms_once_m,storage_once_m,child_upgradeRole4460);
	child_upgradeRole4460?0;
	stop_process: skip;
	child!0
}
proctype upgradeRole446(Mutexdef b_configMutex;Mutexdef b_roleMutex;Mutexdef b_denyListMutex;Mutexdef b_deprecatedTerms_once_m;Mutexdef s_once_m;chan child) {
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

