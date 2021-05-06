
// https://github.com/go-delve/delve/blob/master/service/api/conversions.go#L76
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ConvertThread760 = [1] of {int};
	run ConvertThread76(child_ConvertThread760)
stop_process:skip
}

proctype ConvertThread76(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef g_variable_bi_logger_Logger_mu_lock;
	Mutexdef g_variable_bi_Arch_sigreturnfn_cu_image_loadErrMu;
	Mutexdef g_variable_bi_Arch_crosscall2fn_cu_image_loadErrMu;
	Mutexdef g_CurrentLoc_Fn_cu_image_loadErrMu;
	Mutexdef g_stkbarVar_bi_logger_Logger_mu_lock;
	Mutexdef g_stkbarVar_bi_Arch_sigreturnfn_cu_image_loadErrMu;
	Mutexdef g_stkbarVar_bi_Arch_crosscall2fn_cu_image_loadErrMu;
	chan child_ConvertFunction2630 = [1] of {int};
	Mutexdef loc_Fn_cu_image_loadErrMu;
	run mutexMonitor(loc_Fn_cu_image_loadErrMu);
	

	if
	:: true -> 
		run ConvertFunction263(loc_Fn_cu_image_loadErrMu,child_ConvertFunction2630);
		child_ConvertFunction2630?0
	:: true;
	fi;
	run mutexMonitor(g_stkbarVar_bi_Arch_crosscall2fn_cu_image_loadErrMu);
	run mutexMonitor(g_stkbarVar_bi_Arch_sigreturnfn_cu_image_loadErrMu);
	run mutexMonitor(g_stkbarVar_bi_logger_Logger_mu_lock);
	run mutexMonitor(g_CurrentLoc_Fn_cu_image_loadErrMu);
	run mutexMonitor(g_variable_bi_Arch_crosscall2fn_cu_image_loadErrMu);
	run mutexMonitor(g_variable_bi_Arch_sigreturnfn_cu_image_loadErrMu);
	run mutexMonitor(g_variable_bi_logger_Logger_mu_lock);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ConvertFunction263(Mutexdef fn_cu_image_loadErrMu;chan child) {
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

