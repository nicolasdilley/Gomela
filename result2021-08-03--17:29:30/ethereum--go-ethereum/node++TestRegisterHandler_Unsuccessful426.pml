// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/node/node_test.go#L426
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
	chan child_TestRegisterHandler_Unsuccessful4260 = [1] of {int};
	run TestRegisterHandler_Unsuccessful426(child_TestRegisterHandler_Unsuccessful4260);
	run receiver(child_TestRegisterHandler_Unsuccessful4260)
stop_process:skip
}

proctype TestRegisterHandler_Unsuccessful426(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RegisterHandler4630 = [1] of {int};
	Mutexdef node_ipc_mu;
	Mutexdef node_ws_mu;
	Mutexdef node_http_mu;
	Mutexdef node_lock;
	Mutexdef node_startStopLock;
	Wgdef node_server_loopWG;
	Mutexdef node_server_lock;
	Mutexdef node_accman_lock;
	Mutexdef node_eventmux_mutex;
	run mutexMonitor(node_eventmux_mutex);
	run mutexMonitor(node_accman_lock);
	run mutexMonitor(node_server_lock);
	run wgMonitor(node_server_loopWG);
	run mutexMonitor(node_startStopLock);
	run mutexMonitor(node_lock);
	run mutexMonitor(node_http_mu);
	run mutexMonitor(node_ws_mu);
	run mutexMonitor(node_ipc_mu);
	run RegisterHandler463(node_server_loopWG,node_accman_lock,node_eventmux_mutex,node_http_mu,node_ipc_mu,node_lock,node_server_lock,node_startStopLock,node_ws_mu,child_RegisterHandler4630);
	child_RegisterHandler4630?0;
	stop_process: skip;
	child!0
}
proctype RegisterHandler463(Wgdef n_server_loopWG;Mutexdef n_accman_lock;Mutexdef n_eventmux_mutex;Mutexdef n_http_mu;Mutexdef n_ipc_mu;Mutexdef n_lock;Mutexdef n_server_lock;Mutexdef n_startStopLock;Mutexdef n_ws_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	n_lock.Lock!false;
		defer1: skip;
	n_lock.Unlock!false;
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

