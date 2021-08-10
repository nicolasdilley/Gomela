// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/executor/ddl.go#L221
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
	chan child_executeDropDatabase2210 = [1] of {int};
	run executeDropDatabase221(child_executeDropDatabase2210);
	run receiver(child_executeDropDatabase2210)
stop_process:skip
}

proctype executeDropDatabase221(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetSessionSystemVar2741 = [1] of {int};
	chan child_SetSessionSystemVar2740 = [1] of {int};
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
		run SetSessionSystemVar274(sessionVars_BinlogClient_wg,sessionVars_SequenceState_mu,sessionVars_TxnCtx_tdmLock,sessionVars_UsersLock,child_SetSessionSystemVar2740);
		child_SetSessionSystemVar2740?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run SetSessionSystemVar274(sessionVars_BinlogClient_wg,sessionVars_SequenceState_mu,sessionVars_TxnCtx_tdmLock,sessionVars_UsersLock,child_SetSessionSystemVar2741);
		child_SetSessionSystemVar2741?0;
		

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
proctype SetSessionSystemVar274(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetSystemVar13732 = [1] of {int};
	chan child_CheckDeprecationSetSystemVar3371 = [1] of {int};
	chan child_Validate1340 = [1] of {int};
	

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
	run Validate134(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_Validate1340);
	child_Validate1340?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run CheckDeprecationSetSystemVar337(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_CheckDeprecationSetSystemVar3371);
	child_CheckDeprecationSetSystemVar3371?0;
	run SetSystemVar1373(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_SetSystemVar13732);
	child_SetSystemVar13732?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Validate134(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_validateFromType1490 = [1] of {int};
	run validateFromType149(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_validateFromType1490);
	child_validateFromType1490?0;
	

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
proctype validateFromType149(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkUInt64SystemVar2210 = [1] of {int};
	chan child_checkInt64SystemVar2571 = [1] of {int};
	chan child_checkBoolSystemVar3092 = [1] of {int};
	chan child_checkFloatSystemVar2953 = [1] of {int};
	chan child_checkEnumSystemVar2824 = [1] of {int};
	chan child_checkTimeSystemVar1915 = [1] of {int};
	chan child_checkDurationSystemVar2056 = [1] of {int};
	

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
		run checkUInt64SystemVar221(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_checkUInt64SystemVar2210);
		child_checkUInt64SystemVar2210?0;
		goto stop_process
	:: true -> 
		run checkInt64SystemVar257(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_checkInt64SystemVar2571);
		child_checkInt64SystemVar2571?0;
		goto stop_process
	:: true -> 
		run checkBoolSystemVar309(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_checkBoolSystemVar3092);
		child_checkBoolSystemVar3092?0;
		goto stop_process
	:: true -> 
		run checkFloatSystemVar295(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_checkFloatSystemVar2953);
		child_checkFloatSystemVar2953?0;
		goto stop_process
	:: true -> 
		run checkEnumSystemVar282(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_checkEnumSystemVar2824);
		child_checkEnumSystemVar2824?0;
		goto stop_process
	:: true -> 
		run checkTimeSystemVar191(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_checkTimeSystemVar1915);
		child_checkTimeSystemVar1915?0;
		goto stop_process
	:: true -> 
		run checkDurationSystemVar205(vars_BinlogClient_wg,vars_SequenceState_mu,vars_TxnCtx_tdmLock,vars_UsersLock,child_checkDurationSystemVar2056);
		child_checkDurationSystemVar2056?0;
		goto stop_process
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkUInt64SystemVar221(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
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
proctype checkInt64SystemVar257(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
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
proctype checkBoolSystemVar309(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
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
proctype checkFloatSystemVar295(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
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
proctype checkEnumSystemVar282(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_sv_PossibleValues = -2; // opt var_sv_PossibleValues
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkTimeSystemVar191(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
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
proctype checkDurationSystemVar205(Wgdef vars_BinlogClient_wg;Mutexdef vars_SequenceState_mu;Mutexdef vars_TxnCtx_tdmLock;Mutexdef vars_UsersLock;chan child) {
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
proctype CheckDeprecationSetSystemVar337(Wgdef s_BinlogClient_wg;Mutexdef s_SequenceState_mu;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_UsersLock;chan child) {
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
proctype SetSystemVar1373(Wgdef s_BinlogClient_wg;Mutexdef s_SequenceState_mu;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetSessionFromHook1262 = [1] of {int};
	

	if
	:: true -> 
		

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
		:: true;
		:: true;
		:: true;
		fi
	:: true -> 
		

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
		:: true;
		:: true;
		:: true;
		fi
	:: true -> 
		run SetSessionFromHook126(s_BinlogClient_wg,s_SequenceState_mu,s_TxnCtx_tdmLock,s_UsersLock,child_SetSessionFromHook1262);
		child_SetSessionFromHook1262?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetSessionFromHook126(Wgdef s_BinlogClient_wg;Mutexdef s_SequenceState_mu;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_UsersLock;chan child) {
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
