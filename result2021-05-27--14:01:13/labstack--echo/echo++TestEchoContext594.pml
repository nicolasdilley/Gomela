// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/labstack/echo/blob/643066594d00891e3151c7ed87244bfeddcd57b9/echo_test.go#L594
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEchoContext5940 = [1] of {int};
	run TestEchoContext594(child_TestEchoContext5940);
	run receiver(child_TestEchoContext5940)
stop_process:skip
}

proctype TestEchoContext594(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ReleaseContext6201 = [1] of {int};
	chan child_AcquireContext6140 = [1] of {int};
	Mutexdef e_AutoTLSManager_challengeMu;
	Mutexdef e_AutoTLSManager_renewalMu;
	Mutexdef e_AutoTLSManager_stateMu;
	Mutexdef e_AutoTLSManager_clientMu;
	Mutexdef e_TLSServer_mu;
	Mutexdef e_Server_mu;
	Mutexdef e_StdLogger_mu;
	Mutexdef e_startupMutex;
	run mutexMonitor(e_startupMutex);
	run mutexMonitor(e_StdLogger_mu);
	run mutexMonitor(e_Server_mu);
	run mutexMonitor(e_TLSServer_mu);
	run mutexMonitor(e_AutoTLSManager_clientMu);
	run mutexMonitor(e_AutoTLSManager_stateMu);
	run mutexMonitor(e_AutoTLSManager_renewalMu);
	run mutexMonitor(e_AutoTLSManager_challengeMu);
	run AcquireContext614(e_AutoTLSManager_challengeMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_stateMu,e_Server_mu,e_StdLogger_mu,e_startupMutex,e_TLSServer_mu,child_AcquireContext6140);
	child_AcquireContext6140?0;
	run ReleaseContext620(e_AutoTLSManager_challengeMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_stateMu,e_Server_mu,e_StdLogger_mu,e_startupMutex,e_TLSServer_mu,child_ReleaseContext6201);
	child_ReleaseContext6201?0;
	stop_process: skip;
	child!0
}
proctype AcquireContext614(Mutexdef e_AutoTLSManager_challengeMu;Mutexdef e_AutoTLSManager_clientMu;Mutexdef e_AutoTLSManager_renewalMu;Mutexdef e_AutoTLSManager_stateMu;Mutexdef e_Server_mu;Mutexdef e_StdLogger_mu;Mutexdef e_startupMutex;Mutexdef e_TLSServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ReleaseContext620(Mutexdef e_AutoTLSManager_challengeMu;Mutexdef e_AutoTLSManager_clientMu;Mutexdef e_AutoTLSManager_renewalMu;Mutexdef e_AutoTLSManager_stateMu;Mutexdef e_Server_mu;Mutexdef e_StdLogger_mu;Mutexdef e_startupMutex;Mutexdef e_TLSServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

