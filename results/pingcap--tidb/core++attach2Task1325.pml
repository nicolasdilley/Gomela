// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/pingcap/tidb/blob//planner/core/task.go#L1325
#define def_var_exprs  -2 // opt exprs line 1176
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
	run attach2Task1325(child_attach2Task13250);
	run receiver(child_attach2Task13250)
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
	Mutexdef sc_mu;
	Mutexdef sessVars_SequenceState_mu;
	Mutexdef sessVars_StmtCtx_digestMemo_m;
	Mutexdef sessVars_StmtCtx_RuntimeStatsColl_mu;
	Mutexdef sessVars_StmtCtx_DiskTracker_parMu;
	Mutexdef sessVars_StmtCtx_DiskTracker_actionMu;
	Mutexdef sessVars_StmtCtx_DiskTracker_mu;
	Mutexdef sessVars_StmtCtx_MemTracker_parMu;
	Mutexdef sessVars_StmtCtx_MemTracker_actionMu;
	Mutexdef sessVars_StmtCtx_MemTracker_mu;
	Mutexdef sessVars_StmtCtx_mu;
	Mutexdef sessVars_BinlogClient_Security_mutex;
	Wgdef sessVars_BinlogClient_wg;
	Mutexdef sessVars_TxnCtx_tdmLock;
	Mutexdef sessVars_UsersLock;
	run mutexMonitor(sessVars_UsersLock);
	run mutexMonitor(sessVars_TxnCtx_tdmLock);
	run wgMonitor(sessVars_BinlogClient_wg);
	run mutexMonitor(sessVars_BinlogClient_Security_mutex);
	run mutexMonitor(sessVars_StmtCtx_mu);
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
		run mutexMonitor(sc_mu);
		run mutexMonitor(sc_MemTracker_mu);
		run mutexMonitor(sc_MemTracker_actionMu);
		run mutexMonitor(sc_MemTracker_parMu);
		run mutexMonitor(sc_DiskTracker_mu);
		run mutexMonitor(sc_DiskTracker_actionMu);
		run mutexMonitor(sc_DiskTracker_parMu);
		run mutexMonitor(sc_RuntimeStatsColl_mu);
		run mutexMonitor(sc_digestMemo_m);
		run CanExprsPushDown1189(sc_DiskTracker_actionMu,sc_DiskTracker_mu,sc_DiskTracker_parMu,sc_digestMemo_m,sc_MemTracker_actionMu,sc_MemTracker_mu,sc_MemTracker_parMu,sc_mu,sc_RuntimeStatsColl_mu,child_CanExprsPushDown11890);
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
proctype CanExprsPushDown1189(Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_digestMemo_m;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PushDownExprs11760 = [1] of {int};
	int var_exprs = def_var_exprs;
	run PushDownExprs1176(sc_DiskTracker_actionMu,sc_DiskTracker_mu,sc_DiskTracker_parMu,sc_digestMemo_m,sc_MemTracker_actionMu,sc_MemTracker_mu,sc_MemTracker_parMu,sc_mu,sc_RuntimeStatsColl_mu,var_exprs,child_PushDownExprs11760);
	child_PushDownExprs11760?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype PushDownExprs1176(Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_digestMemo_m;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;int var_exprs;chan child) {
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
	Mutexdef pc_sc_mu;
	run mutexMonitor(pc_sc_mu);
	run mutexMonitor(pc_sc_MemTracker_mu);
	run mutexMonitor(pc_sc_MemTracker_actionMu);
	run mutexMonitor(pc_sc_MemTracker_parMu);
	run mutexMonitor(pc_sc_DiskTracker_mu);
	run mutexMonitor(pc_sc_DiskTracker_actionMu);
	run mutexMonitor(pc_sc_DiskTracker_parMu);
	run mutexMonitor(pc_sc_RuntimeStatsColl_mu);
	run mutexMonitor(pc_sc_digestMemo_m);
	

	if
	:: var_exprs-1 != -3 -> 
				for(i : 0.. var_exprs-1) {
			for10: skip;
			run canExprPushDown1155(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_canExprPushDown11550);
			child_canExprPushDown11550?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			run canExprPushDown1155(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_canExprPushDown11551);
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
proctype canExprPushDown1155(Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_digestMemo_m;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_mu;Mutexdef pc_sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_columnToPBExpr2022 = [1] of {int};
	chan child_conOrCorColToPBExpr781 = [1] of {int};
	chan child_conOrCorColToPBExpr783 = [1] of {int};
	chan child_columnToPBExpr2024 = [1] of {int};
	chan child_canScalarFuncPushDown11165 = [1] of {int};
	chan child_AppendWarning4270 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			run AppendWarning427(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_AppendWarning4270);
			child_AppendWarning4270?0
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run conOrCorColToPBExpr78(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_conOrCorColToPBExpr781);
		child_conOrCorColToPBExpr781?0;
		run columnToPBExpr202(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_columnToPBExpr2022);
		child_columnToPBExpr2022?0;
		goto stop_process
	:: true -> 
		run conOrCorColToPBExpr78(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_conOrCorColToPBExpr783);
		child_conOrCorColToPBExpr783?0;
		goto stop_process
	:: true -> 
		run columnToPBExpr202(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_columnToPBExpr2024);
		child_columnToPBExpr2024?0;
		goto stop_process
	:: true -> 
		run canScalarFuncPushDown1116(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_canScalarFuncPushDown11165);
		child_canScalarFuncPushDown11165?0;
		goto stop_process
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AppendWarning427(Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_digestMemo_m;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype conOrCorColToPBExpr78(Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_digestMemo_m;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_mu;Mutexdef pc_sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_encodeDatum961 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run encodeDatum96(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_encodeDatum961);
	child_encodeDatum961?0;
	

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
proctype encodeDatum96(Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_digestMemo_m;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_mu;Mutexdef pc_sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_EncodeMySQLTime1771 = [1] of {int};
	

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
			run EncodeMySQLTime177(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_EncodeMySQLTime1771);
			child_EncodeMySQLTime1771?0;
			

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
proctype EncodeMySQLTime177(Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_digestMemo_m;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
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
proctype columnToPBExpr202(Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_digestMemo_m;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_mu;Mutexdef pc_sc_RuntimeStatsColl_mu;chan child) {
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
proctype canScalarFuncPushDown1116(Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_digestMemo_m;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_mu;Mutexdef pc_sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_canExprPushDown11556 = [1] of {int};
	chan child_canExprPushDown11557 = [1] of {int};
	chan child_AppendWarning4275 = [1] of {int};
	int var_scalarFunc_GetArgs = -2; // opt var_scalarFunc_GetArgs
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run AppendWarning427(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_AppendWarning4275);
			child_AppendWarning4275?0
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: var_scalarFunc_GetArgs-1 != -3 -> 
				for(i : 0.. var_scalarFunc_GetArgs-1) {
			for11: skip;
			run canExprPushDown1155(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_canExprPushDown11556);
			child_canExprPushDown11556?0;
			

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
			run canExprPushDown1155(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_canExprPushDown11557);
			child_canExprPushDown11557?0;
			

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

proctype receiver(chan c) {
c?0
}

