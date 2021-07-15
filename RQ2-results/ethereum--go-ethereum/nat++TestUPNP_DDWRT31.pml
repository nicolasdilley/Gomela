
// https://github.com/ethereum/go-ethereum/blob/master/p2p/nat/natupnp_test.go#L31
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUPNP_DDWRT310 = [1] of {int};
	run TestUPNP_DDWRT31(child_TestUPNP_DDWRT310)
stop_process:skip
}

proctype TestUPNP_DDWRT31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_close2412 = [1] of {int};
	Mutexdef upnp_mu;
	chan child_serve2361 = [1] of {int};
	chan child_listen2240 = [1] of {int};
	Mutexdef dev_t_context_mu;
	Mutexdef dev_t_context_match_mu;
	run mutexMonitor(dev_t_context_match_mu);
	run mutexMonitor(dev_t_context_mu);
	run listen224(dev_t_context_match_mu,dev_t_context_mu,child_listen2240);
	child_listen2240?0;
	run serve236(dev_t_context_match_mu,dev_t_context_mu,child_serve2361);
	child_serve2361?0;
	run mutexMonitor(upnp_mu);
	stop_process: skip;
		run close241(dev_t_context_match_mu,dev_t_context_mu,child_close2412);
	child_close2412?0;
	child!0
}
proctype listen224(Mutexdef dev_t_context_match_mu;Mutexdef dev_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype serve236(Mutexdef dev_t_context_match_mu;Mutexdef dev_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype close241(Mutexdef dev_t_context_match_mu;Mutexdef dev_t_context_mu;chan child) {
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

