// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/graphql/graphql_test.go#L42
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuildSchema420 = [1] of {int};
	run TestBuildSchema42(child_TestBuildSchema420);
	run receiver(child_TestBuildSchema420)
stop_process:skip
}

proctype TestBuildSchema42(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newHandler690 = [1] of {int};
	Mutexdef stack_ipc_mu;
	Mutexdef stack_ws_mu;
	Mutexdef stack_http_mu;
	Mutexdef stack_lock;
	Mutexdef stack_startStopLock;
	Wgdef stack_server_loopWG;
	Mutexdef stack_server_lock;
	Mutexdef stack_accman_lock;
	Mutexdef stack_eventmux_mutex;
	run mutexMonitor(stack_eventmux_mutex);
	run mutexMonitor(stack_accman_lock);
	run mutexMonitor(stack_server_lock);
	run wgMonitor(stack_server_loopWG);
	run mutexMonitor(stack_startStopLock);
	run mutexMonitor(stack_lock);
	run mutexMonitor(stack_http_mu);
	run mutexMonitor(stack_ws_mu);
	run mutexMonitor(stack_ipc_mu);
	run newHandler69(stack_server_loopWG,stack_accman_lock,stack_eventmux_mutex,stack_http_mu,stack_ipc_mu,stack_lock,stack_server_lock,stack_startStopLock,stack_ws_mu,child_newHandler690);
	child_newHandler690?0;
	stop_process: skip;
	child!0
}
proctype newHandler69(Wgdef stack_server_loopWG;Mutexdef stack_accman_lock;Mutexdef stack_eventmux_mutex;Mutexdef stack_http_mu;Mutexdef stack_ipc_mu;Mutexdef stack_lock;Mutexdef stack_server_lock;Mutexdef stack_startStopLock;Mutexdef stack_ws_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

