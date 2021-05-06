
// https://github.com/hashicorp/terraform/blob/master/internal/legacy/helper/schema/provider_test.go#L387
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProviderImportState_default3870 = [1] of {int};
	run TestProviderImportState_default387(child_TestProviderImportState_default3870)
stop_process:skip
}

proctype TestProviderImportState_default387(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ImportState3700 = [1] of {int};
	Mutexdef p_stopOnce_m;
	Mutexdef p_stopMu;
	run mutexMonitor(p_stopMu);
	run mutexMonitor(p_stopOnce_m);
	run ImportState370(p_stopMu,p_stopOnce_m,child_ImportState3700);
	child_ImportState3700?0;
	stop_process: skip;
	child!0
}
proctype ImportState370(Mutexdef p_stopMu;Mutexdef p_stopOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetType2821 = [1] of {int};
	chan child_SetId2570 = [1] of {int};
	Mutexdef data_once_m;
	Mutexdef data_newState_mu;
	Mutexdef data_setWriter_lock;
	Mutexdef data_diff_mu;
	Mutexdef data_state_mu;
	

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
	run mutexMonitor(data_state_mu);
	run mutexMonitor(data_diff_mu);
	run mutexMonitor(data_setWriter_lock);
	run mutexMonitor(data_newState_mu);
	run mutexMonitor(data_once_m);
	run SetId257(data_state_mu,data_diff_mu,data_setWriter_lock,data_newState_mu,data_once_m,child_SetId2570);
	child_SetId2570?0;
	run SetType282(data_state_mu,data_diff_mu,data_setWriter_lock,data_newState_mu,data_once_m,child_SetType2821);
	child_SetType2821?0;
	

	if
	:: true -> 
		

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
proctype SetId257(Mutexdef d_state_mu;Mutexdef d_diff_mu;Mutexdef d_setWriter_lock;Mutexdef d_newState_mu;Mutexdef d_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_unsafeWriteField320 = [1] of {int};
	run unsafeWriteField32(d_setWriter_lock,child_unsafeWriteField320);
	child_unsafeWriteField320?0;
	stop_process: skip;
	child!0
}
proctype unsafeWriteField32(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	w_lock.Lock!false;
	stop_process: skip;
		w_lock.Unlock!false;
	child!0
}
proctype SetType282(Mutexdef d_state_mu;Mutexdef d_diff_mu;Mutexdef d_setWriter_lock;Mutexdef d_newState_mu;Mutexdef d_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

