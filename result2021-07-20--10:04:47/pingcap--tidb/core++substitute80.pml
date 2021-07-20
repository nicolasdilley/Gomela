// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/planner/core/rule_generate_column_substitute.go#L80
#define var_exprToColumn  -2 // opt exprToColumn line 80
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_substitute800 = [1] of {int};
	run substitute80(var_exprToColumn,child_substitute800);
	run receiver(child_substitute800)
stop_process:skip
}

proctype substitute80(int exprToColumn;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sctx_RuntimeStatsColl_mu;
	Mutexdef sctx_mu;
	int var_lp_Children__lp_Children__ = -2; // opt var_lp_Children__lp_Children__
	int var_x_ByItemsx_ByItems = -2; // opt var_x_ByItemsx_ByItems
	int var_x_Exprsx_Exprs = -2; // opt var_x_Exprsx_Exprs
	int var_sf_GetArgs__sf_GetArgs__ = -2; // opt var_sf_GetArgs__sf_GetArgs__
	int var_x_Conditionsx_Conditions = -2; // opt var_x_Conditionsx_Conditions
	run mutexMonitor(sctx_mu);
	run mutexMonitor(sctx_RuntimeStatsColl_mu);
	

	if
	:: true;
	:: true;
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

