// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/workers/sync_download_test.go#L28
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSync_downloadPath280 = [1] of {int};
	run TestSync_downloadPath28(child_TestSync_downloadPath280);
	run receiver(child_TestSync_downloadPath280)
stop_process:skip
}

proctype TestSync_downloadPath28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_downloadPath201 = [1] of {int};
	chan child_NewSync230 = [1] of {int};
	Mutexdef worker_conf_db_values_mu;
	Mutexdef worker_conf_once_m;
	Mutexdef conf_db_values_mu;
	Mutexdef conf_once_m;
	run mutexMonitor(conf_once_m);
	run mutexMonitor(conf_db_values_mu);
	run mutexMonitor(worker_conf_once_m);
	run mutexMonitor(worker_conf_db_values_mu);
	run NewSync23(conf_db_values_mu,conf_once_m,child_NewSync230);
	child_NewSync230?0;
	run downloadPath20(worker_conf_db_values_mu,worker_conf_once_m,child_downloadPath201);
	child_downloadPath201?0;
	stop_process: skip;
	child!0
}
proctype NewSync23(Mutexdef conf_db_values_mu;Mutexdef conf_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype downloadPath20(Mutexdef worker_conf_db_values_mu;Mutexdef worker_conf_once_m;chan child) {
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

proctype receiver(chan c) {
c?0
}

