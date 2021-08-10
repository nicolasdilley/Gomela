// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/consul/blob/8d6cbe72813779f60ac24d119cc311c21003f4ce/connect/resolver_test.go#L43
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConsulResolver_Resolve430 = [1] of {int};
	run TestConsulResolver_Resolve43(child_TestConsulResolver_Resolve430);
	run receiver(child_TestConsulResolver_Resolve430)
stop_process:skip
}

proctype TestConsulResolver_Resolve43(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef client_modifyLock;
	Mutexdef cfg_Transport_connsPerHostMu;
	Mutexdef cfg_Transport_altMu;
	Mutexdef cfg_Transport_reqMu;
	Mutexdef cfg_Transport_idleMu;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(cfg_Transport_idleMu);
	run mutexMonitor(cfg_Transport_reqMu);
	run mutexMonitor(cfg_Transport_altMu);
	run mutexMonitor(cfg_Transport_connsPerHostMu);
	run mutexMonitor(client_modifyLock);
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

