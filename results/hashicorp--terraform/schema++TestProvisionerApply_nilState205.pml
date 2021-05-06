
// https://github.com/hashicorp/terraform/blob/master/internal/legacy/helper/schema/provisioner_test.go#L205
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProvisionerApply_nilState2050 = [1] of {int};
	run TestProvisionerApply_nilState205(child_TestProvisionerApply_nilState2050)
stop_process:skip
}

proctype TestProvisionerApply_nilState205(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Apply1300 = [1] of {int};
	Mutexdef p_stopOnce_m;
	run mutexMonitor(p_stopOnce_m);
	run Apply130(p_stopOnce_m,child_Apply1300);
	child_Apply1300?0;
	stop_process: skip;
	child!0
}
proctype Apply130(Mutexdef p_stopOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StopContext1080 = [1] of {int};
	Mutexdef configData_once_m;
	Mutexdef configData_newState_mu;
	Mutexdef configData_setWriter_lock;
	Mutexdef configData_diff_mu;
	Mutexdef configData_state_mu;
	Mutexdef connData_once_m;
	Mutexdef connData_newState_mu;
	Mutexdef connData_setWriter_lock;
	Mutexdef connData_diff_mu;
	Mutexdef connData_state_mu;
	run mutexMonitor(connData_state_mu);
	run mutexMonitor(connData_diff_mu);
	run mutexMonitor(connData_setWriter_lock);
	run mutexMonitor(connData_newState_mu);
	run mutexMonitor(connData_once_m);
	run mutexMonitor(configData_state_mu);
	run mutexMonitor(configData_diff_mu);
	run mutexMonitor(configData_setWriter_lock);
	run mutexMonitor(configData_newState_mu);
	run mutexMonitor(configData_once_m);
	run StopContext108(p_stopOnce_m,child_StopContext1080);
	child_StopContext1080?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype StopContext108(Mutexdef p_stopOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

