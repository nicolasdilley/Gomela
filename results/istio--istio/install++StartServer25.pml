
// https://github.com/istio/istio/blob/master/cni/pkg/install-cni/pkg/install/server.go#L25
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_StartServer250 = [1] of {int};
	run StartServer25(child_StartServer250)
stop_process:skip
}

proctype StartServer25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousStartServer29261 = [1] of {int};
	chan child_initRouter460 = [1] of {int};
	Mutexdef router_mu;
	run mutexMonitor(router_mu);
	run initRouter46(router_mu,child_initRouter460);
	child_initRouter460?0;
	run AnonymousStartServer2926(router_mu,child_AnonymousStartServer29261);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype initRouter46(Mutexdef router_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousStartServer2926(Mutexdef router_mu;chan child) {
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

