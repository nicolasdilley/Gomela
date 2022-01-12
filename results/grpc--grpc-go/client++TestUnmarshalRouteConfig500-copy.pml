// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob//xds/internal/client/rds_test.go#L500
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUnmarshalRouteConfig5000 = [1] of {int};
	run TestUnmarshalRouteConfig500(child_TestUnmarshalRouteConfig5000);
	run receiver(child_TestUnmarshalRouteConfig5000)
stop_process:skip
}

proctype TestUnmarshalRouteConfig500(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef v3RouteConfig_state_atomicMessageInfo_initMu;
	Mutexdef v2RouteConfig_state_atomicMessageInfo_initMu;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(v2RouteConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3RouteConfig_state_atomicMessageInfo_initMu);
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

