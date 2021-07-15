#define not_found_1190  -2

// https://github.com/pingcap/tidb/blob/master/planner/core/task.go#L1325
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
	chan child_attach2Task13250 = [1] of {int};
	run attach2Task1325(child_attach2Task13250)
stop_process:skip
}

proctype attach2Task1325(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CanExprsPushDown11890 = [1] of {int};
	Mutexdef sc_digestMemo_m;
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_DiskTracker_parMu;
	Mutexdef sc_DiskTracker_actionMu;
	Mutexdef sc_DiskTracker_mu;
	Mutexdef sc_MemTracker_parMu;
	Mutexdef sc_MemTracker_actionMu;
	Mutexdef sc_MemTracker_mu;
	Mutexdef sc_mu_LockKeysDetail_Mu;
	Mutexdef sc_mu_CommitDetail_Mu;
	Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;
	Mutexdef sc_mu_execDetails_CommitDetail_Mu;
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
	

	if
	:: true -> 
		run mutexMonitor(sc_mu_execDetails_CommitDetail_Mu);
		run mutexMonitor(sc_mu_execDetails_LockKeysDetail_Mu);
		run mutexMonitor(sc_mu_CommitDetail_Mu);
		run mutexMonitor(sc_mu_LockKeysDetail_Mu);
		run mutexMonitor(sc_MemTracker_mu);
		run mutexMonitor(sc_MemTracker_actionMu);
		run mutexMonitor(sc_MemTracker_parMu);
		run mutexMonitor(sc_DiskTracker_mu);
		run mutexMonitor(sc_DiskTracker_actionMu);
		run mutexMonitor(sc_DiskTracker_parMu);
		run mutexMonitor(sc_RuntimeStatsColl_mu);
		run mutexMonitor(sc_digestMemo_m);
		run CanExprsPushDown1189(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,child_CanExprsPushDown11890);
		child_CanExprsPushDown11890?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype CanExprsPushDown1189(Mutexdef sc_mu_execDetails_CommitDetail_Mu;Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef sc_mu_CommitDetail_Mu;Mutexdef sc_mu_LockKeysDetail_Mu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_RuntimeStatsColl_mu;Mutexdef sc_digestMemo_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PushDownExprs11760 = [1] of {int};
	run PushDownExprs1176(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,not_found_1190,child_PushDownExprs11760);
	child_PushDownExprs11760?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype PushDownExprs1176(Mutexdef sc_mu_execDetails_CommitDetail_Mu;Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef sc_mu_CommitDetail_Mu;Mutexdef sc_mu_LockKeysDetail_Mu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_RuntimeStatsColl_mu;Mutexdef sc_digestMemo_m;int exprs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_canExprPushDown11550 = [1] of {int};
	chan child_canExprPushDown11551 = [1] of {int};
	Mutexdef pc_sc_digestMemo_m;
	Mutexdef pc_sc_RuntimeStatsColl_mu;
	Mutexdef pc_sc_DiskTracker_parMu;
	Mutexdef pc_sc_DiskTracker_actionMu;
	Mutexdef pc_sc_DiskTracker_mu;
	Mutexdef pc_sc_MemTracker_parMu;
	Mutexdef pc_sc_MemTracker_actionMu;
	Mutexdef pc_sc_MemTracker_mu;
	Mutexdef pc_sc_mu_LockKeysDetail_Mu;
	Mutexdef pc_sc_mu_CommitDetail_Mu;
	Mutexdef pc_sc_mu_execDetails_LockKeysDetail_Mu;
	Mutexdef pc_sc_mu_execDetails_CommitDetail_Mu;
	run mutexMonitor(pc_sc_mu_execDetails_CommitDetail_Mu);
	run mutexMonitor(pc_sc_mu_execDetails_LockKeysDetail_Mu);
	run mutexMonitor(pc_sc_mu_CommitDetail_Mu);
	run mutexMonitor(pc_sc_mu_LockKeysDetail_Mu);
	run mutexMonitor(pc_sc_MemTracker_mu);
	run mutexMonitor(pc_sc_MemTracker_actionMu);
	run mutexMonitor(pc_sc_MemTracker_parMu);
	run mutexMonitor(pc_sc_DiskTracker_mu);
	run mutexMonitor(pc_sc_DiskTracker_actionMu);
	run mutexMonitor(pc_sc_DiskTracker_parMu);
	run mutexMonitor(pc_sc_RuntimeStatsColl_mu);
	run mutexMonitor(pc_sc_digestMemo_m);
	

	if
	:: exprs-1 != -3 -> 
				for(i : 0.. exprs-1) {
			for10: skip;
			run canExprPushDown1155(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_canExprPushDown11550);
			child_canExprPushDown11550?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			run canExprPushDown1155(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_canExprPushDown11551);
			child_canExprPushDown11551?0;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype canExprPushDown1155(Mutexdef pc_sc_mu_execDetails_CommitDetail_Mu;Mutexdef pc_sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef pc_sc_mu_CommitDetail_Mu;Mutexdef pc_sc_mu_LockKeysDetail_Mu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_RuntimeStatsColl_mu;Mutexdef pc_sc_digestMemo_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_columnToPBExpr2021 = [1] of {int};
	chan child_conOrCorColToPBExpr780 = [1] of {int};
	chan child_conOrCorColToPBExpr782 = [1] of {int};
	chan child_columnToPBExpr2023 = [1] of {int};
	chan child_canScalarFuncPushDown11164 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run conOrCorColToPBExpr78(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_conOrCorColToPBExpr780);
		child_conOrCorColToPBExpr780?0;
		run columnToPBExpr202(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_columnToPBExpr2021);
		child_columnToPBExpr2021?0;
		goto stop_process
	:: true -> 
		run conOrCorColToPBExpr78(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_conOrCorColToPBExpr782);
		child_conOrCorColToPBExpr782?0;
		goto stop_process
	:: true -> 
		run columnToPBExpr202(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_columnToPBExpr2023);
		child_columnToPBExpr2023?0;
		goto stop_process
	:: true -> 
		run canScalarFuncPushDown1116(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_canScalarFuncPushDown11164);
		child_canScalarFuncPushDown11164?0;
		goto stop_process
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype conOrCorColToPBExpr78(Mutexdef pc_sc_mu_execDetails_CommitDetail_Mu;Mutexdef pc_sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef pc_sc_mu_CommitDetail_Mu;Mutexdef pc_sc_mu_LockKeysDetail_Mu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_RuntimeStatsColl_mu;Mutexdef pc_sc_digestMemo_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_encodeDatum960 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run encodeDatum96(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_encodeDatum960);
	child_encodeDatum960?0;
	

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
proctype encodeDatum96(Mutexdef pc_sc_mu_execDetails_CommitDetail_Mu;Mutexdef pc_sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef pc_sc_mu_CommitDetail_Mu;Mutexdef pc_sc_mu_LockKeysDetail_Mu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_RuntimeStatsColl_mu;Mutexdef pc_sc_digestMemo_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_EncodeMySQLTime1770 = [1] of {int};
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			run EncodeMySQLTime177(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_EncodeMySQLTime1770);
			child_EncodeMySQLTime1770?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype EncodeMySQLTime177(Mutexdef sc_mu_execDetails_CommitDetail_Mu;Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef sc_mu_CommitDetail_Mu;Mutexdef sc_mu_LockKeysDetail_Mu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_RuntimeStatsColl_mu;Mutexdef sc_digestMemo_m;chan child) {
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
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype columnToPBExpr202(Mutexdef pc_sc_mu_execDetails_CommitDetail_Mu;Mutexdef pc_sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef pc_sc_mu_CommitDetail_Mu;Mutexdef pc_sc_mu_LockKeysDetail_Mu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_RuntimeStatsColl_mu;Mutexdef pc_sc_digestMemo_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
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
proctype canScalarFuncPushDown1116(Mutexdef pc_sc_mu_execDetails_CommitDetail_Mu;Mutexdef pc_sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef pc_sc_mu_CommitDetail_Mu;Mutexdef pc_sc_mu_LockKeysDetail_Mu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_RuntimeStatsColl_mu;Mutexdef pc_sc_digestMemo_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_canExprPushDown11554 = [1] of {int};
	chan child_canExprPushDown11555 = [1] of {int};
	int scalarFunc_GetArgs__ = -2;
	

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
	:: scalarFunc_GetArgs__-1 != -3 -> 
				for(i : 0.. scalarFunc_GetArgs__-1) {
			for11: skip;
			run canExprPushDown1155(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_canExprPushDown11554);
			child_canExprPushDown11554?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for12: skip;
			run canExprPushDown1155(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_canExprPushDown11555);
			child_canExprPushDown11555?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for12_end: skip
		:: true -> 
			break
		od;
		for12_exit: skip
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

