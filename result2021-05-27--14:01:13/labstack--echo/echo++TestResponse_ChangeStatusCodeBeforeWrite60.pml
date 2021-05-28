// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/labstack/echo/blob/643066594d00891e3151c7ed87244bfeddcd57b9/response_test.go#L60
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestResponse_ChangeStatusCodeBeforeWrite600 = [1] of {int};
	run TestResponse_ChangeStatusCodeBeforeWrite60(child_TestResponse_ChangeStatusCodeBeforeWrite600);
	run receiver(child_TestResponse_ChangeStatusCodeBeforeWrite600)
stop_process:skip
}

proctype TestResponse_ChangeStatusCodeBeforeWrite60(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WriteHeader541 = [1] of {int};
	chan child_Before400 = [1] of {int};
	Mutexdef res_echo_startupMutex;
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
	run mutexMonitor(res_echo_startupMutex);
	run Before40(res_echo_startupMutex,child_Before400);
	child_Before400?0;
	run WriteHeader54(res_echo_startupMutex,child_WriteHeader541);
	child_WriteHeader541?0;
	stop_process: skip;
	child!0
}
proctype Before40(Mutexdef r_echo_startupMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype WriteHeader54(Mutexdef r_echo_startupMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int r_beforeFuncs = -2; // opt r_beforeFuncs
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

