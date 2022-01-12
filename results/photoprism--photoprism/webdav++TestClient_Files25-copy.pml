// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/remote/webdav/webdav_test.go#L25
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestClient_Files250 = [1] of {int};
	run TestClient_Files25(child_TestClient_Files250);
	run receiver(child_TestClient_Files250)
stop_process:skip
}

proctype TestClient_Files25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Files770 = [1] of {int};
	Mutexdef c_client_authMutex;
	run mutexMonitor(c_client_authMutex);
	run Files77(c_client_authMutex,child_Files770);
	child_Files770?0;
	stop_process: skip;
	child!0
}
proctype Files77(Mutexdef c_client_authMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_readDir680 = [1] of {int};
	int var_files = -2; // opt var_files
	run readDir68(c_client_authMutex,child_readDir680);
	child_readDir680?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype readDir68(Mutexdef c_client_authMutex;chan child) {
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

