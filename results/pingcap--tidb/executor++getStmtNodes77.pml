// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob//executor/index_advise.go#L77
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
	chan child_getStmtNodes770 = [1] of {int};
	run getStmtNodes77(child_getStmtNodes770);
	run receiver(child_getStmtNodes770)
stop_process:skip
}

proctype getStmtNodes77(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AppendWarning4270 = [1] of {int};
	chan child_AppendWarning4271 = [1] of {int};
	chan child_AppendWarning4272 = [1] of {int};
	chan child_AppendWarning4273 = [1] of {int};
	Mutexdef sv_SequenceState_mu;
	Mutexdef sv_StmtCtx_digestMemo_m;
	Mutexdef sv_StmtCtx_RuntimeStatsColl_mu;
	Mutexdef sv_StmtCtx_DiskTracker_parMu;
	Mutexdef sv_StmtCtx_DiskTracker_actionMu;
	Mutexdef sv_StmtCtx_DiskTracker_mu;
	Mutexdef sv_StmtCtx_MemTracker_parMu;
	Mutexdef sv_StmtCtx_MemTracker_actionMu;
	Mutexdef sv_StmtCtx_MemTracker_mu;
	Mutexdef sv_StmtCtx_mu;
	Mutexdef sv_BinlogClient_Security_mutex;
	Wgdef sv_BinlogClient_wg;
	Mutexdef sv_TxnCtx_tdmLock;
	Mutexdef sv_UsersLock;
	int var_warns = -2; // opt var_warns
	int var_sqls = -2; // opt var_sqls
	run mutexMonitor(sv_UsersLock);
	run mutexMonitor(sv_TxnCtx_tdmLock);
	run wgMonitor(sv_BinlogClient_wg);
	run mutexMonitor(sv_BinlogClient_Security_mutex);
	run mutexMonitor(sv_StmtCtx_mu);
	run mutexMonitor(sv_StmtCtx_MemTracker_mu);
	run mutexMonitor(sv_StmtCtx_MemTracker_actionMu);
	run mutexMonitor(sv_StmtCtx_MemTracker_parMu);
	run mutexMonitor(sv_StmtCtx_DiskTracker_mu);
	run mutexMonitor(sv_StmtCtx_DiskTracker_actionMu);
	run mutexMonitor(sv_StmtCtx_DiskTracker_parMu);
	run mutexMonitor(sv_StmtCtx_RuntimeStatsColl_mu);
	run mutexMonitor(sv_StmtCtx_digestMemo_m);
	run mutexMonitor(sv_SequenceState_mu);
	

	if
	:: var_sqls-1 != -3 -> 
				for(i : 0.. var_sqls-1) {
			for20: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: var_warns-1 != -3 -> 
								for(i : 0.. var_warns-1) {
					for21: skip;
					run AppendWarning427(sv_StmtCtx_DiskTracker_actionMu,sv_StmtCtx_DiskTracker_mu,sv_StmtCtx_DiskTracker_parMu,sv_StmtCtx_digestMemo_m,sv_StmtCtx_MemTracker_actionMu,sv_StmtCtx_MemTracker_mu,sv_StmtCtx_MemTracker_parMu,sv_StmtCtx_mu,sv_StmtCtx_RuntimeStatsColl_mu,child_AppendWarning4270);
					child_AppendWarning4270?0;
					for21_end: skip
				};
				for21_exit: skip
			:: else -> 
				do
				:: true -> 
					for22: skip;
					run AppendWarning427(sv_StmtCtx_DiskTracker_actionMu,sv_StmtCtx_DiskTracker_mu,sv_StmtCtx_DiskTracker_parMu,sv_StmtCtx_digestMemo_m,sv_StmtCtx_MemTracker_actionMu,sv_StmtCtx_MemTracker_mu,sv_StmtCtx_MemTracker_parMu,sv_StmtCtx_mu,sv_StmtCtx_RuntimeStatsColl_mu,child_AppendWarning4271);
					child_AppendWarning4271?0;
					for22_end: skip
				:: true -> 
					break
				od;
				for22_exit: skip
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for23: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: var_warns-1 != -3 -> 
								for(i : 0.. var_warns-1) {
					for24: skip;
					run AppendWarning427(sv_StmtCtx_DiskTracker_actionMu,sv_StmtCtx_DiskTracker_mu,sv_StmtCtx_DiskTracker_parMu,sv_StmtCtx_digestMemo_m,sv_StmtCtx_MemTracker_actionMu,sv_StmtCtx_MemTracker_mu,sv_StmtCtx_MemTracker_parMu,sv_StmtCtx_mu,sv_StmtCtx_RuntimeStatsColl_mu,child_AppendWarning4272);
					child_AppendWarning4272?0;
					for24_end: skip
				};
				for24_exit: skip
			:: else -> 
				do
				:: true -> 
					for25: skip;
					run AppendWarning427(sv_StmtCtx_DiskTracker_actionMu,sv_StmtCtx_DiskTracker_mu,sv_StmtCtx_DiskTracker_parMu,sv_StmtCtx_digestMemo_m,sv_StmtCtx_MemTracker_actionMu,sv_StmtCtx_MemTracker_mu,sv_StmtCtx_MemTracker_parMu,sv_StmtCtx_mu,sv_StmtCtx_RuntimeStatsColl_mu,child_AppendWarning4273);
					child_AppendWarning4273?0;
					for25_end: skip
				:: true -> 
					break
				od;
				for25_exit: skip
			fi;
			for23_end: skip
		:: true -> 
			break
		od;
		for23_exit: skip
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

