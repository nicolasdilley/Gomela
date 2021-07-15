
// https://github.com/mattermost/mattermost-server/blob/master/config/emitter_test.go#L56
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLogSrcEmitter560 = [1] of {int};
	run TestLogSrcEmitter56(child_TestLogSrcEmitter560)
stop_process:skip
}

proctype TestLogSrcEmitter56(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_invokeConfigListeners606 = [1] of {int};
	chan child_RemoveListener555 = [1] of {int};
	chan child_invokeConfigListeners604 = [1] of {int};
	chan child_RemoveListener553 = [1] of {int};
	chan child_invokeConfigListeners602 = [1] of {int};
	chan child_AddListener481 = [1] of {int};
	chan child_AddListener480 = [1] of {int};
	Mutexdef e_listeners_mu;
	run mutexMonitor(e_listeners_mu);
	run AddListener48(e_listeners_mu,child_AddListener480);
	child_AddListener480?0;
	run AddListener48(e_listeners_mu,child_AddListener481);
	child_AddListener481?0;
	run invokeConfigListeners60(e_listeners_mu,child_invokeConfigListeners602);
	child_invokeConfigListeners602?0;
	run RemoveListener55(e_listeners_mu,child_RemoveListener553);
	child_RemoveListener553?0;
	run invokeConfigListeners60(e_listeners_mu,child_invokeConfigListeners604);
	child_invokeConfigListeners604?0;
	run RemoveListener55(e_listeners_mu,child_RemoveListener555);
	child_RemoveListener555?0;
	run invokeConfigListeners60(e_listeners_mu,child_invokeConfigListeners606);
	child_invokeConfigListeners606?0;
	stop_process: skip;
	child!0
}
proctype AddListener48(Mutexdef e_listeners_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype invokeConfigListeners60(Mutexdef e_listeners_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype RemoveListener55(Mutexdef e_listeners_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

