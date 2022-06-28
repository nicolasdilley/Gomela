// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/GoogleContainerTools/skaffold/blob//pkg/skaffold/kubernetes/portforward/resource_forwarder_test.go#L70
#define def_var_availablePorts  -2 // opt availablePorts line 70
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_mockRetrieveAvailablePort700 = [1] of {int};
	run mockRetrieveAvailablePort70(def_var_availablePorts,child_mockRetrieveAvailablePort700);
	run receiver(child_mockRetrieveAvailablePort700)
stop_process:skip
}

proctype mockRetrieveAvailablePort70(int var_availablePorts;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef lock;
	run mutexMonitor(lock);
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
