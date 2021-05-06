
// https://github.com/hashicorp/terraform/blob/master/plans/planfile/tfplan.go#L33
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_readTfplan330 = [1] of {int};
	run readTfplan33(child_readTfplan330)
stop_process:skip
}

proctype readTfplan33(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_valueFromTfplan3050 = [1] of {int};
	Mutexdef rawBackend_Config_state_atomicMessageInfo_initMu;
	Mutexdef rawBackend_state_atomicMessageInfo_initMu;
	Mutexdef rawPlan_Backend_Config_state_atomicMessageInfo_initMu;
	Mutexdef rawPlan_Backend_state_atomicMessageInfo_initMu;
	Mutexdef rawPlan_state_atomicMessageInfo_initMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(rawPlan_state_atomicMessageInfo_initMu);
	run mutexMonitor(rawPlan_Backend_state_atomicMessageInfo_initMu);
	run mutexMonitor(rawPlan_Backend_Config_state_atomicMessageInfo_initMu);
	

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
	run mutexMonitor(rawBackend_state_atomicMessageInfo_initMu);
	run mutexMonitor(rawBackend_Config_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		run valueFromTfplan305(rawBackend_Config_state_atomicMessageInfo_initMu,child_valueFromTfplan3050);
		child_valueFromTfplan3050?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype valueFromTfplan305(Mutexdef rawV_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

