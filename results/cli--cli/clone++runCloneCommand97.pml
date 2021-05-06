
// https://github.com/cli/cli/blob/master/pkg/cmd/repo/clone/clone_test.go#L97
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_runCloneCommand970 = [1] of {int};
	run runCloneCommand97(child_runCloneCommand970)
stop_process:skip
}

proctype runCloneCommand97(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewCmdClone280 = [1] of {int};
	Mutexdef fac_IOStreams_pagerProcess_sigMu;
	Mutexdef fac_IOStreams_progressIndicator_mu;
	Mutexdef io_pagerProcess_sigMu;
	Mutexdef io_progressIndicator_mu;
	run mutexMonitor(io_progressIndicator_mu);
	run mutexMonitor(io_pagerProcess_sigMu);
	run mutexMonitor(fac_IOStreams_progressIndicator_mu);
	run mutexMonitor(fac_IOStreams_pagerProcess_sigMu);
	run NewCmdClone28(fac_IOStreams_progressIndicator_mu,fac_IOStreams_pagerProcess_sigMu,child_NewCmdClone280);
	child_NewCmdClone280?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewCmdClone28(Mutexdef f_IOStreams_progressIndicator_mu;Mutexdef f_IOStreams_pagerProcess_sigMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef opts_IO_pagerProcess_sigMu;
	Mutexdef opts_IO_progressIndicator_mu;
	run mutexMonitor(opts_IO_progressIndicator_mu);
	run mutexMonitor(opts_IO_pagerProcess_sigMu);
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

