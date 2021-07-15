
// https://github.com/pingcap/tidb/blob/master/planner/optimize.go#L81
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
	chan child_Optimize810 = [1] of {int};
	run Optimize81(child_Optimize810)
stop_process:skip
}

proctype Optimize81(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetStmtVar13601 = [1] of {int};
	chan child_SetStmtVar13602 = [1] of {int};
	chan child_IsReadOnly670 = [1] of {int};
	Mutexdef sessVars_SequenceState_mu;
	Mutexdef sessVars_StmtCtx_digestMemo_m;
	Mutexdef sessVars_StmtCtx_RuntimeStatsColl_mu;
	Mutexdef sessVars_StmtCtx_DiskTracker_parMu;
	Mutexdef sessVars_StmtCtx_DiskTracker_actionMu;
	Mutexdef sessVars_StmtCtx_DiskTracker_mu;
	Mutexdef sessVars_StmtCtx_MemTracker_parMu;
	Mutexdef sessVars_StmtCtx_MemTracker_actionMu;
	Mutexdef sessVars_StmtCtx_MemTracker_mu;
	Mutexdef sessVars_StmtCtx_mu_LockKeysDetail_Mu;
	Mutexdef sessVars_StmtCtx_mu_CommitDetail_Mu;
	Mutexdef sessVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu;
	Mutexdef sessVars_StmtCtx_mu_execDetails_CommitDetail_Mu;
	Mutexdef sessVars_BinlogClient_Security_mutex;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_mu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_mu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu;
	Mutexdef sessVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu;
	Wgdef sessVars_BinlogClient_wg;
	Mutexdef sessVars_TxnCtx_tdmLock;
	Mutexdef sessVars_UsersLock;
	int stmtHints_SetVars = -2;
	run mutexMonitor(sessVars_UsersLock);
	run mutexMonitor(sessVars_TxnCtx_tdmLock);
	run wgMonitor(sessVars_BinlogClient_wg);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_mu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu);
	run mutexMonitor(sessVars_BinlogClient_EtcdRegistry_client_client_mu);
	run mutexMonitor(sessVars_BinlogClient_Security_mutex);
	run mutexMonitor(sessVars_StmtCtx_mu_execDetails_CommitDetail_Mu);
	run mutexMonitor(sessVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu);
	run mutexMonitor(sessVars_StmtCtx_mu_CommitDetail_Mu);
	run mutexMonitor(sessVars_StmtCtx_mu_LockKeysDetail_Mu);
	run mutexMonitor(sessVars_StmtCtx_MemTracker_mu);
	run mutexMonitor(sessVars_StmtCtx_MemTracker_actionMu);
	run mutexMonitor(sessVars_StmtCtx_MemTracker_parMu);
	run mutexMonitor(sessVars_StmtCtx_DiskTracker_mu);
	run mutexMonitor(sessVars_StmtCtx_DiskTracker_actionMu);
	run mutexMonitor(sessVars_StmtCtx_DiskTracker_parMu);
	run mutexMonitor(sessVars_StmtCtx_RuntimeStatsColl_mu);
	run mutexMonitor(sessVars_StmtCtx_digestMemo_m);
	run mutexMonitor(sessVars_SequenceState_mu);
	run IsReadOnly67(sessVars_BinlogClient_wg,sessVars_UsersLock,sessVars_TxnCtx_tdmLock,sessVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_mu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m,sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m,sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m,sessVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex,sessVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu,sessVars_BinlogClient_EtcdRegistry_client_client_mu,sessVars_BinlogClient_Security_mutex,sessVars_StmtCtx_mu_execDetails_CommitDetail_Mu,sessVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu,sessVars_StmtCtx_mu_CommitDetail_Mu,sessVars_StmtCtx_mu_LockKeysDetail_Mu,sessVars_StmtCtx_MemTracker_mu,sessVars_StmtCtx_MemTracker_actionMu,sessVars_StmtCtx_MemTracker_parMu,sessVars_StmtCtx_DiskTracker_mu,sessVars_StmtCtx_DiskTracker_actionMu,sessVars_StmtCtx_DiskTracker_parMu,sessVars_StmtCtx_RuntimeStatsColl_mu,sessVars_StmtCtx_digestMemo_m,sessVars_SequenceState_mu,child_IsReadOnly670);
	child_IsReadOnly670?0;
	

	if
	:: stmtHints_SetVars-1 != -3 -> 
				for(i : 0.. stmtHints_SetVars-1) {
			for20: skip;
			run SetStmtVar1360(sessVars_BinlogClient_wg,sessVars_UsersLock,sessVars_TxnCtx_tdmLock,sessVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_mu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m,sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m,sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m,sessVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex,sessVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu,sessVars_BinlogClient_EtcdRegistry_client_client_mu,sessVars_BinlogClient_Security_mutex,sessVars_StmtCtx_mu_execDetails_CommitDetail_Mu,sessVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu,sessVars_StmtCtx_mu_CommitDetail_Mu,sessVars_StmtCtx_mu_LockKeysDetail_Mu,sessVars_StmtCtx_MemTracker_mu,sessVars_StmtCtx_MemTracker_actionMu,sessVars_StmtCtx_MemTracker_parMu,sessVars_StmtCtx_DiskTracker_mu,sessVars_StmtCtx_DiskTracker_actionMu,sessVars_StmtCtx_DiskTracker_parMu,sessVars_StmtCtx_RuntimeStatsColl_mu,sessVars_StmtCtx_digestMemo_m,sessVars_SequenceState_mu,child_SetStmtVar13601);
			child_SetStmtVar13601?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			run SetStmtVar1360(sessVars_BinlogClient_wg,sessVars_UsersLock,sessVars_TxnCtx_tdmLock,sessVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_mu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m,sessVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m,sessVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu,sessVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m,sessVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex,sessVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu,sessVars_BinlogClient_EtcdRegistry_client_client_mu,sessVars_BinlogClient_Security_mutex,sessVars_StmtCtx_mu_execDetails_CommitDetail_Mu,sessVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu,sessVars_StmtCtx_mu_CommitDetail_Mu,sessVars_StmtCtx_mu_LockKeysDetail_Mu,sessVars_StmtCtx_MemTracker_mu,sessVars_StmtCtx_MemTracker_actionMu,sessVars_StmtCtx_MemTracker_parMu,sessVars_StmtCtx_DiskTracker_mu,sessVars_StmtCtx_DiskTracker_actionMu,sessVars_StmtCtx_DiskTracker_parMu,sessVars_StmtCtx_RuntimeStatsColl_mu,sessVars_StmtCtx_digestMemo_m,sessVars_SequenceState_mu,child_SetStmtVar13602);
			child_SetStmtVar13602?0;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

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
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype IsReadOnly67(Wgdef vars_BinlogClient_wg;Mutexdef vars_UsersLock;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_mu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_mu;Mutexdef vars_BinlogClient_Security_mutex;Mutexdef vars_StmtCtx_mu_execDetails_CommitDetail_Mu;Mutexdef vars_StmtCtx_mu_execDetails_LockKeysDetail_Mu;Mutexdef vars_StmtCtx_mu_CommitDetail_Mu;Mutexdef vars_StmtCtx_mu_LockKeysDetail_Mu;Mutexdef vars_StmtCtx_MemTracker_mu;Mutexdef vars_StmtCtx_MemTracker_actionMu;Mutexdef vars_StmtCtx_MemTracker_parMu;Mutexdef vars_StmtCtx_DiskTracker_mu;Mutexdef vars_StmtCtx_DiskTracker_actionMu;Mutexdef vars_StmtCtx_DiskTracker_parMu;Mutexdef vars_StmtCtx_RuntimeStatsColl_mu;Mutexdef vars_StmtCtx_digestMemo_m;Mutexdef vars_SequenceState_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetPreparedStmt480 = [1] of {int};
	

	if
	:: true -> 
		run GetPreparedStmt48(vars_BinlogClient_wg,vars_UsersLock,vars_TxnCtx_tdmLock,vars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu,vars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu,vars_BinlogClient_EtcdRegistry_client_client_conn_mu,vars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu,vars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m,vars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu,vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu,vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu,vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m,vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu,vars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m,vars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex,vars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu,vars_BinlogClient_EtcdRegistry_client_client_mu,vars_BinlogClient_Security_mutex,vars_StmtCtx_mu_execDetails_CommitDetail_Mu,vars_StmtCtx_mu_execDetails_LockKeysDetail_Mu,vars_StmtCtx_mu_CommitDetail_Mu,vars_StmtCtx_mu_LockKeysDetail_Mu,vars_StmtCtx_MemTracker_mu,vars_StmtCtx_MemTracker_actionMu,vars_StmtCtx_MemTracker_parMu,vars_StmtCtx_DiskTracker_mu,vars_StmtCtx_DiskTracker_actionMu,vars_StmtCtx_DiskTracker_parMu,vars_StmtCtx_RuntimeStatsColl_mu,vars_StmtCtx_digestMemo_m,vars_SequenceState_mu,child_GetPreparedStmt480);
		child_GetPreparedStmt480?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetPreparedStmt48(Wgdef vars_BinlogClient_wg;Mutexdef vars_UsersLock;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_mu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu;Mutexdef vars_BinlogClient_EtcdRegistry_client_client_mu;Mutexdef vars_BinlogClient_Security_mutex;Mutexdef vars_StmtCtx_mu_execDetails_CommitDetail_Mu;Mutexdef vars_StmtCtx_mu_execDetails_LockKeysDetail_Mu;Mutexdef vars_StmtCtx_mu_CommitDetail_Mu;Mutexdef vars_StmtCtx_mu_LockKeysDetail_Mu;Mutexdef vars_StmtCtx_MemTracker_mu;Mutexdef vars_StmtCtx_MemTracker_actionMu;Mutexdef vars_StmtCtx_MemTracker_parMu;Mutexdef vars_StmtCtx_DiskTracker_mu;Mutexdef vars_StmtCtx_DiskTracker_actionMu;Mutexdef vars_StmtCtx_DiskTracker_parMu;Mutexdef vars_StmtCtx_RuntimeStatsColl_mu;Mutexdef vars_StmtCtx_digestMemo_m;Mutexdef vars_SequenceState_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetStmtVar1360(Wgdef name_BinlogClient_wg;Mutexdef name_UsersLock;Mutexdef name_TxnCtx_tdmLock;Mutexdef name_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu;Mutexdef name_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu;Mutexdef name_BinlogClient_EtcdRegistry_client_client_conn_mu;Mutexdef name_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu;Mutexdef name_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m;Mutexdef name_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu;Mutexdef name_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu;Mutexdef name_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu;Mutexdef name_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m;Mutexdef name_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu;Mutexdef name_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m;Mutexdef name_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex;Mutexdef name_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu;Mutexdef name_BinlogClient_EtcdRegistry_client_client_mu;Mutexdef name_BinlogClient_Security_mutex;Mutexdef name_StmtCtx_mu_execDetails_CommitDetail_Mu;Mutexdef name_StmtCtx_mu_execDetails_LockKeysDetail_Mu;Mutexdef name_StmtCtx_mu_CommitDetail_Mu;Mutexdef name_StmtCtx_mu_LockKeysDetail_Mu;Mutexdef name_StmtCtx_MemTracker_mu;Mutexdef name_StmtCtx_MemTracker_actionMu;Mutexdef name_StmtCtx_MemTracker_parMu;Mutexdef name_StmtCtx_DiskTracker_mu;Mutexdef name_StmtCtx_DiskTracker_actionMu;Mutexdef name_StmtCtx_DiskTracker_parMu;Mutexdef name_StmtCtx_RuntimeStatsColl_mu;Mutexdef name_StmtCtx_digestMemo_m;Mutexdef name_SequenceState_mu;chan child) {
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

