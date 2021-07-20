// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/executor/builder.go#L434
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_buildRecoverIndex4340 = [1] of {int};
	run buildRecoverIndex434(child_buildRecoverIndex4340);
	run receiver(child_buildRecoverIndex4340)
stop_process:skip
}

proctype buildRecoverIndex434(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_buildHandleColsForExec4590 = [1] of {int};
	Mutexdef sessCtx_RuntimeStatsColl_mu;
	Mutexdef sessCtx_mu;
	

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
	run mutexMonitor(sessCtx_mu);
	run mutexMonitor(sessCtx_RuntimeStatsColl_mu);
	run buildHandleColsForExec459(sessCtx_mu,sessCtx_RuntimeStatsColl_mu,child_buildHandleColsForExec4590);
	child_buildHandleColsForExec4590?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype buildHandleColsForExec459(Mutexdef sctx_mu;Mutexdef sctx_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewCommonHandleCols1720 = [1] of {int};
	int var_pkIdx_ColumnspkIdx_Columns = -2; // opt var_pkIdx_ColumnspkIdx_Columns
	int var_tblInfo_ColumnstblInfo_Columns = -2; // opt var_tblInfo_ColumnstblInfo_Columns
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run NewCommonHandleCols172(sctx_mu,sctx_RuntimeStatsColl_mu,child_NewCommonHandleCols1720);
	child_NewCommonHandleCols1720?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewCommonHandleCols172(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_idxInfo_ColumnsidxInfo_Columns = -2; // opt var_idxInfo_ColumnsidxInfo_Columns
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
