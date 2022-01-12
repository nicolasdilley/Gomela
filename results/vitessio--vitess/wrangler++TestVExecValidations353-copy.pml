// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/wrangler/vexec_test.go#L353
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestVExecValidations3530 = [1] of {int};
	run TestVExecValidations353(child_TestVExecValidations3530);
	run receiver(child_TestVExecValidations3530)
stop_process:skip
}

proctype TestVExecValidations353(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_close2040 = [1] of {int};
	chan child_newVExec742 = [1] of {int};
	Mutexdef vx_wr_sourceTs_mu;
	Mutexdef vx_wr_ts_mu;
	chan child_New531 = [1] of {int};
	Mutexdef wr_sourceTs_mu;
	Mutexdef wr_ts_mu;
	Mutexdef env_mu;
	Mutexdef env_topoServ_mu;
	Mutexdef env_wr_sourceTs_mu;
	Mutexdef env_wr_ts_mu;
	int var_actions = -2; // opt var_actions
	int var_badQueries = -2; // opt var_badQueries
	run mutexMonitor(env_wr_ts_mu);
	run mutexMonitor(env_wr_sourceTs_mu);
	run mutexMonitor(env_topoServ_mu);
	run mutexMonitor(env_mu);
	run mutexMonitor(wr_ts_mu);
	run mutexMonitor(wr_sourceTs_mu);
	run New53(env_topoServ_mu,child_New531);
	child_New531?0;
	run mutexMonitor(vx_wr_ts_mu);
	run mutexMonitor(vx_wr_sourceTs_mu);
	run newVExec74(wr_sourceTs_mu,wr_ts_mu,child_newVExec742);
	child_newVExec742?0;
		defer1: skip;
	run close204(env_mu,env_topoServ_mu,env_wr_sourceTs_mu,env_wr_ts_mu,child_close2040);
	child_close2040?0;
	stop_process: skip;
	child!0
}
proctype close204(Mutexdef env_mu;Mutexdef env_topoServ_mu;Mutexdef env_wr_sourceTs_mu;Mutexdef env_wr_ts_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_env_tablets = -2; // opt var_env_tablets
	env_mu.Lock!false;
		defer1: skip;
	env_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype New53(Mutexdef ts_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newVExec74(Mutexdef wr_sourceTs_mu;Mutexdef wr_ts_mu;chan child) {
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

