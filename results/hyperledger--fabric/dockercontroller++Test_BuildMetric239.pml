// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/container/dockercontroller/dockercontroller_test.go#L239
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_BuildMetric2390 = [1] of {int};
	run Test_BuildMetric239(child_Test_BuildMetric2390);
	run receiver(child_Test_BuildMetric2390)
stop_process:skip
}

proctype Test_BuildMetric239(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef client_invocationsMutex;
	Mutexdef client_waitContainerMutex;
	Mutexdef client_uploadToContainerMutex;
	Mutexdef client_stopContainerMutex;
	Mutexdef client_startContainerMutex;
	Mutexdef client_removeContainerMutex;
	Mutexdef client_pingWithContextMutex;
	Mutexdef client_killContainerMutex;
	Mutexdef client_inspectImageMutex;
	Mutexdef client_createContainerMutex;
	Mutexdef client_buildImageMutex;
	Mutexdef client_attachToContainerMutex;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(client_attachToContainerMutex);
	run mutexMonitor(client_buildImageMutex);
	run mutexMonitor(client_createContainerMutex);
	run mutexMonitor(client_inspectImageMutex);
	run mutexMonitor(client_killContainerMutex);
	run mutexMonitor(client_pingWithContextMutex);
	run mutexMonitor(client_removeContainerMutex);
	run mutexMonitor(client_startContainerMutex);
	run mutexMonitor(client_stopContainerMutex);
	run mutexMonitor(client_uploadToContainerMutex);
	run mutexMonitor(client_waitContainerMutex);
	run mutexMonitor(client_invocationsMutex);
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

