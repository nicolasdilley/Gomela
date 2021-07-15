
// https://github.com/jesseduffield/lazydocker/blob/master/pkg/commands/os_test.go#L168
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestOSCommandQuoteSingleQuote1680 = [1] of {int};
	run TestOSCommandQuoteSingleQuote168(child_TestOSCommandQuoteSingleQuote1680)
stop_process:skip
}

proctype TestOSCommandQuoteSingleQuote168(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Quote1760 = [1] of {int};
	Mutexdef osCommand_Log_Logger_mu_lock;
	run mutexMonitor(osCommand_Log_Logger_mu_lock);
	run Quote176(osCommand_Log_Logger_mu_lock,child_Quote1760);
	child_Quote1760?0;
	stop_process: skip;
	child!0
}
proctype Quote176(Mutexdef c_Log_Logger_mu_lock;chan child) {
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

