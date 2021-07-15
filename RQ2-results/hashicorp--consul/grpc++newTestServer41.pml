
// https://github.com/hashicorp/consul/blob/master/agent/grpc/server_test.go#L41
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
	chan child_newTestServer410 = [1] of {int};
	run newTestServer41(child_newTestServer410)
stop_process:skip
}

proctype newTestServer41(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef g_errOnce_m;
	Wgdef g_wg;
	Wgdef rpc_handler_srv_serveWG;
	Mutexdef rpc_handler_srv_channelzRemoveOnce_m;
	Mutexdef rpc_handler_srv_done_o_m;
	Mutexdef rpc_handler_srv_quit_o_m;
	Mutexdef rpc_handler_srv_mu;
	Mutexdef rpc_t_context_mu;
	Mutexdef rpc_t_context_match_mu;
	Wgdef handler_srv_serveWG;
	Mutexdef handler_srv_channelzRemoveOnce_m;
	Mutexdef handler_srv_done_o_m;
	Mutexdef handler_srv_quit_o_m;
	Mutexdef handler_srv_mu;
	run mutexMonitor(handler_srv_mu);
	run mutexMonitor(handler_srv_quit_o_m);
	run mutexMonitor(handler_srv_done_o_m);
	run mutexMonitor(handler_srv_channelzRemoveOnce_m);
	run wgMonitor(handler_srv_serveWG);
	run mutexMonitor(rpc_t_context_match_mu);
	run mutexMonitor(rpc_t_context_mu);
	run mutexMonitor(rpc_handler_srv_mu);
	run mutexMonitor(rpc_handler_srv_quit_o_m);
	run mutexMonitor(rpc_handler_srv_done_o_m);
	run mutexMonitor(rpc_handler_srv_channelzRemoveOnce_m);
	run wgMonitor(rpc_handler_srv_serveWG);
	run wgMonitor(g_wg);
	run mutexMonitor(g_errOnce_m);
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

