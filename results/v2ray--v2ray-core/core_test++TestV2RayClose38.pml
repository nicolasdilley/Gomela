
// https://github.com/v2ray/v2ray-core/blob/master/v2ray_test.go#L38
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestV2RayClose380 = [1] of {int};
	run TestV2RayClose38(child_TestV2RayClose380)
stop_process:skip
}

proctype TestV2RayClose38(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef server_access;
	Mutexdef config_Transport_state_atomicMessageInfo_initMu;
	Mutexdef config_state_atomicMessageInfo_initMu;
	run mutexMonitor(config_state_atomicMessageInfo_initMu);
	run mutexMonitor(config_Transport_state_atomicMessageInfo_initMu);
	run mutexMonitor(server_access);
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

