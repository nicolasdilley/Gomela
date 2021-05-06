#define not_found_118  -2

// https://github.com/pingcap/tidb/blob/master/planner/core/plan_to_pb.go#L115
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ToPB1150 = [1] of {int};
	run ToPB115(child_ToPB1150)
stop_process:skip
}

proctype ToPB115(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ExpressionsToPBList350 = [1] of {int};
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
	run ExpressionsToPBList35(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,not_found_118,child_ExpressionsToPBList350);
	child_ExpressionsToPBList350?0;
	

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
		fi
	:: true -> 
		goto stop_process
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ExpressionsToPBList35(Mutexdef sc_mu_execDetails_CommitDetail_Mu;Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef sc_mu_CommitDetail_Mu;Mutexdef sc_mu_LockKeysDetail_Mu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_RuntimeStatsColl_mu;Mutexdef sc_digestMemo_m;int exprs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ExprToPB600 = [1] of {int};
	chan child_ExprToPB601 = [1] of {int};
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
			run ExprToPB60(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_ExprToPB600);
			child_ExprToPB600?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			run ExprToPB60(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_ExprToPB601);
			child_ExprToPB601?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
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
proctype ExprToPB60(Mutexdef pc_sc_mu_execDetails_CommitDetail_Mu;Mutexdef pc_sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef pc_sc_mu_CommitDetail_Mu;Mutexdef pc_sc_mu_LockKeysDetail_Mu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_RuntimeStatsColl_mu;Mutexdef pc_sc_digestMemo_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_conOrCorColToPBExpr780 = [1] of {int};
	chan child_conOrCorColToPBExpr781 = [1] of {int};
	chan child_columnToPBExpr2022 = [1] of {int};
	chan child_scalarFuncToPBExpr2293 = [1] of {int};
	

	if
	:: true -> 
		run conOrCorColToPBExpr78(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_conOrCorColToPBExpr780);
		child_conOrCorColToPBExpr780?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		run conOrCorColToPBExpr78(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_conOrCorColToPBExpr781);
		child_conOrCorColToPBExpr781?0;
		goto stop_process
	:: true -> 
		run columnToPBExpr202(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_columnToPBExpr2022);
		child_columnToPBExpr2022?0;
		goto stop_process
	:: true -> 
		run scalarFuncToPBExpr229(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_scalarFuncToPBExpr2293);
		child_scalarFuncToPBExpr2293?0;
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
proctype scalarFuncToPBExpr229(Mutexdef pc_sc_mu_execDetails_CommitDetail_Mu;Mutexdef pc_sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef pc_sc_mu_CommitDetail_Mu;Mutexdef pc_sc_mu_LockKeysDetail_Mu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_RuntimeStatsColl_mu;Mutexdef pc_sc_digestMemo_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ExprToPB603 = [1] of {int};
	chan child_ExprToPB604 = [1] of {int};
	int expr_GetArgs__ = -2;
	

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
	:: expr_GetArgs__-1 != -3 -> 
				for(i : 0.. expr_GetArgs__-1) {
			for11: skip;
			run ExprToPB60(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_ExprToPB603);
			child_ExprToPB603?0;
			

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
			run ExprToPB60(pc_sc_mu_execDetails_CommitDetail_Mu,pc_sc_mu_execDetails_LockKeysDetail_Mu,pc_sc_mu_CommitDetail_Mu,pc_sc_mu_LockKeysDetail_Mu,pc_sc_MemTracker_mu,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_parMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_parMu,pc_sc_RuntimeStatsColl_mu,pc_sc_digestMemo_m,child_ExprToPB604);
			child_ExprToPB604?0;
			

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

