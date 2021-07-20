// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/labstack/echo/blob/643066594d00891e3151c7ed87244bfeddcd57b9/context_test.go#L416
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextCookie4160 = [1] of {int};
	run TestContextCookie416(child_TestContextCookie4160);
	run receiver(child_TestContextCookie4160)
stop_process:skip
}

proctype TestContextCookie416(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetCookie4012 = [1] of {int};
	chan child_Cookie3971 = [1] of {int};
	chan child_NewContext3290 = [1] of {int};
	Mutexdef c_lock;
	Mutexdef c_echo_startupMutex;
	Mutexdef e_AutoTLSManager_challengeMu;
	Mutexdef e_AutoTLSManager_renewalMu;
	Mutexdef e_AutoTLSManager_stateMu;
	Mutexdef e_AutoTLSManager_clientMu;
	Mutexdef e_TLSServer_mu;
	Mutexdef e_Server_mu;
	Mutexdef e_StdLogger_mu;
	Mutexdef e_startupMutex;
	int var_c_Cookies__c_Cookies__ = -2; // opt var_c_Cookies__c_Cookies__
	run mutexMonitor(e_startupMutex);
	run mutexMonitor(e_StdLogger_mu);
	run mutexMonitor(e_Server_mu);
	run mutexMonitor(e_TLSServer_mu);
	run mutexMonitor(e_AutoTLSManager_clientMu);
	run mutexMonitor(e_AutoTLSManager_stateMu);
	run mutexMonitor(e_AutoTLSManager_renewalMu);
	run mutexMonitor(e_AutoTLSManager_challengeMu);
	run mutexMonitor(c_echo_startupMutex);
	run mutexMonitor(c_lock);
	run NewContext329(e_AutoTLSManager_challengeMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_stateMu,e_Server_mu,e_StdLogger_mu,e_startupMutex,e_TLSServer_mu,child_NewContext3290);
	child_NewContext3290?0;
	run Cookie397(c_echo_startupMutex,c_lock,child_Cookie3971);
	child_Cookie3971?0;
	run SetCookie401(c_echo_startupMutex,c_lock,child_SetCookie4012);
	child_SetCookie4012?0;
	stop_process: skip;
	child!0
}
proctype NewContext329(Mutexdef e_AutoTLSManager_challengeMu;Mutexdef e_AutoTLSManager_clientMu;Mutexdef e_AutoTLSManager_renewalMu;Mutexdef e_AutoTLSManager_stateMu;Mutexdef e_Server_mu;Mutexdef e_StdLogger_mu;Mutexdef e_startupMutex;Mutexdef e_TLSServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Cookie397(Mutexdef c_echo_startupMutex;Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetCookie401(Mutexdef c_echo_startupMutex;Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Response2352 = [1] of {int};
	run Response235(c_echo_startupMutex,c_lock,child_Response2352);
	child_Response2352?0;
	stop_process: skip;
	child!0
}
proctype Response235(Mutexdef c_echo_startupMutex;Mutexdef c_lock;chan child) {
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

proctype receiver(chan c) {
c?0
}

