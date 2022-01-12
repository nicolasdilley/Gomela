// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob//planner/core/common_plans.go#L299
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
	chan child_getPhysicalPlan2990 = [1] of {int};
	run getPhysicalPlan299(child_getPhysicalPlan2990);
	run receiver(child_getPhysicalPlan2990)
stop_process:skip
}

proctype getPhysicalPlan299(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetPlanDigest2352 = [1] of {int};
	chan child_SetPlanDigest2350 = [1] of {int};
	chan child_SetPlanDigest2351 = [1] of {int};
	Mutexdef stmtCtx_digestMemo_m;
	Mutexdef stmtCtx_RuntimeStatsColl_mu;
	Mutexdef stmtCtx_DiskTracker_parMu;
	Mutexdef stmtCtx_DiskTracker_actionMu;
	Mutexdef stmtCtx_DiskTracker_mu;
	Mutexdef stmtCtx_MemTracker_parMu;
	Mutexdef stmtCtx_MemTracker_actionMu;
	Mutexdef stmtCtx_MemTracker_mu;
	Mutexdef stmtCtx_mu;
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
	int var_cachedVal_TblInfo2UnionScan = -2; // opt var_cachedVal_TblInfo2UnionScan
	int var_cachedVals = -2; // opt var_cachedVals
	int var_e_UsingVars = -2; // opt var_e_UsingVars
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
	run mutexMonitor(stmtCtx_mu);
	run mutexMonitor(stmtCtx_MemTracker_mu);
	run mutexMonitor(stmtCtx_MemTracker_actionMu);
	run mutexMonitor(stmtCtx_MemTracker_parMu);
	run mutexMonitor(stmtCtx_DiskTracker_mu);
	run mutexMonitor(stmtCtx_DiskTracker_actionMu);
	run mutexMonitor(stmtCtx_DiskTracker_parMu);
	run mutexMonitor(stmtCtx_RuntimeStatsColl_mu);
	run mutexMonitor(stmtCtx_digestMemo_m);
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto REBUILD
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
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: var_cachedVals-1 != -3 -> 
								for(i : 0.. var_cachedVals-1) {
					for20: skip;
					

					if
					:: true -> 
						goto for20_end
					:: true;
					fi;
					

					if
					:: true -> 
						

						if
						:: true -> 
							goto REBUILD
						:: true;
						fi;
						

						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						run SetPlanDigest235(stmtCtx_DiskTracker_actionMu,stmtCtx_DiskTracker_mu,stmtCtx_DiskTracker_parMu,stmtCtx_digestMemo_m,stmtCtx_MemTracker_actionMu,stmtCtx_MemTracker_mu,stmtCtx_MemTracker_parMu,stmtCtx_mu,stmtCtx_RuntimeStatsColl_mu,child_SetPlanDigest2350);
						child_SetPlanDigest2350?0;
						goto stop_process
					:: true;
					fi;
					break;
					for20_end: skip
				};
				for20_exit: skip
			:: else -> 
				do
				:: true -> 
					for23: skip;
					

					if
					:: true -> 
						goto for23_end
					:: true;
					fi;
					

					if
					:: true -> 
						

						if
						:: true -> 
							goto REBUILD
						:: true;
						fi;
						

						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						run SetPlanDigest235(stmtCtx_DiskTracker_actionMu,stmtCtx_DiskTracker_mu,stmtCtx_DiskTracker_parMu,stmtCtx_digestMemo_m,stmtCtx_MemTracker_actionMu,stmtCtx_MemTracker_mu,stmtCtx_MemTracker_parMu,stmtCtx_mu,stmtCtx_RuntimeStatsColl_mu,child_SetPlanDigest2351);
						child_SetPlanDigest2351?0;
						goto stop_process
					:: true;
					fi;
					break;
					for23_end: skip
				:: true -> 
					break
				od;
				for23_exit: skip
			fi
		:: true;
		fi
	:: true;
	fi;
	REBUILD: skip;
	

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
		run SetPlanDigest235(stmtCtx_DiskTracker_actionMu,stmtCtx_DiskTracker_mu,stmtCtx_DiskTracker_parMu,stmtCtx_digestMemo_m,stmtCtx_MemTracker_actionMu,stmtCtx_MemTracker_mu,stmtCtx_MemTracker_parMu,stmtCtx_mu,stmtCtx_RuntimeStatsColl_mu,child_SetPlanDigest2352);
		child_SetPlanDigest2352?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetPlanDigest235(Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_digestMemo_m;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
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

