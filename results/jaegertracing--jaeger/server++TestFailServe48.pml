
// https://github.com/jaegertracing/jaeger/blob/master/cmd/collector/app/server/grpc_test.go#L48
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
	chan child_TestFailServe480 = [1] of {int};
	run TestFailServe48(child_TestFailServe480)
stop_process:skip
}

proctype TestFailServe48(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_serveGRPC721 = [1] of {int};
	Wgdef wg;
	Mutexdef logs_mu;
	chan child_Close340 = [1] of {int};
	Mutexdef lis_mu;
	run mutexMonitor(lis_mu);
	run Close34(lis_mu,child_Close340);
	child_Close340?0;
	run mutexMonitor(logs_mu);
	run wgMonitor(wg);
	wg.update!1;
	run serveGRPC72(lis_mu,child_serveGRPC721);
	child_serveGRPC721?0;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype Close34(Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype serveGRPC72(Mutexdef listener_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousserveGRPC7701 = [1] of {int};
	run AnonymousserveGRPC770(listener_mu,child_AnonymousserveGRPC7701);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousserveGRPC770(Mutexdef listener_mu;chan child) {
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

