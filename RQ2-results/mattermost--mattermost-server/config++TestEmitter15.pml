
// https://github.com/mattermost/mattermost-server/blob/master/config/emitter_test.go#L15
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEmitter150 = [1] of {int};
	run TestEmitter15(child_TestEmitter150)
stop_process:skip
}

proctype TestEmitter15(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_invokeConfigListeners336 = [1] of {int};
	chan child_RemoveListener285 = [1] of {int};
	chan child_invokeConfigListeners334 = [1] of {int};
	chan child_RemoveListener283 = [1] of {int};
	chan child_invokeConfigListeners332 = [1] of {int};
	chan child_AddListener191 = [1] of {int};
	chan child_AddListener190 = [1] of {int};
	Mutexdef e_listeners_mu;
	run mutexMonitor(e_listeners_mu);
	run AddListener19(e_listeners_mu,child_AddListener190);
	child_AddListener190?0;
	run AddListener19(e_listeners_mu,child_AddListener191);
	child_AddListener191?0;
	run invokeConfigListeners33(e_listeners_mu,child_invokeConfigListeners332);
	child_invokeConfigListeners332?0;
	run RemoveListener28(e_listeners_mu,child_RemoveListener283);
	child_RemoveListener283?0;
	run invokeConfigListeners33(e_listeners_mu,child_invokeConfigListeners334);
	child_invokeConfigListeners334?0;
	run RemoveListener28(e_listeners_mu,child_RemoveListener285);
	child_RemoveListener285?0;
	run invokeConfigListeners33(e_listeners_mu,child_invokeConfigListeners336);
	child_invokeConfigListeners336?0;
	stop_process: skip;
	child!0
}
proctype AddListener19(Mutexdef e_listeners_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype invokeConfigListeners33(Mutexdef e_listeners_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype RemoveListener28(Mutexdef e_listeners_mu;chan child) {
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

