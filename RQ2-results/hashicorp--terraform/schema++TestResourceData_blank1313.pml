
// https://github.com/hashicorp/terraform/blob/master/internal/legacy/helper/schema/resource_test.go#L1313
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestResourceData_blank13130 = [1] of {int};
	run TestResourceData_blank1313(child_TestResourceData_blank13130)
stop_process:skip
}

proctype TestResourceData_blank1313(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get752 = [1] of {int};
	chan child_Id2221 = [1] of {int};
	chan child_Id2220 = [1] of {int};
	Mutexdef data_once_m;
	Mutexdef data_newState_mu;
	Mutexdef data_setWriter_lock;
	Mutexdef data_diff_mu;
	Mutexdef data_state_mu;
	run mutexMonitor(data_state_mu);
	run mutexMonitor(data_diff_mu);
	run mutexMonitor(data_setWriter_lock);
	run mutexMonitor(data_newState_mu);
	run mutexMonitor(data_once_m);
	run Id222(data_state_mu,data_diff_mu,data_setWriter_lock,data_newState_mu,data_once_m,child_Id2220);
	child_Id2220?0;
	

	if
	:: true -> 
		run Id222(data_state_mu,data_diff_mu,data_setWriter_lock,data_newState_mu,data_once_m,child_Id2221);
		child_Id2221?0
	:: true;
	fi;
	run Get75(data_state_mu,data_diff_mu,data_setWriter_lock,data_newState_mu,data_once_m,child_Get752);
	child_Get752?0;
	stop_process: skip;
	child!0
}
proctype Id222(Mutexdef d_state_mu;Mutexdef d_diff_mu;Mutexdef d_setWriter_lock;Mutexdef d_newState_mu;Mutexdef d_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get75(Mutexdef d_state_mu;Mutexdef d_diff_mu;Mutexdef d_setWriter_lock;Mutexdef d_newState_mu;Mutexdef d_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetOk962 = [1] of {int};
	run GetOk96(d_state_mu,d_diff_mu,d_setWriter_lock,d_newState_mu,d_once_m,child_GetOk962);
	child_GetOk962?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetOk96(Mutexdef d_state_mu;Mutexdef d_diff_mu;Mutexdef d_setWriter_lock;Mutexdef d_newState_mu;Mutexdef d_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getRaw1302 = [1] of {int};
	run getRaw130(d_state_mu,d_diff_mu,d_setWriter_lock,d_newState_mu,d_once_m,child_getRaw1302);
	child_getRaw1302?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getRaw130(Mutexdef d_state_mu;Mutexdef d_diff_mu;Mutexdef d_setWriter_lock;Mutexdef d_newState_mu;Mutexdef d_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get5072 = [1] of {int};
	run get507(d_state_mu,d_diff_mu,d_setWriter_lock,d_newState_mu,d_once_m,child_get5072);
	child_get5072?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype get507(Mutexdef d_state_mu;Mutexdef d_diff_mu;Mutexdef d_setWriter_lock;Mutexdef d_newState_mu;Mutexdef d_once_m;chan child) {
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

