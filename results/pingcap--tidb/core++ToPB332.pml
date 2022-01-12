// num_comm_params=5
// num_mand_comm_params=0
// num_opt_comm_params=5

// git_link=https://github.com/pingcap/tidb/blob//planner/core/plan_to_pb.go#L332
#define def_var_leftJoinKeys  -2 // opt exprs line 35
#define def_var_rightJoinKeys  -2 // opt exprs line 35
#define def_var_p_LeftConditions  -2 // opt exprs line 35
#define def_var_p_RightConditions  -2 // opt exprs line 35
#define def_var_p_OtherConditions  -2 // opt exprs line 35
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ToPB3320 = [1] of {int};
	run ToPB332(child_ToPB3320);
	run receiver(child_ToPB3320)
stop_process:skip
}

proctype ToPB332(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ExpressionsToPBList354 = [1] of {int};
	int var_p_OtherConditions = def_var_p_OtherConditions;
	chan child_ExpressionsToPBList353 = [1] of {int};
	int var_p_RightConditions = def_var_p_RightConditions;
	chan child_ExpressionsToPBList352 = [1] of {int};
	int var_p_LeftConditions = def_var_p_LeftConditions;
	chan child_ExpressionsToPBList351 = [1] of {int};
	int var_rightJoinKeys = def_var_rightJoinKeys;
	chan child_ExpressionsToPBList350 = [1] of {int};
	int var_leftJoinKeys = def_var_leftJoinKeys;
	Mutexdef sc_digestMemo_m;
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_DiskTracker_parMu;
	Mutexdef sc_DiskTracker_actionMu;
	Mutexdef sc_DiskTracker_mu;
	Mutexdef sc_MemTracker_parMu;
	Mutexdef sc_MemTracker_actionMu;
	Mutexdef sc_MemTracker_mu;
	Mutexdef sc_mu;
	int var_p_EqualConditions = -2; // opt var_p_EqualConditions
	int var_p_RightJoinKeys = -2; // opt var_p_RightJoinKeys
	int var_p_LeftJoinKeys = -2; // opt var_p_LeftJoinKeys
	run mutexMonitor(sc_mu);
	run mutexMonitor(sc_MemTracker_mu);
	run mutexMonitor(sc_MemTracker_actionMu);
	run mutexMonitor(sc_MemTracker_parMu);
	run mutexMonitor(sc_DiskTracker_mu);
	run mutexMonitor(sc_DiskTracker_actionMu);
	run mutexMonitor(sc_DiskTracker_parMu);
	run mutexMonitor(sc_RuntimeStatsColl_mu);
	run mutexMonitor(sc_digestMemo_m);
	

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
	run ExpressionsToPBList35(sc_DiskTracker_actionMu,sc_DiskTracker_mu,sc_DiskTracker_parMu,sc_digestMemo_m,sc_MemTracker_actionMu,sc_MemTracker_mu,sc_MemTracker_parMu,sc_mu,sc_RuntimeStatsColl_mu,var_leftJoinKeys,child_ExpressionsToPBList350);
	child_ExpressionsToPBList350?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run ExpressionsToPBList35(sc_DiskTracker_actionMu,sc_DiskTracker_mu,sc_DiskTracker_parMu,sc_digestMemo_m,sc_MemTracker_actionMu,sc_MemTracker_mu,sc_MemTracker_parMu,sc_mu,sc_RuntimeStatsColl_mu,var_rightJoinKeys,child_ExpressionsToPBList351);
	child_ExpressionsToPBList351?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run ExpressionsToPBList35(sc_DiskTracker_actionMu,sc_DiskTracker_mu,sc_DiskTracker_parMu,sc_digestMemo_m,sc_MemTracker_actionMu,sc_MemTracker_mu,sc_MemTracker_parMu,sc_mu,sc_RuntimeStatsColl_mu,var_p_LeftConditions,child_ExpressionsToPBList352);
	child_ExpressionsToPBList352?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run ExpressionsToPBList35(sc_DiskTracker_actionMu,sc_DiskTracker_mu,sc_DiskTracker_parMu,sc_digestMemo_m,sc_MemTracker_actionMu,sc_MemTracker_mu,sc_MemTracker_parMu,sc_mu,sc_RuntimeStatsColl_mu,var_p_RightConditions,child_ExpressionsToPBList353);
	child_ExpressionsToPBList353?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run ExpressionsToPBList35(sc_DiskTracker_actionMu,sc_DiskTracker_mu,sc_DiskTracker_parMu,sc_digestMemo_m,sc_MemTracker_actionMu,sc_MemTracker_mu,sc_MemTracker_parMu,sc_mu,sc_RuntimeStatsColl_mu,var_p_OtherConditions,child_ExpressionsToPBList354);
	child_ExpressionsToPBList354?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ExpressionsToPBList35(Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_digestMemo_m;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;int var_exprs;chan child) {
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
			for30: skip;
			run ExprToPB60(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_ExprToPB600);
			child_ExprToPB600?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for33: skip;
			run ExprToPB60(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_ExprToPB601);
			child_ExprToPB601?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for33_end: skip
		:: true -> 
			break
		od;
		for33_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ExprToPB60(Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_digestMemo_m;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_mu;Mutexdef pc_sc_RuntimeStatsColl_mu;chan child) {
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
		run conOrCorColToPBExpr78(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_conOrCorColToPBExpr780);
		child_conOrCorColToPBExpr780?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		run conOrCorColToPBExpr78(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_conOrCorColToPBExpr781);
		child_conOrCorColToPBExpr781?0;
		goto stop_process
	:: true -> 
		run columnToPBExpr202(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_columnToPBExpr2022);
		child_columnToPBExpr2022?0;
		goto stop_process
	:: true -> 
		run scalarFuncToPBExpr229(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_scalarFuncToPBExpr2293);
		child_scalarFuncToPBExpr2293?0;
		goto stop_process
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype conOrCorColToPBExpr78(Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_digestMemo_m;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_mu;Mutexdef pc_sc_RuntimeStatsColl_mu;chan child) {
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
	run encodeDatum96(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_encodeDatum960);
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
proctype encodeDatum96(Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_digestMemo_m;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_mu;Mutexdef pc_sc_RuntimeStatsColl_mu;chan child) {
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
			run EncodeMySQLTime177(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_EncodeMySQLTime1770);
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
proctype scalarFuncToPBExpr229(Mutexdef pc_sc_DiskTracker_actionMu;Mutexdef pc_sc_DiskTracker_mu;Mutexdef pc_sc_DiskTracker_parMu;Mutexdef pc_sc_digestMemo_m;Mutexdef pc_sc_MemTracker_actionMu;Mutexdef pc_sc_MemTracker_mu;Mutexdef pc_sc_MemTracker_parMu;Mutexdef pc_sc_mu;Mutexdef pc_sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ExprToPB603 = [1] of {int};
	chan child_ExprToPB604 = [1] of {int};
	int var_expr_GetArgs = -2; // opt var_expr_GetArgs
	

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
	:: var_expr_GetArgs-1 != -3 -> 
				for(i : 0.. var_expr_GetArgs-1) {
			for31: skip;
			run ExprToPB60(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_ExprToPB603);
			child_ExprToPB603?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for32: skip;
			run ExprToPB60(pc_sc_DiskTracker_actionMu,pc_sc_DiskTracker_mu,pc_sc_DiskTracker_parMu,pc_sc_digestMemo_m,pc_sc_MemTracker_actionMu,pc_sc_MemTracker_mu,pc_sc_MemTracker_parMu,pc_sc_mu,pc_sc_RuntimeStatsColl_mu,child_ExprToPB604);
			child_ExprToPB604?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for32_end: skip
		:: true -> 
			break
		od;
		for32_exit: skip
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

proctype receiver(chan c) {
c?0
}

