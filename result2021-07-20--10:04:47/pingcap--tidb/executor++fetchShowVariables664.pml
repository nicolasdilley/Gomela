// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/executor/show.go#L664
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
	chan child_fetchShowVariables6640 = [1] of {int};
	run fetchShowVariables664(child_fetchShowVariables6640);
	run receiver(child_fetchShowVariables6640)
stop_process:skip
}

proctype fetchShowVariables664(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSessionSystemVar1552 = [1] of {int};
	chan child_GetSessionSystemVar1553 = [1] of {int};
	chan child_GetGlobalSystemVar2480 = [1] of {int};
	chan child_GetGlobalSystemVar2481 = [1] of {int};
	Mutexdef sessionVars_SequenceState_mu;
	Wgdef sessionVars_BinlogClient_wg;
	Mutexdef sessionVars_TxnCtx_tdmLock;
	Mutexdef sessionVars_UsersLock;
	int var_variable_GetSysVars__variable_GetSysVars__ = -2; // opt var_variable_GetSysVars__variable_GetSysVars__
	run mutexMonitor(sessionVars_UsersLock);
	run mutexMonitor(sessionVars_TxnCtx_tdmLock);
	run wgMonitor(sessionVars_BinlogClient_wg);
	run mutexMonitor(sessionVars_SequenceState_mu);
	

	if
	:: true -> 
		

		if
		:: var_variable_GetSysVars__-1 != -3 -> 
						for(i : 0.. var_variable_GetSysVars__-1) {
				for10: skip;
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto for10_end
					:: true;
					fi;
					run GetGlobalSystemVar248(sessionVars_BinlogClient_wg,sessionVars_SequenceState_mu,sessionVars_TxnCtx_tdmLock,sessionVars_UsersLock,child_GetGlobalSystemVar2480);
					child_GetGlobalSystemVar2480?0;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi;
				for10_end: skip
			};
			for10_exit: skip
		:: else -> 
			do
			:: true -> 
				for11: skip;
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto for11_end
					:: true;
					fi;
					run GetGlobalSystemVar248(sessionVars_BinlogClient_wg,sessionVars_SequenceState_mu,sessionVars_TxnCtx_tdmLock,sessionVars_UsersLock,child_GetGlobalSystemVar2481);
					child_GetGlobalSystemVar2481?0;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi;
				for11_end: skip
			:: true -> 
				break
			od;
			for11_exit: skip
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: var_variable_GetSysVars__-1 != -3 -> 
				for(i : 0.. var_variable_GetSysVars__-1) {
			for20: skip;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			run GetSessionSystemVar155(sessionVars_BinlogClient_wg,sessionVars_SequenceState_mu,sessionVars_TxnCtx_tdmLock,sessionVars_UsersLock,child_GetSessionSystemVar1552);
			child_GetSessionSystemVar1552?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			

			if
			:: true -> 
				goto for21_end
			:: true;
			fi;
			run GetSessionSystemVar155(sessionVars_BinlogClient_wg,sessionVars_SequenceState_mu,sessionVars_TxnCtx_tdmLock,sessionVars_UsersLock,child_GetSessionSystemVar1553);
			child_GetSessionSystemVar1553?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetGlobalSystemVar248(Wgdef s_BinlogClient_wg;Mutexdef s_SequenceState_mu;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_UsersLock;chan child) {
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetSessionSystemVar155(Wgdef s_BinlogClient_wg;Mutexdef s_SequenceState_mu;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSessionOnlySysVars1712 = [1] of {int};
	run GetSessionOnlySysVars171(s_BinlogClient_wg,s_SequenceState_mu,s_TxnCtx_tdmLock,s_UsersLock,child_GetSessionOnlySysVars1712);
	child_GetSessionOnlySysVars1712?0;
	

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
proctype GetSessionOnlySysVars171(Wgdef s_BinlogClient_wg;Mutexdef s_SequenceState_mu;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_UsersLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSystemVar12932 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
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
	run GetSystemVar1293(s_BinlogClient_wg,s_SequenceState_mu,s_TxnCtx_tdmLock,s_UsersLock,child_GetSystemVar12932);
	child_GetSystemVar12932?0;
	

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
proctype GetSystemVar1293(Wgdef s_BinlogClient_wg;Mutexdef s_SequenceState_mu;Mutexdef s_TxnCtx_tdmLock;Mutexdef s_UsersLock;chan child) {
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

