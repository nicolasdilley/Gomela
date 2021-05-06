
// https://github.com/go-delve/delve/blob/master/service/test/variables_test.go#L125
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_withTestProcessArgs1250 = [1] of {int};
	run withTestProcessArgs125(child_withTestProcessArgs1250)
stop_process:skip
}

proctype withTestProcessArgs125(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Detach20080 = [1] of {int};
	Mutexdef p_selectedGoroutine_variable_bi_logger_Logger_mu_lock;
	Mutexdef p_selectedGoroutine_variable_bi_Arch_sigreturnfn_cu_image_loadErrMu;
	Mutexdef p_selectedGoroutine_variable_bi_Arch_crosscall2fn_cu_image_loadErrMu;
	Mutexdef p_selectedGoroutine_CurrentLoc_Fn_cu_image_loadErrMu;
	Mutexdef p_selectedGoroutine_stkbarVar_bi_logger_Logger_mu_lock;
	Mutexdef p_selectedGoroutine_stkbarVar_bi_Arch_sigreturnfn_cu_image_loadErrMu;
	Mutexdef p_selectedGoroutine_stkbarVar_bi_Arch_crosscall2fn_cu_image_loadErrMu;
	run mutexMonitor(p_selectedGoroutine_stkbarVar_bi_Arch_crosscall2fn_cu_image_loadErrMu);
	run mutexMonitor(p_selectedGoroutine_stkbarVar_bi_Arch_sigreturnfn_cu_image_loadErrMu);
	run mutexMonitor(p_selectedGoroutine_stkbarVar_bi_logger_Logger_mu_lock);
	run mutexMonitor(p_selectedGoroutine_CurrentLoc_Fn_cu_image_loadErrMu);
	run mutexMonitor(p_selectedGoroutine_variable_bi_Arch_crosscall2fn_cu_image_loadErrMu);
	run mutexMonitor(p_selectedGoroutine_variable_bi_Arch_sigreturnfn_cu_image_loadErrMu);
	run mutexMonitor(p_selectedGoroutine_variable_bi_logger_Logger_mu_lock);
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	stop_process: skip;
		run Detach2008(p_selectedGoroutine_stkbarVar_bi_Arch_crosscall2fn_cu_image_loadErrMu,p_selectedGoroutine_stkbarVar_bi_Arch_sigreturnfn_cu_image_loadErrMu,p_selectedGoroutine_stkbarVar_bi_logger_Logger_mu_lock,p_selectedGoroutine_CurrentLoc_Fn_cu_image_loadErrMu,p_selectedGoroutine_variable_bi_Arch_crosscall2fn_cu_image_loadErrMu,p_selectedGoroutine_variable_bi_Arch_sigreturnfn_cu_image_loadErrMu,p_selectedGoroutine_variable_bi_logger_Logger_mu_lock,child_Detach20080);
	child_Detach20080?0;
	child!0
}
proctype Detach2008(Mutexdef c_selectedGoroutine_stkbarVar_bi_Arch_crosscall2fn_cu_image_loadErrMu;Mutexdef c_selectedGoroutine_stkbarVar_bi_Arch_sigreturnfn_cu_image_loadErrMu;Mutexdef c_selectedGoroutine_stkbarVar_bi_logger_Logger_mu_lock;Mutexdef c_selectedGoroutine_CurrentLoc_Fn_cu_image_loadErrMu;Mutexdef c_selectedGoroutine_variable_bi_Arch_crosscall2fn_cu_image_loadErrMu;Mutexdef c_selectedGoroutine_variable_bi_Arch_sigreturnfn_cu_image_loadErrMu;Mutexdef c_selectedGoroutine_variable_bi_logger_Logger_mu_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_call20140 = [1] of {int};
	run call2014(c_selectedGoroutine_stkbarVar_bi_Arch_crosscall2fn_cu_image_loadErrMu,c_selectedGoroutine_stkbarVar_bi_Arch_sigreturnfn_cu_image_loadErrMu,c_selectedGoroutine_stkbarVar_bi_logger_Logger_mu_lock,c_selectedGoroutine_CurrentLoc_Fn_cu_image_loadErrMu,c_selectedGoroutine_variable_bi_Arch_crosscall2fn_cu_image_loadErrMu,c_selectedGoroutine_variable_bi_Arch_sigreturnfn_cu_image_loadErrMu,c_selectedGoroutine_variable_bi_logger_Logger_mu_lock,child_call20140);
	child_call20140?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype call2014(Mutexdef c_selectedGoroutine_stkbarVar_bi_Arch_crosscall2fn_cu_image_loadErrMu;Mutexdef c_selectedGoroutine_stkbarVar_bi_Arch_sigreturnfn_cu_image_loadErrMu;Mutexdef c_selectedGoroutine_stkbarVar_bi_logger_Logger_mu_lock;Mutexdef c_selectedGoroutine_CurrentLoc_Fn_cu_image_loadErrMu;Mutexdef c_selectedGoroutine_variable_bi_Arch_crosscall2fn_cu_image_loadErrMu;Mutexdef c_selectedGoroutine_variable_bi_Arch_sigreturnfn_cu_image_loadErrMu;Mutexdef c_selectedGoroutine_variable_bi_logger_Logger_mu_lock;chan child) {
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

