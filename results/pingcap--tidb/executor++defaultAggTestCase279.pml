// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob//executor/benchmark_test.go#L279
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
	chan child_defaultAggTestCase2790 = [1] of {int};
	run defaultAggTestCase279(child_defaultAggTestCase2790);
	run receiver(child_defaultAggTestCase2790)
stop_process:skip
}

proctype defaultAggTestCase279(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ctx_sessionVars_SequenceState_mu;
	Mutexdef ctx_sessionVars_StmtCtx_RuntimeStatsColl_mu;
	Mutexdef ctx_sessionVars_StmtCtx_mu;
	Mutexdef ctx_sessionVars_BinlogClient_Security_mutex;
	Wgdef ctx_sessionVars_BinlogClient_wg;
	Mutexdef ctx_sessionVars_TxnCtx_tdmLock;
	Mutexdef ctx_sessionVars_UsersLock;
	run mutexMonitor(ctx_sessionVars_UsersLock);
	run mutexMonitor(ctx_sessionVars_TxnCtx_tdmLock);
	run wgMonitor(ctx_sessionVars_BinlogClient_wg);
	run mutexMonitor(ctx_sessionVars_BinlogClient_Security_mutex);
	run mutexMonitor(ctx_sessionVars_StmtCtx_mu);
	run mutexMonitor(ctx_sessionVars_StmtCtx_RuntimeStatsColl_mu);
	run mutexMonitor(ctx_sessionVars_SequenceState_mu);
	goto stop_process;
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

