
// https://github.com/hashicorp/consul/blob/master/agent/config/runtime_test.go#L6248
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRuntime_APIConfigUNIX62480 = [1] of {int};
	run TestRuntime_APIConfigUNIX6248(child_TestRuntime_APIConfigUNIX62480)
stop_process:skip
}

proctype TestRuntime_APIConfigUNIX6248(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cfg_Transport_nextProtoOnce_m;
	Mutexdef cfg_Transport_TLSClientConfig_mutex;
	Mutexdef cfg_Transport_connsPerHostMu;
	Mutexdef cfg_Transport_altMu;
	Mutexdef cfg_Transport_reqMu;
	Mutexdef cfg_Transport_idleMu;
	run mutexMonitor(cfg_Transport_idleMu);
	run mutexMonitor(cfg_Transport_reqMu);
	run mutexMonitor(cfg_Transport_altMu);
	run mutexMonitor(cfg_Transport_connsPerHostMu);
	run mutexMonitor(cfg_Transport_TLSClientConfig_mutex);
	run mutexMonitor(cfg_Transport_nextProtoOnce_m);
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

