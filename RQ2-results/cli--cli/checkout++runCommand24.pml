
// https://github.com/cli/cli/blob/master/pkg/cmd/pr/checkout/checkout_test.go#L24
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_runCommand240 = [1] of {int};
	run runCommand24(child_runCommand240)
stop_process:skip
}

proctype runCommand24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewCmdCheckout370 = [1] of {int};
	Mutexdef factory_IOStreams_pagerProcess_sigMu;
	Mutexdef factory_IOStreams_progressIndicator_mu;
	Mutexdef io_pagerProcess_sigMu;
	Mutexdef io_progressIndicator_mu;
	run mutexMonitor(io_progressIndicator_mu);
	run mutexMonitor(io_pagerProcess_sigMu);
	run mutexMonitor(factory_IOStreams_progressIndicator_mu);
	run mutexMonitor(factory_IOStreams_pagerProcess_sigMu);
	run NewCmdCheckout37(factory_IOStreams_progressIndicator_mu,factory_IOStreams_pagerProcess_sigMu,child_NewCmdCheckout370);
	child_NewCmdCheckout370?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewCmdCheckout37(Mutexdef f_IOStreams_progressIndicator_mu;Mutexdef f_IOStreams_pagerProcess_sigMu;chan child) {
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

