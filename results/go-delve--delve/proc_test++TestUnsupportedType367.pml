
// https://github.com/go-delve/delve/blob/master/pkg/proc/dwarf_expr_test.go#L367
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUnsupportedType3670 = [1] of {int};
	run TestUnsupportedType367(child_TestUnsupportedType3670)
stop_process:skip
}

proctype TestUnsupportedType367(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __logger_Logger_mu_lock;
	Mutexdef __Arch_sigreturnfn_cu_image_loadErrMu;
	Mutexdef __Arch_crosscall2fn_cu_image_loadErrMu;
	run mutexMonitor(__Arch_crosscall2fn_cu_image_loadErrMu);
	run mutexMonitor(__Arch_sigreturnfn_cu_image_loadErrMu);
	run mutexMonitor(__logger_Logger_mu_lock);
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

