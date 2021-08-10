// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/expression/helper.go#L134
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
	chan child_getStmtTimestamp1340 = [1] of {int};
	run getStmtTimestamp134(child_getStmtTimestamp1340);
	run receiver(child_getStmtTimestamp1340)
stop_process:skip
}

proctype getStmtTimestamp134(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetNowTsCached1991 = [1] of {int};
	Mutexdef stmtCtx_RuntimeStatsColl_mu;
	Mutexdef stmtCtx_mu;
	chan child_GetSessionSystemVar1470 = [1] of {int};
	Mutexdef sessionVars_SequenceState_mu;
	Wgdef sessionVars_BinlogClient_wg;
	Mutexdef sessionVars_TxnCtx_tdmLock;
	Mutexdef sessionVars_UsersLock;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(sessionVars_UsersLock);
	run mutexMonitor(sessionVars_TxnCtx_tdmLock);
	run wgMonitor(sessionVars_BinlogClient_wg);
	run mutexMonitor(sessionVars_SequenceState_mu);
	run GetSessionSystemVar147(sessionVars_BinlogClient_wg,sessionVars_SequenceState_mu,sessionVars_TxnCtx_tdmLock,sessionVars_UsersLock,child_GetSessionSystemVar1470);
	child_GetSessionSystemVar1470?0;
	

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
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(stmtCtx_mu);
	run mutexMonitor(stmtCtx_RuntimeStatsColl_mu);
	run GetNowTsCached199(stmtCtx_mu,stmtCtx_RuntimeStatsColl_mu,child_GetNowTsCached1991);
	child_GetNowTsCached1991?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetSessionSystemVar147(Wgdef s_BinlogClient_wg;Mutexdef s_SequenceState_mu;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSessionOnlySysVars1630 = [1] of {int};
	run GetSessionOnlySysVars163(s_BinlogClient_wg,s_SequenceState_mu,s_TxnCtx_tdmLock,s_UsersLock,child_GetSessionOnlySysVars1630);
	child_GetSessionOnlySysVars1630?0;
	

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
proctype GetSessionOnlySysVars163(Wgdef s_BinlogClient_wg;Mutexdef s_SequenceState_mu;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSystemVar12890 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	run GetSystemVar1289(s_BinlogClient_wg,s_SequenceState_mu,s_TxnCtx_tdmLock,s_UsersLock,child_GetSystemVar12890);
	child_GetSystemVar12890?0;
	

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
proctype GetSystemVar1289(Wgdef s_BinlogClient_wg;Mutexdef s_SequenceState_mu;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
proctype GetNowTsCached199(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
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

