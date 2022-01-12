// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/caddyserver/caddy/blob//caddytest/caddytest.go#L317
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_AssertLoadError3170 = [1] of {int};
	run AssertLoadError317(child_AssertLoadError3170);
	run receiver(child_AssertLoadError3170)
stop_process:skip
}

proctype AssertLoadError317(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_initServer1100 = [1] of {int};
	Mutexdef tc_t_context_mu;
	Mutexdef tc_t_context_match_mu;
	run mutexMonitor(tc_t_context_match_mu);
	run mutexMonitor(tc_t_context_mu);
	run initServer110(tc_t_context_match_mu,tc_t_context_mu,child_initServer1100);
	child_initServer1100?0;
	stop_process: skip;
	child!0
}
proctype initServer110(Mutexdef tc_t_context_match_mu;Mutexdef tc_t_context_mu;chan child) {
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

