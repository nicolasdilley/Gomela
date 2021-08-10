// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/executor/prepared.go#L312
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_CompileExecutePreparedStmt3120 = [1] of {int};
	run CompileExecutePreparedStmt312(child_CompileExecutePreparedStmt3120);
	run receiver(child_CompileExecutePreparedStmt3120)
stop_process:skip
}

proctype CompileExecutePreparedStmt312(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_InitSQLDigest2230 = [1] of {int};
	Mutexdef stmtCtx_RuntimeStatsColl_mu;
	Mutexdef stmtCtx_mu;
	

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
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run mutexMonitor(stmtCtx_mu);
		run mutexMonitor(stmtCtx_RuntimeStatsColl_mu);
		run InitSQLDigest223(stmtCtx_mu,stmtCtx_RuntimeStatsColl_mu,child_InitSQLDigest2230);
		child_InitSQLDigest2230?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype InitSQLDigest223(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
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

