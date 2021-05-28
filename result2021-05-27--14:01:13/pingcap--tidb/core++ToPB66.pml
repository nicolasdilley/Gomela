// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/planner/core/plan_to_pb.go#L66
#define not_found_69  -2 // opt not_found_69
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ToPB660 = [1] of {int};
	run ToPB66(child_ToPB660);
	run receiver(child_ToPB660)
stop_process:skip
}

proctype ToPB66(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AggFuncToPBExpr281 = [1] of {int};
	chan child_AggFuncToPBExpr282 = [1] of {int};
	chan child_ExpressionsToPBList350 = [1] of {int};
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_mu;
	int p_AggFuncs = -2; // opt p_AggFuncs
	run mutexMonitor(sc_mu);
	run mutexMonitor(sc_RuntimeStatsColl_mu);
	run ExpressionsToPBList35(sc_mu,sc_RuntimeStatsColl_mu,not_found_69,child_ExpressionsToPBList350);
	child_ExpressionsToPBList350?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: p_AggFuncs-1 != -3 -> 
				for(i : 0.. p_AggFuncs-1) {
			for20: skip;
			run AggFuncToPBExpr28(sc_mu,sc_RuntimeStatsColl_mu,child_AggFuncToPBExpr281);
			child_AggFuncToPBExpr281?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for23: skip;
			run AggFuncToPBExpr28(sc_mu,sc_RuntimeStatsColl_mu,child_AggFuncToPBExpr282);
			child_AggFuncToPBExpr282?0;
			for23_end: skip
		:: true -> 
			break
		od;
		for23_exit: skip
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
proctype ExpressionsToPBList35(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;int exprs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AggFuncToPBExpr28(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewPBConverter551 = [1] of {int};
	int aggFunc_Args = -2; // opt aggFunc_Args
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run NewPBConverter55(sc_mu,sc_RuntimeStatsColl_mu,child_NewPBConverter551);
	child_NewPBConverter551?0;
	

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

