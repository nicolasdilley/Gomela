// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/states/statemgr/filesystem_test.go#L147
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFilesystem_backup1470 = [1] of {int};
	run TestFilesystem_backup147(child_TestFilesystem_backup1470);
	run receiver(child_TestFilesystem_backup1470)
stop_process:skip
}

proctype TestFilesystem_backup147(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TestFull221 = [1] of {int};
	chan child_SetBackupPath990 = [1] of {int};
	Mutexdef ls_mu;
	int var_deep_Equal = -2; // opt var_deep_Equal
	run mutexMonitor(ls_mu);
	run SetBackupPath99(ls_mu,child_SetBackupPath990);
	child_SetBackupPath990?0;
	run TestFull22(ls_mu,child_TestFull221);
	child_TestFull221?0;
	stop_process: skip;
	child!0
}
proctype SetBackupPath99(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype TestFull22(Mutexdef s_mu;chan child) {
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

proctype receiver(chan c) {
c?0
}

