
// https://github.com/pingcap/tidb/blob/master/util/execdetails/execdetails_test.go#L97
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCopRuntimeStats970 = [1] of {int};
	run TestCopRuntimeStats97(child_TestCopRuntimeStats970)
stop_process:skip
}

proctype TestCopRuntimeStats97(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ExistsRootStats6608 = [1] of {int};
	chan child_GetRootStats5947 = [1] of {int};
	chan child_GetOrCreateCopStats6176 = [1] of {int};
	chan child_ExistsCopStats6685 = [1] of {int};
	chan child_RecordScanDetail6544 = [1] of {int};
	chan child_RecordOneCopTask6433 = [1] of {int};
	chan child_RecordOneCopTask6432 = [1] of {int};
	chan child_RecordOneCopTask6431 = [1] of {int};
	chan child_RecordOneCopTask6430 = [1] of {int};
	Mutexdef stats_mu;
	run mutexMonitor(stats_mu);
	run RecordOneCopTask643(stats_mu,child_RecordOneCopTask6430);
	child_RecordOneCopTask6430?0;
	run RecordOneCopTask643(stats_mu,child_RecordOneCopTask6431);
	child_RecordOneCopTask6431?0;
	run RecordOneCopTask643(stats_mu,child_RecordOneCopTask6432);
	child_RecordOneCopTask6432?0;
	run RecordOneCopTask643(stats_mu,child_RecordOneCopTask6433);
	child_RecordOneCopTask6433?0;
	run RecordScanDetail654(stats_mu,child_RecordScanDetail6544);
	child_RecordScanDetail6544?0;
	run ExistsCopStats668(stats_mu,child_ExistsCopStats6685);
	child_ExistsCopStats6685?0;
	run GetOrCreateCopStats617(stats_mu,child_GetOrCreateCopStats6176);
	child_GetOrCreateCopStats6176?0;
	run GetRootStats594(stats_mu,child_GetRootStats5947);
	child_GetRootStats5947?0;
	run ExistsRootStats660(stats_mu,child_ExistsRootStats6608);
	child_ExistsRootStats6608?0;
	stop_process: skip;
	child!0
}
proctype RecordOneCopTask643(Mutexdef e_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetOrCreateCopStats6170 = [1] of {int};
	run GetOrCreateCopStats617(e_mu,child_GetOrCreateCopStats6170);
	child_GetOrCreateCopStats6170?0;
	stop_process: skip;
	child!0
}
proctype GetOrCreateCopStats617(Mutexdef e_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	e_mu.Lock!false;
	goto stop_process;
	stop_process: skip;
		e_mu.Unlock!false;
	child!0
}
proctype RecordScanDetail654(Mutexdef e_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetOrCreateCopStats6174 = [1] of {int};
	run GetOrCreateCopStats617(e_mu,child_GetOrCreateCopStats6174);
	child_GetOrCreateCopStats6174?0;
	stop_process: skip;
	child!0
}
proctype ExistsCopStats668(Mutexdef e_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	e_mu.Lock!false;
	goto stop_process;
	stop_process: skip;
		e_mu.Unlock!false;
	child!0
}
proctype GetRootStats594(Mutexdef e_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	e_mu.Lock!false;
	goto stop_process;
	stop_process: skip;
		e_mu.Unlock!false;
	child!0
}
proctype ExistsRootStats660(Mutexdef e_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	e_mu.Lock!false;
	goto stop_process;
	stop_process: skip;
		e_mu.Unlock!false;
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

