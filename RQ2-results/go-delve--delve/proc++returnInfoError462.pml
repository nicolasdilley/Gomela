
// https://github.com/go-delve/delve/blob/master/pkg/proc/breakpoints.go#L462
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_returnInfoError4620 = [1] of {int};
	run returnInfoError462(child_returnInfoError4620)
stop_process:skip
}

proctype returnInfoError462(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef v_bi_logger_Logger_mu_lock;
	Mutexdef v_bi_Arch_sigreturnfn_cu_image_loadErrMu;
	Mutexdef v_bi_Arch_crosscall2fn_cu_image_loadErrMu;
	run mutexMonitor(v_bi_Arch_crosscall2fn_cu_image_loadErrMu);
	run mutexMonitor(v_bi_Arch_sigreturnfn_cu_image_loadErrMu);
	run mutexMonitor(v_bi_logger_Logger_mu_lock);
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

