
// https://github.com/pingcap/tidb/blob/master/executor/show.go#L663
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
	chan child_fetchShowVariables6630 = [1] of {int};
	run fetchShowVariables663(child_fetchShowVariables6630)
stop_process:skip
}

proctype fetchShowVariables663(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSessionSystemVar1472 = [1] of {int};
	chan child_GetSessionSystemVar1473 = [1] of {int};
	chan child_GetGlobalSystemVar2440 = [1] of {int};
	chan child_GetGlobalSystemVar2441 = [1] of {int};
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
	int variable_GetSysVars__ = -2;
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
	

	if
	:: true -> 
		

		if
		:: variable_GetSysVars__-1 != -3 -> 
						for(i : 0.. variable_GetSysVars__-1) {
				for10: skip;
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto for10_end
					:: true;
					fi;
					run GetGlobalSystemVar244(sessionVars_BinlogClient_wg,sessionVars_UsersLock,sessionVars_TxnCtx_tdmLock,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m,sessionVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex,sessionVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_mu,sessionVars_BinlogClient_Security_mutex,sessionVars_StmtCtx_mu_execDetails_CommitDetail_Mu,sessionVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu,sessionVars_StmtCtx_mu_CommitDetail_Mu,sessionVars_StmtCtx_mu_LockKeysDetail_Mu,sessionVars_StmtCtx_MemTracker_mu,sessionVars_StmtCtx_MemTracker_actionMu,sessionVars_StmtCtx_MemTracker_parMu,sessionVars_StmtCtx_DiskTracker_mu,sessionVars_StmtCtx_DiskTracker_actionMu,sessionVars_StmtCtx_DiskTracker_parMu,sessionVars_StmtCtx_RuntimeStatsColl_mu,sessionVars_StmtCtx_digestMemo_m,sessionVars_SequenceState_mu,child_GetGlobalSystemVar2440);
					child_GetGlobalSystemVar2440?0;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi;
				for10_end: skip
			};
			for10_exit: skip
		:: else -> 
			do
			:: true -> 
				for11: skip;
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto for11_end
					:: true;
					fi;
					run GetGlobalSystemVar244(sessionVars_BinlogClient_wg,sessionVars_UsersLock,sessionVars_TxnCtx_tdmLock,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m,sessionVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex,sessionVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_mu,sessionVars_BinlogClient_Security_mutex,sessionVars_StmtCtx_mu_execDetails_CommitDetail_Mu,sessionVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu,sessionVars_StmtCtx_mu_CommitDetail_Mu,sessionVars_StmtCtx_mu_LockKeysDetail_Mu,sessionVars_StmtCtx_MemTracker_mu,sessionVars_StmtCtx_MemTracker_actionMu,sessionVars_StmtCtx_MemTracker_parMu,sessionVars_StmtCtx_DiskTracker_mu,sessionVars_StmtCtx_DiskTracker_actionMu,sessionVars_StmtCtx_DiskTracker_parMu,sessionVars_StmtCtx_RuntimeStatsColl_mu,sessionVars_StmtCtx_digestMemo_m,sessionVars_SequenceState_mu,child_GetGlobalSystemVar2441);
					child_GetGlobalSystemVar2441?0;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi;
				for11_end: skip
			:: true -> 
				break
			od;
			for11_exit: skip
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: variable_GetSysVars__-1 != -3 -> 
				for(i : 0.. variable_GetSysVars__-1) {
			for20: skip;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			run GetSessionSystemVar147(sessionVars_BinlogClient_wg,sessionVars_UsersLock,sessionVars_TxnCtx_tdmLock,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m,sessionVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex,sessionVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_mu,sessionVars_BinlogClient_Security_mutex,sessionVars_StmtCtx_mu_execDetails_CommitDetail_Mu,sessionVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu,sessionVars_StmtCtx_mu_CommitDetail_Mu,sessionVars_StmtCtx_mu_LockKeysDetail_Mu,sessionVars_StmtCtx_MemTracker_mu,sessionVars_StmtCtx_MemTracker_actionMu,sessionVars_StmtCtx_MemTracker_parMu,sessionVars_StmtCtx_DiskTracker_mu,sessionVars_StmtCtx_DiskTracker_actionMu,sessionVars_StmtCtx_DiskTracker_parMu,sessionVars_StmtCtx_RuntimeStatsColl_mu,sessionVars_StmtCtx_digestMemo_m,sessionVars_SequenceState_mu,child_GetSessionSystemVar1472);
			child_GetSessionSystemVar1472?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			

			if
			:: true -> 
				goto for21_end
			:: true;
			fi;
			run GetSessionSystemVar147(sessionVars_BinlogClient_wg,sessionVars_UsersLock,sessionVars_TxnCtx_tdmLock,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m,sessionVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex,sessionVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu,sessionVars_BinlogClient_EtcdRegistry_client_client_mu,sessionVars_BinlogClient_Security_mutex,sessionVars_StmtCtx_mu_execDetails_CommitDetail_Mu,sessionVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu,sessionVars_StmtCtx_mu_CommitDetail_Mu,sessionVars_StmtCtx_mu_LockKeysDetail_Mu,sessionVars_StmtCtx_MemTracker_mu,sessionVars_StmtCtx_MemTracker_actionMu,sessionVars_StmtCtx_MemTracker_parMu,sessionVars_StmtCtx_DiskTracker_mu,sessionVars_StmtCtx_DiskTracker_actionMu,sessionVars_StmtCtx_DiskTracker_parMu,sessionVars_StmtCtx_RuntimeStatsColl_mu,sessionVars_StmtCtx_digestMemo_m,sessionVars_SequenceState_mu,child_GetSessionSystemVar1473);
			child_GetSessionSystemVar1473?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetGlobalSystemVar244(Wgdef s_BinlogClient_wg;Mutexdef s_UsersLock;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m;Mutexdef s_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex;Mutexdef s_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_mu;Mutexdef s_BinlogClient_Security_mutex;Mutexdef s_StmtCtx_mu_execDetails_CommitDetail_Mu;Mutexdef s_StmtCtx_mu_execDetails_LockKeysDetail_Mu;Mutexdef s_StmtCtx_mu_CommitDetail_Mu;Mutexdef s_StmtCtx_mu_LockKeysDetail_Mu;Mutexdef s_StmtCtx_MemTracker_mu;Mutexdef s_StmtCtx_MemTracker_actionMu;Mutexdef s_StmtCtx_MemTracker_parMu;Mutexdef s_StmtCtx_DiskTracker_mu;Mutexdef s_StmtCtx_DiskTracker_actionMu;Mutexdef s_StmtCtx_DiskTracker_parMu;Mutexdef s_StmtCtx_RuntimeStatsColl_mu;Mutexdef s_StmtCtx_digestMemo_m;Mutexdef s_SequenceState_mu;chan child) {
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
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetSessionSystemVar147(Wgdef s_BinlogClient_wg;Mutexdef s_UsersLock;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m;Mutexdef s_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex;Mutexdef s_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu;Mutexdef s_BinlogClient_EtcdRegistry_client_client_mu;Mutexdef s_BinlogClient_Security_mutex;Mutexdef s_StmtCtx_mu_execDetails_CommitDetail_Mu;Mutexdef s_StmtCtx_mu_execDetails_LockKeysDetail_Mu;Mutexdef s_StmtCtx_mu_CommitDetail_Mu;Mutexdef s_StmtCtx_mu_LockKeysDetail_Mu;Mutexdef s_StmtCtx_MemTracker_mu;Mutexdef s_StmtCtx_MemTracker_actionMu;Mutexdef s_StmtCtx_MemTracker_parMu;Mutexdef s_StmtCtx_DiskTracker_mu;Mutexdef s_StmtCtx_DiskTracker_actionMu;Mutexdef s_StmtCtx_DiskTracker_parMu;Mutexdef s_StmtCtx_RuntimeStatsColl_mu;Mutexdef s_StmtCtx_digestMemo_m;Mutexdef s_SequenceState_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSessionOnlySysVars1632 = [1] of {int};
	run GetSessionOnlySysVars163(s_BinlogClient_wg,s_UsersLock,s_TxnCtx_tdmLock,s_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu,s_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu,s_BinlogClient_EtcdRegistry_client_client_conn_mu,s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu,s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m,s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu,s_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m,s_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex,s_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu,s_BinlogClient_EtcdRegistry_client_client_mu,s_BinlogClient_Security_mutex,s_StmtCtx_mu_execDetails_CommitDetail_Mu,s_StmtCtx_mu_execDetails_LockKeysDetail_Mu,s_StmtCtx_mu_CommitDetail_Mu,s_StmtCtx_mu_LockKeysDetail_Mu,s_StmtCtx_MemTracker_mu,s_StmtCtx_MemTracker_actionMu,s_StmtCtx_MemTracker_parMu,s_StmtCtx_DiskTracker_mu,s_StmtCtx_DiskTracker_actionMu,s_StmtCtx_DiskTracker_parMu,s_StmtCtx_RuntimeStatsColl_mu,s_StmtCtx_digestMemo_m,s_SequenceState_mu,child_GetSessionOnlySysVars1632);
	child_GetSessionOnlySysVars1632?0;
	

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
	chan child_GetSystemVar12892 = [1] of {int};
	

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
	run GetSystemVar1289(s_BinlogClient_wg,s_UsersLock,s_TxnCtx_tdmLock,s_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu,s_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu,s_BinlogClient_EtcdRegistry_client_client_conn_mu,s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu,s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m,s_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m,s_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu,s_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m,s_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex,s_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu,s_BinlogClient_EtcdRegistry_client_client_mu,s_BinlogClient_Security_mutex,s_StmtCtx_mu_execDetails_CommitDetail_Mu,s_StmtCtx_mu_execDetails_LockKeysDetail_Mu,s_StmtCtx_mu_CommitDetail_Mu,s_StmtCtx_mu_LockKeysDetail_Mu,s_StmtCtx_MemTracker_mu,s_StmtCtx_MemTracker_actionMu,s_StmtCtx_MemTracker_parMu,s_StmtCtx_DiskTracker_mu,s_StmtCtx_DiskTracker_actionMu,s_StmtCtx_DiskTracker_parMu,s_StmtCtx_RuntimeStatsColl_mu,s_StmtCtx_digestMemo_m,s_SequenceState_mu,child_GetSystemVar12892);
	child_GetSystemVar12892?0;
	

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

