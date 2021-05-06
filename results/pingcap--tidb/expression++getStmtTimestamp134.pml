#define not_found_280  -2
#define not_found_372  -2

// https://github.com/pingcap/tidb/blob/master/expression/helper.go#L134
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
	chan child_getStmtTimestamp1340 = [1] of {int};
	run getStmtTimestamp134(child_getStmtTimestamp1340)
stop_process:skip
}

proctype getStmtTimestamp134(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef stmtCtx_digestMemo_m;
	Mutexdef stmtCtx_RuntimeStatsColl_mu;
	Mutexdef stmtCtx_DiskTracker_parMu;
	Mutexdef stmtCtx_DiskTracker_actionMu;
	Mutexdef stmtCtx_DiskTracker_mu;
	Mutexdef stmtCtx_MemTracker_parMu;
	Mutexdef stmtCtx_MemTracker_actionMu;
	Mutexdef stmtCtx_MemTracker_mu;
	Mutexdef stmtCtx_mu_LockKeysDetail_Mu;
	Mutexdef stmtCtx_mu_CommitDetail_Mu;
	Mutexdef stmtCtx_mu_execDetails_LockKeysDetail_Mu;
	Mutexdef stmtCtx_mu_execDetails_CommitDetail_Mu;
	chan child_StrToInt2781 = [1] of {int};
	chan child_GetSessionSystemVar1470 = [1] of {int};
	Mutexdef sessionVars_SequenceState_mu;
	Mutexdef sessionVars_StmtCtx_digestMemo_m;
	Mutexdef sessionVars_StmtCtx_RuntimeStatsColl_mu;
	Mutexdef sessionVars_StmtCtx_DiskTracker_parMu;
	Mutexdef sessionVars_StmtCtx_DiskTracker_actionMu;
	Mutexdef sessionVars_StmtCtx_DiskTracker_mu;
	Mutexdef sessionVars_StmtCtx_MemTracker_parMu;
	Mutexdef sessionVars_StmtCtx_MemTracker_actionMu;
	Mutexdef sessionVars_StmtCtx_MemTracker_mu;
	Mutexdef sessionVars_StmtCtx_mu_LockKeysDetail_Mu;
	Mutexdef sessionVars_StmtCtx_mu_CommitDetail_Mu;
	Mutexdef sessionVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu;
	Mutexdef sessionVars_StmtCtx_mu_execDetails_CommitDetail_Mu;
	Mutexdef sessionVars_BinlogClient_Security_mutex;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_mu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_mu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu;
	Wgdef sessionVars_BinlogClient_wg;
	Mutexdef sessionVars_TxnCtx_tdmLock;
	Mutexdef sessionVars_UsersLock;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(sessionVars_UsersLock);
	run mutexMonitor(sessionVars_TxnCtx_tdmLock);
	run wgMonitor(sessionVars_BinlogClient_wg);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_mu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_mu);
	run mutexMonitor(sessionVars_BinlogClient_Security_mutex);
	run mutexMonitor(sessionVars_StmtCtx_mu_execDetails_CommitDetail_Mu);
	run mutexMonitor(sessionVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu);
	run mutexMonitor(sessionVars_StmtCtx_mu_CommitDetail_Mu);
	run mutexMonitor(sessionVars_StmtCtx_mu_LockKeysDetail_Mu);
	run mutexMonitor(sessionVars_StmtCtx_MemTracker_mu);
	run mutexMonitor(sessionVars_StmtCtx_MemTracker_actionMu);
	run mutexMonitor(sessionVars_StmtCtx_MemTracker_parMu);
	run mutexMonitor(sessionVars_StmtCtx_DiskTracker_mu);
	run mutexMonitor(sessionVars_StmtCtx_DiskTracker_actionMu);
	run mutexMonitor(sessionVars_StmtCtx_DiskTracker_parMu);
	run mutexMonitor(sessionVars_StmtCtx_RuntimeStatsColl_mu);
	run mutexMonitor(sessionVars_StmtCtx_digestMemo_m);
	run mutexMonitor(sessionVars_SequenceState_mu);
	run GetSessionSystemVar147(sessionVars_BinlogClient_wg,sessionVars_UsersLock,sessionVars_TxnCtx_tdmLock,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m,sessionVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex,sessionVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_mu,sessionVars_BinlogClient_Security_mutex,sessionVars_StmtCtx_mu_execDetails_CommitDetail_Mu,sessionVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu,sessionVars_StmtCtx_mu_CommitDetail_Mu,sessionVars_StmtCtx_mu_LockKeysDetail_Mu,sessionVars_StmtCtx_MemTracker_mu,sessionVars_StmtCtx_MemTracker_actionMu,sessionVars_StmtCtx_MemTracker_parMu,sessionVars_StmtCtx_DiskTracker_mu,sessionVars_StmtCtx_DiskTracker_actionMu,sessionVars_StmtCtx_DiskTracker_parMu,sessionVars_StmtCtx_RuntimeStatsColl_mu,sessionVars_StmtCtx_digestMemo_m,sessionVars_SequenceState_mu,child_GetSessionSystemVar1470);
	child_GetSessionSystemVar1470?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run StrToInt278(sessionVars_StmtCtx_mu_execDetails_CommitDetail_Mu,sessionVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu,sessionVars_StmtCtx_mu_CommitDetail_Mu,sessionVars_StmtCtx_mu_LockKeysDetail_Mu,sessionVars_StmtCtx_MemTracker_mu,sessionVars_StmtCtx_MemTracker_actionMu,sessionVars_StmtCtx_MemTracker_parMu,sessionVars_StmtCtx_DiskTracker_mu,sessionVars_StmtCtx_DiskTracker_actionMu,sessionVars_StmtCtx_DiskTracker_parMu,sessionVars_StmtCtx_RuntimeStatsColl_mu,sessionVars_StmtCtx_digestMemo_m,child_StrToInt2781);
		child_StrToInt2781?0;
		

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
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(stmtCtx_mu_execDetails_CommitDetail_Mu);
	run mutexMonitor(stmtCtx_mu_execDetails_LockKeysDetail_Mu);
	run mutexMonitor(stmtCtx_mu_CommitDetail_Mu);
	run mutexMonitor(stmtCtx_mu_LockKeysDetail_Mu);
	run mutexMonitor(stmtCtx_MemTracker_mu);
	run mutexMonitor(stmtCtx_MemTracker_actionMu);
	run mutexMonitor(stmtCtx_MemTracker_parMu);
	run mutexMonitor(stmtCtx_DiskTracker_mu);
	run mutexMonitor(stmtCtx_DiskTracker_actionMu);
	run mutexMonitor(stmtCtx_DiskTracker_parMu);
	run mutexMonitor(stmtCtx_RuntimeStatsColl_mu);
	run mutexMonitor(stmtCtx_digestMemo_m);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetSessionSystemVar147(Wgdef s_BinlogClient_wg;Mutexdef s_UsersLock;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m;Mutexdef s_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex;Mutexdef s_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_mu;Mutexdef s_BinlogClient_Security_mutex;Mutexdef s_StmtCtx_mu_execDetails_CommitDetail_Mu;Mutexdef s_StmtCtx_mu_execDetails_LockKeysDetail_Mu;Mutexdef s_StmtCtx_mu_CommitDetail_Mu;Mutexdef s_StmtCtx_mu_LockKeysDetail_Mu;Mutexdef s_StmtCtx_MemTracker_mu;Mutexdef s_StmtCtx_MemTracker_actionMu;Mutexdef s_StmtCtx_MemTracker_parMu;Mutexdef s_StmtCtx_DiskTracker_mu;Mutexdef s_StmtCtx_DiskTracker_actionMu;Mutexdef s_StmtCtx_DiskTracker_parMu;Mutexdef s_StmtCtx_RuntimeStatsColl_mu;Mutexdef s_StmtCtx_digestMemo_m;Mutexdef s_SequenceState_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSessionOnlySysVars1630 = [1] of {int};
	run GetSessionOnlySysVars163(s_BinlogClient_wg,s_UsersLock,s_TxnCtx_tdmLock,s_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu,s_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu,s_BinlogClient_EtcdRegistry_client_client_conn_mu,s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu,s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m,s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu,s_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m,s_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex,s_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu,s_BinlogClient_EtcdRegistry_client_client_mu,s_BinlogClient_Security_mutex,s_StmtCtx_mu_execDetails_CommitDetail_Mu,s_StmtCtx_mu_execDetails_LockKeysDetail_Mu,s_StmtCtx_mu_CommitDetail_Mu,s_StmtCtx_mu_LockKeysDetail_Mu,s_StmtCtx_MemTracker_mu,s_StmtCtx_MemTracker_actionMu,s_StmtCtx_MemTracker_parMu,s_StmtCtx_DiskTracker_mu,s_StmtCtx_DiskTracker_actionMu,s_StmtCtx_DiskTracker_parMu,s_StmtCtx_RuntimeStatsColl_mu,s_StmtCtx_digestMemo_m,s_SequenceState_mu,child_GetSessionOnlySysVars1630);
	child_GetSessionOnlySysVars1630?0;
	

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
proctype GetSessionOnlySysVars163(Wgdef s_BinlogClient_wg;Mutexdef s_UsersLock;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m;Mutexdef s_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex;Mutexdef s_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_mu;Mutexdef s_BinlogClient_Security_mutex;Mutexdef s_StmtCtx_mu_execDetails_CommitDetail_Mu;Mutexdef s_StmtCtx_mu_execDetails_LockKeysDetail_Mu;Mutexdef s_StmtCtx_mu_CommitDetail_Mu;Mutexdef s_StmtCtx_mu_LockKeysDetail_Mu;Mutexdef s_StmtCtx_MemTracker_mu;Mutexdef s_StmtCtx_MemTracker_actionMu;Mutexdef s_StmtCtx_MemTracker_parMu;Mutexdef s_StmtCtx_DiskTracker_mu;Mutexdef s_StmtCtx_DiskTracker_actionMu;Mutexdef s_StmtCtx_DiskTracker_parMu;Mutexdef s_StmtCtx_RuntimeStatsColl_mu;Mutexdef s_StmtCtx_digestMemo_m;Mutexdef s_SequenceState_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSystemVar12890 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	run GetSystemVar1289(s_BinlogClient_wg,s_UsersLock,s_TxnCtx_tdmLock,s_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu,s_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu,s_BinlogClient_EtcdRegistry_client_client_conn_mu,s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu,s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m,s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu,s_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m,s_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex,s_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu,s_BinlogClient_EtcdRegistry_client_client_mu,s_BinlogClient_Security_mutex,s_StmtCtx_mu_execDetails_CommitDetail_Mu,s_StmtCtx_mu_execDetails_LockKeysDetail_Mu,s_StmtCtx_mu_CommitDetail_Mu,s_StmtCtx_mu_LockKeysDetail_Mu,s_StmtCtx_MemTracker_mu,s_StmtCtx_MemTracker_actionMu,s_StmtCtx_MemTracker_parMu,s_StmtCtx_DiskTracker_mu,s_StmtCtx_DiskTracker_actionMu,s_StmtCtx_DiskTracker_parMu,s_StmtCtx_RuntimeStatsColl_mu,s_StmtCtx_digestMemo_m,s_SequenceState_mu,child_GetSystemVar12890);
	child_GetSystemVar12890?0;
	

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
proctype GetSystemVar1289(Wgdef s_BinlogClient_wg;Mutexdef s_UsersLock;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m;Mutexdef s_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex;Mutexdef s_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_mu;Mutexdef s_BinlogClient_Security_mutex;Mutexdef s_StmtCtx_mu_execDetails_CommitDetail_Mu;Mutexdef s_StmtCtx_mu_execDetails_LockKeysDetail_Mu;Mutexdef s_StmtCtx_mu_CommitDetail_Mu;Mutexdef s_StmtCtx_mu_LockKeysDetail_Mu;Mutexdef s_StmtCtx_MemTracker_mu;Mutexdef s_StmtCtx_MemTracker_actionMu;Mutexdef s_StmtCtx_MemTracker_parMu;Mutexdef s_StmtCtx_DiskTracker_mu;Mutexdef s_StmtCtx_DiskTracker_actionMu;Mutexdef s_StmtCtx_DiskTracker_parMu;Mutexdef s_StmtCtx_RuntimeStatsColl_mu;Mutexdef s_StmtCtx_digestMemo_m;Mutexdef s_SequenceState_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
proctype StrToInt278(Mutexdef sc_mu_execDetails_CommitDetail_Mu;Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef sc_mu_CommitDetail_Mu;Mutexdef sc_mu_LockKeysDetail_Mu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_RuntimeStatsColl_mu;Mutexdef sc_digestMemo_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getValidIntPrefix3661 = [1] of {int};
	run getValidIntPrefix366(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,not_found_280,child_getValidIntPrefix3661);
	child_getValidIntPrefix3661?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getValidIntPrefix366(Mutexdef sc_mu_execDetails_CommitDetail_Mu;Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef sc_mu_CommitDetail_Mu;Mutexdef sc_mu_LockKeysDetail_Mu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_RuntimeStatsColl_mu;Mutexdef sc_digestMemo_m;int str;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_floatStrToIntStr4352 = [1] of {int};
	chan child_getValidFloatPrefix6651 = [1] of {int};
	

	if
	:: true -> 
		run getValidFloatPrefix665(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,str,child_getValidFloatPrefix6651);
		child_getValidFloatPrefix6651?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run floatStrToIntStr435(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,not_found_372,child_floatStrToIntStr4352);
		child_floatStrToIntStr4352?0;
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
proctype getValidFloatPrefix665(Mutexdef sc_mu_execDetails_CommitDetail_Mu;Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef sc_mu_CommitDetail_Mu;Mutexdef sc_mu_LockKeysDetail_Mu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_RuntimeStatsColl_mu;Mutexdef sc_digestMemo_m;int s;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype floatStrToIntStr435(Mutexdef sc_mu_execDetails_CommitDetail_Mu;Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef sc_mu_CommitDetail_Mu;Mutexdef sc_mu_LockKeysDetail_Mu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_RuntimeStatsColl_mu;Mutexdef sc_digestMemo_m;int validFloat;chan child) {
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
		fi;
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

