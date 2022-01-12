// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/cli/cli/blob//pkg/cmd/pr/checkout/checkout_test.go#L485
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPRCheckout_recurseSubmodules4850 = [1] of {int};
	run TestPRCheckout_recurseSubmodules485(child_TestPRCheckout_recurseSubmodules4850);
	run receiver(child_TestPRCheckout_recurseSubmodules4850)
stop_process:skip
}

proctype TestPRCheckout_recurseSubmodules485(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runCommand241 = [1] of {int};
	chan child_Register150 = [1] of {int};
	Mutexdef http_mu;
	run mutexMonitor(http_mu);
	run Register15(http_mu,child_Register150);
	child_Register150?0;
	run runCommand24(http_mu,child_runCommand241);
	child_runCommand241?0;
	stop_process: skip;
	child!0
}
proctype Register15(Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype runCommand24(Mutexdef rt_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewCmdCheckout371 = [1] of {int};
	Mutexdef factory_IOStreams_pagerProcess_sigMu;
	Mutexdef factory_IOStreams_progressIndicator_mu;
	Mutexdef io_pagerProcess_sigMu;
	Mutexdef io_progressIndicator_mu;
	run mutexMonitor(io_progressIndicator_mu);
	run mutexMonitor(io_pagerProcess_sigMu);
	run mutexMonitor(factory_IOStreams_progressIndicator_mu);
	run mutexMonitor(factory_IOStreams_pagerProcess_sigMu);
	run NewCmdCheckout37(factory_IOStreams_pagerProcess_sigMu,factory_IOStreams_progressIndicator_mu,child_NewCmdCheckout371);
	child_NewCmdCheckout371?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewCmdCheckout37(Mutexdef f_IOStreams_pagerProcess_sigMu;Mutexdef f_IOStreams_progressIndicator_mu;chan child) {
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

proctype receiver(chan c) {
c?0
}

