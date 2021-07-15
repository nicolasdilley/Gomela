
// https://github.com/moby/moby/blob/master/daemon/daemon_unix_test.go#L140
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
	chan child_TestParseSecurityOptWithDeprecatedColon1400 = [1] of {int};
	run TestParseSecurityOptWithDeprecatedColon140(child_TestParseSecurityOptWithDeprecatedColon1400)
stop_process:skip
}

proctype TestParseSecurityOptWithDeprecatedColon140(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ctr_attachContext_mu;
	Mutexdef ctr_LogCopier_closeOnce_m;
	Wgdef ctr_LogCopier_copyJobs;
	Mutexdef ctr_StreamConfig_stderr_mu;
	Mutexdef ctr_StreamConfig_stdout_mu;
	Wgdef ctr_StreamConfig_wg;
	run wgMonitor(ctr_StreamConfig_wg);
	run mutexMonitor(ctr_StreamConfig_stdout_mu);
	run mutexMonitor(ctr_StreamConfig_stderr_mu);
	run wgMonitor(ctr_LogCopier_copyJobs);
	run mutexMonitor(ctr_LogCopier_closeOnce_m);
	run mutexMonitor(ctr_attachContext_mu);
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

