// num_comm_params=5
// num_mand_comm_params=0
// num_opt_comm_params=5

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/planner/core/rule_generate_column_substitute.go#L80
#define exprToColumn80  -2 // opt exprToColumn80
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_substitute800 = [1] of {int};
	run substitute80(exprToColumn80,child_substitute800);
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
	int lp_Children__ = -2; // opt lp_Children__
	int x_ByItems = -2; // opt x_ByItems
	int x_Exprs = -2; // opt x_Exprs
	int sf_GetArgs__ = -2; // opt sf_GetArgs__
	int x_Conditions = -2; // opt x_Conditions
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

