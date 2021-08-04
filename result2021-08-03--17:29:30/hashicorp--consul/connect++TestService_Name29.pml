// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/consul/blob/8d6cbe72813779f60ac24d119cc311c21003f4ce/connect/service_test.go#L29
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestService_Name290 = [1] of {int};
	run TestService_Name29(child_TestService_Name290);
	run receiver(child_TestService_Name290)
stop_process:skip
}

proctype TestService_Name29(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Name1560 = [1] of {int};
	Mutexdef s_leafWatch_stopLock;
	Mutexdef s_rootsWatch_stopLock;
	Mutexdef s_client_modifyLock;
	run mutexMonitor(s_client_modifyLock);
	run mutexMonitor(s_rootsWatch_stopLock);
	run mutexMonitor(s_leafWatch_stopLock);
	run Name156(s_client_modifyLock,s_leafWatch_stopLock,s_rootsWatch_stopLock,child_Name1560);
	child_Name1560?0;
	stop_process: skip;
	child!0
}
proctype Name156(Mutexdef s_client_modifyLock;Mutexdef s_leafWatch_stopLock;Mutexdef s_rootsWatch_stopLock;chan child) {
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

