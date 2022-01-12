// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/vitessio/vitess/blob//go/test/endtoend/migration/migration_test.go#L206
#define def_var_tables  -2 // opt tables line 206
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_migrate2060 = [1] of {int};
	run migrate206(def_var_tables,child_migrate2060);
	run receiver(child_migrate2060)
stop_process:skip
}

proctype migrate206(int var_tables;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef vttablet_proc_Process_sigMu;
	Mutexdef bls_Filter_state_atomicMessageInfo_initMu;
	Mutexdef bls_KeyRange_state_atomicMessageInfo_initMu;
	Mutexdef bls_state_atomicMessageInfo_initMu;
	run mutexMonitor(bls_state_atomicMessageInfo_initMu);
	run mutexMonitor(bls_KeyRange_state_atomicMessageInfo_initMu);
	run mutexMonitor(bls_Filter_state_atomicMessageInfo_initMu);
	run mutexMonitor(vttablet_proc_Process_sigMu);
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

