// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/planner/core/task.go#L1342
#define def_var_aggFuncs  -2 // opt aggFuncs line 1342
#define not_found_1190  -2 // opt exprs line 1176
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_CheckAggCanPushCop13420 = [1] of {int};
	run CheckAggCanPushCop1342(def_var_aggFuncs,child_CheckAggCanPushCop13420);
	run receiver(child_CheckAggCanPushCop13420)
stop_process:skip
}

proctype CheckAggCanPushCop1342(int var_aggFuncs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CanExprsPushDown11896 = [1] of {int};
	chan child_CanExprsPushDown11892 = [1] of {int};
	chan child_AppendWarning4271 = [1] of {int};
	chan child_AggFuncToPBExpr280 = [1] of {int};
	chan child_CanExprsPushDown11895 = [1] of {int};
	chan child_AppendWarning4274 = [1] of {int};
	chan child_AggFuncToPBExpr283 = [1] of {int};
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_mu;
	run mutexMonitor(sc_mu);
	run mutexMonitor(sc_RuntimeStatsColl_mu);
	

	if
	:: var_aggFuncs-1 != -3 -> 
				for(i : 0.. var_aggFuncs-1) {
			for10: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run AggFuncToPBExpr28(sc_mu,sc_RuntimeStatsColl_mu,child_AggFuncToPBExpr280);
			child_AggFuncToPBExpr280?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					run AppendWarning427(sc_mu,sc_RuntimeStatsColl_mu,child_AppendWarning4271);
					child_AppendWarning4271?0
				:: true;
				fi;
				goto stop_process
			:: true;
			fi;
			run CanExprsPushDown1189(sc_mu,sc_RuntimeStatsColl_mu,child_CanExprsPushDown11892);
			child_CanExprsPushDown11892?0;
			

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
			for15: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run AggFuncToPBExpr28(sc_mu,sc_RuntimeStatsColl_mu,child_AggFuncToPBExpr283);
			child_AggFuncToPBExpr283?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					run AppendWarning427(sc_mu,sc_RuntimeStatsColl_mu,child_AppendWarning4274);
					child_AppendWarning4274?0
				:: true;
				fi;
				goto stop_process
			:: true;
			fi;
			run CanExprsPushDown1189(sc_mu,sc_RuntimeStatsColl_mu,child_CanExprsPushDown11895);
			child_CanExprsPushDown11895?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for15_end: skip
		:: true -> 
			break
		od;
		for15_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run CanExprsPushDown1189(sc_mu,sc_RuntimeStatsColl_mu,child_CanExprsPushDown11896);
	child_CanExprsPushDown11896?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AggFuncToPBExpr28(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewPBConverter550 = [1] of {int};
	int var_aggFunc_Args = -2; // opt var_aggFunc_Args
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run NewPBConverter55(sc_mu,sc_RuntimeStatsColl_mu,child_NewPBConverter550);
	child_NewPBConverter550?0;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
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
proctype NewPBConverter55(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AppendWarning427(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype CanExprsPushDown1189(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PushDownExprs11762 = [1] of {int};
	run PushDownExprs1176(sc_mu,sc_RuntimeStatsColl_mu,not_found_1190,child_PushDownExprs11762);
	child_PushDownExprs11762?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype PushDownExprs1176(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;int var_exprs;chan child) {
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

