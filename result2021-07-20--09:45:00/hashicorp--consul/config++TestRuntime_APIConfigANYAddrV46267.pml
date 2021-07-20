// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/consul/blob/8d6cbe72813779f60ac24d119cc311c21003f4ce/agent/config/runtime_test.go#L6267
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRuntime_APIConfigANYAddrV462670 = [1] of {int};
	run TestRuntime_APIConfigANYAddrV46267(child_TestRuntime_APIConfigANYAddrV462670);
	run receiver(child_TestRuntime_APIConfigANYAddrV462670)
stop_process:skip
}

proctype TestRuntime_APIConfigANYAddrV46267(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cfg_Transport_connsPerHostMu;
	Mutexdef cfg_Transport_altMu;
	Mutexdef cfg_Transport_reqMu;
	Mutexdef cfg_Transport_idleMu;
	run mutexMonitor(cfg_Transport_idleMu);
	run mutexMonitor(cfg_Transport_reqMu);
	run mutexMonitor(cfg_Transport_altMu);
	run mutexMonitor(cfg_Transport_connsPerHostMu);
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

