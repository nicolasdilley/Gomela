// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtadmin/cluster/cluster_internal_test.go#L43
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_getShardSets430 = [1] of {int};
	run Test_getShardSets43(child_Test_getShardSets430);
	run receiver(child_Test_getShardSets430)
stop_process:skip
}

proctype Test_getShardSets43(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef c_workflowReadPool_rp_reopenMutex;
	Wgdef c_workflowReadPool_rp_refreshWg;
	Mutexdef c_workflowReadPool_rp_idleTimer_mu;
	Mutexdef c_topoReadPool_rp_reopenMutex;
	Wgdef c_topoReadPool_rp_refreshWg;
	Mutexdef c_topoReadPool_rp_idleTimer_mu;
	Mutexdef c_topoRWPool_rp_reopenMutex;
	Wgdef c_topoRWPool_rp_refreshWg;
	Mutexdef c_topoRWPool_rp_idleTimer_mu;
	Mutexdef c_schemaReadPool_rp_reopenMutex;
	Wgdef c_schemaReadPool_rp_refreshWg;
	Mutexdef c_schemaReadPool_rp_idleTimer_mu;
	Mutexdef c_backupReadPool_rp_reopenMutex;
	Wgdef c_backupReadPool_rp_refreshWg;
	Mutexdef c_backupReadPool_rp_idleTimer_mu;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(c_backupReadPool_rp_idleTimer_mu);
	run wgMonitor(c_backupReadPool_rp_refreshWg);
	run mutexMonitor(c_backupReadPool_rp_reopenMutex);
	run mutexMonitor(c_schemaReadPool_rp_idleTimer_mu);
	run wgMonitor(c_schemaReadPool_rp_refreshWg);
	run mutexMonitor(c_schemaReadPool_rp_reopenMutex);
	run mutexMonitor(c_topoRWPool_rp_idleTimer_mu);
	run wgMonitor(c_topoRWPool_rp_refreshWg);
	run mutexMonitor(c_topoRWPool_rp_reopenMutex);
	run mutexMonitor(c_topoReadPool_rp_idleTimer_mu);
	run wgMonitor(c_topoReadPool_rp_refreshWg);
	run mutexMonitor(c_topoReadPool_rp_reopenMutex);
	run mutexMonitor(c_workflowReadPool_rp_idleTimer_mu);
	run wgMonitor(c_workflowReadPool_rp_refreshWg);
	run mutexMonitor(c_workflowReadPool_rp_reopenMutex);
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

