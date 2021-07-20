// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/executor/ddl.go#L220
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
	chan child_executeDropDatabase2200 = [1] of {int};
	run executeDropDatabase220(child_executeDropDatabase2200);
	run receiver(child_executeDropDatabase2200)
stop_process:skip
}

proctype executeDropDatabase220(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetSessionSystemVar2781 = [1] of {int};
	chan child_SetSessionSystemVar2780 = [1] of {int};
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
	

	if
	:: true -> 
		run SetSessionSystemVar278(sessionVars_BinlogClient_wg,sessionVars_SequenceState_mu,sessionVars_TxnCtx_tdmLock,sessionVars_UsersLock,child_SetSessionSystemVar2780);
		child_SetSessionSystemVar2780?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run SetSessionSystemVar278(sessionVars_BinlogClient_wg,sessionVars_SequenceState_mu,sessionVars_TxnCtx_tdmLock,sessionVars_UsersLock,child_SetSessionSystemVar2781);
		child_SetSessionSystemVar2781?0;
		

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
proctype SetSessionSystemVar278(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetSystemVar13782 = [1] of {int};
	chan child_CheckDeprecationSetSystemVar3331 = [1] of {int};
	chan child_Validate1280 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Validate128(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_Validate1280);
	child_Validate1280?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run CheckDeprecationSetSystemVar333(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_CheckDeprecationSetSystemVar3331);
	child_CheckDeprecationSetSystemVar3331?0;
	run SetSystemVar1378(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_SetSystemVar13782);
	child_SetSystemVar13782?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Validate128(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_validateFromType1430 = [1] of {int};
	run validateFromType143(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_validateFromType1430);
	child_validateFromType1430?0;
	

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
proctype validateFromType143(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkUInt64SystemVar2150 = [1] of {int};
	chan child_checkInt64SystemVar2511 = [1] of {int};
	chan child_checkBoolSystemVar3032 = [1] of {int};
	chan child_checkFloatSystemVar2893 = [1] of {int};
	chan child_checkEnumSystemVar2764 = [1] of {int};
	chan child_checkTimeSystemVar1855 = [1] of {int};
	chan child_checkDurationSystemVar1996 = [1] of {int};
	

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
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run checkUInt64SystemVar215(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_checkUInt64SystemVar2150);
		child_checkUInt64SystemVar2150?0;
		goto stop_process
	:: true -> 
		run checkInt64SystemVar251(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_checkInt64SystemVar2511);
		child_checkInt64SystemVar2511?0;
		goto stop_process
	:: true -> 
		run checkBoolSystemVar303(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_checkBoolSystemVar3032);
		child_checkBoolSystemVar3032?0;
		goto stop_process
	:: true -> 
		run checkFloatSystemVar289(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_checkFloatSystemVar2893);
		child_checkFloatSystemVar2893?0;
		goto stop_process
	:: true -> 
		run checkEnumSystemVar276(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_checkEnumSystemVar2764);
		child_checkEnumSystemVar2764?0;
		goto stop_process
	:: true -> 
		run checkTimeSystemVar185(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_checkTimeSystemVar1855);
		child_checkTimeSystemVar1855?0;
		goto stop_process
	:: true -> 
		run checkDurationSystemVar199(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_checkDurationSystemVar1996);
		child_checkDurationSystemVar1996?0;
		goto stop_process
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkUInt64SystemVar215(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
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
	:: true;
	fi;
	

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
proctype checkInt64SystemVar251(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
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
	:: true;
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkBoolSystemVar303(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
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
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkFloatSystemVar289(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
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
proctype checkEnumSystemVar276(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_sv_PossibleValuessv_PossibleValues = -2; // opt var_sv_PossibleValuessv_PossibleValues
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkTimeSystemVar185(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkDurationSystemVar199(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
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
proctype CheckDeprecationSetSystemVar333(Wgdef s_BinlogClient_wg;Mutexdef s_SequenceState_mu;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype SetSystemVar1378(Wgdef s_BinlogClient_wg;Mutexdef s_SequenceState_mu;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetSessionFromHook1202 = [1] of {int};
	run SetSessionFromHook120(s_BinlogClient_wg,s_SequenceState_mu,s_TxnCtx_tdmLock,s_UsersLock,child_SetSessionFromHook1202);
	child_SetSessionFromHook1202?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetSessionFromHook120(Wgdef s_BinlogClient_wg;Mutexdef s_SequenceState_mu;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

