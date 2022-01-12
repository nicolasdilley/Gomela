// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/test/endtoend/vtorc/primary_failure_test.go#L154
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPromotionLagSuccess1540 = [1] of {int};
	run TestPromotionLagSuccess154(child_TestPromotionLagSuccess1540);
	run receiver(child_TestPromotionLagSuccess1540)
stop_process:skip
}

proctype TestPromotionLagSuccess154(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_permanentlyRemoveVttablet6440 = [1] of {int};
	Mutexdef curPrimary_VtgrProcess_proc_Process_sigMu;
	Mutexdef curPrimary_VttabletProcess_proc_Process_sigMu;
	Mutexdef curPrimary_MysqlctldProcess_process_Process_sigMu;
	int var_shard0_Vttablets = -2; // opt var_shard0_Vttablets
	run mutexMonitor(curPrimary_MysqlctldProcess_process_Process_sigMu);
	run mutexMonitor(curPrimary_VttabletProcess_proc_Process_sigMu);
	run mutexMonitor(curPrimary_VtgrProcess_proc_Process_sigMu);
		defer1: skip;
	run permanentlyRemoveVttablet644(curPrimary_MysqlctldProcess_process_Process_sigMu,curPrimary_VtgrProcess_proc_Process_sigMu,curPrimary_VttabletProcess_proc_Process_sigMu,child_permanentlyRemoveVttablet6440);
	child_permanentlyRemoveVttablet6440?0;
	stop_process: skip;
	child!0
}
proctype permanentlyRemoveVttablet644(Mutexdef tablet_MysqlctldProcess_process_Process_sigMu;Mutexdef tablet_VtgrProcess_proc_Process_sigMu;Mutexdef tablet_VttabletProcess_proc_Process_sigMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_cellInfo_rdonlyTablets = -2; // opt var_cellInfo_rdonlyTablets
	int var_cellInfo_replicaTablets = -2; // opt var_cellInfo_replicaTablets
	int var_cellInfos = -2; // opt var_cellInfos
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

