
// https://github.com/jaegertracing/jaeger/blob/master/cmd/query/app/grpc_handler_test.go#L163
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
	chan child_initializeTestServerGRPCWithOptions1630 = [1] of {int};
	run initializeTestServerGRPCWithOptions163(child_initializeTestServerGRPCWithOptions1630)
stop_process:skip
}

proctype initializeTestServerGRPCWithOptions163(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef server_serveWG;
	Mutexdef server_channelzRemoveOnce_m;
	Mutexdef server_done_o_m;
	Mutexdef server_quit_o_m;
	Mutexdef server_mu;
	run mutexMonitor(server_mu);
	run mutexMonitor(server_quit_o_m);
	run mutexMonitor(server_done_o_m);
	run mutexMonitor(server_channelzRemoveOnce_m);
	run wgMonitor(server_serveWG);
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

