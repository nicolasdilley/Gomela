// num_comm_params=5
// num_mand_comm_params=0
// num_opt_comm_params=5

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/planner/core/plan_to_pb.go#L332
#define not_found_352  -2 // opt exprs line 35
#define not_found_356  -2 // opt exprs line 35
#define not_found_361  -2 // opt exprs line 35
#define not_found_365  -2 // opt exprs line 35
#define not_found_369  -2 // opt exprs line 35
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
	chan child_ExpressionsToPBList353 = [1] of {int};
	chan child_ExpressionsToPBList352 = [1] of {int};
	chan child_ExpressionsToPBList351 = [1] of {int};
	chan child_ExpressionsToPBList350 = [1] of {int};
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_mu;
	int var_p_EqualConditions = -2; // opt var_p_EqualConditions
	int var_p_RightJoinKeys = -2; // opt var_p_RightJoinKeys
	int var_p_LeftJoinKeys = -2; // opt var_p_LeftJoinKeys
	run mutexMonitor(sc_mu);
	run mutexMonitor(sc_RuntimeStatsColl_mu);
	

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
	run ExpressionsToPBList35(sc_mu,sc_RuntimeStatsColl_mu,not_found_352,child_ExpressionsToPBList350);
	child_ExpressionsToPBList350?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run ExpressionsToPBList35(sc_mu,sc_RuntimeStatsColl_mu,not_found_356,child_ExpressionsToPBList351);
	child_ExpressionsToPBList351?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run ExpressionsToPBList35(sc_mu,sc_RuntimeStatsColl_mu,not_found_361,child_ExpressionsToPBList352);
	child_ExpressionsToPBList352?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run ExpressionsToPBList35(sc_mu,sc_RuntimeStatsColl_mu,not_found_365,child_ExpressionsToPBList353);
	child_ExpressionsToPBList353?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run ExpressionsToPBList35(sc_mu,sc_RuntimeStatsColl_mu,not_found_369,child_ExpressionsToPBList354);
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
proctype ExpressionsToPBList35(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;int var_exprs;chan child) {
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

