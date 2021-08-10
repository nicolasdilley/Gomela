// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/dapr/dapr/blob/ab83d3535478699a2f2707d9ed9008f78c155d6d/pkg/diagnostics/http_tracing_test.go#L81
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUserDefinedHTTPHeaders810 = [1] of {int};
	run TestUserDefinedHTTPHeaders81(child_TestUserDefinedHTTPHeaders810);
	run receiver(child_TestUserDefinedHTTPHeaders810)
stop_process:skip
}

proctype TestUserDefinedHTTPHeaders81(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_userDefinedHTTPHeaders740 = [1] of {int};
	Mutexdef reqCtx_s_mu;
	run mutexMonitor(reqCtx_s_mu);
	run userDefinedHTTPHeaders74(reqCtx_s_mu,child_userDefinedHTTPHeaders740);
	child_userDefinedHTTPHeaders740?0;
	stop_process: skip;
	child!0
}
proctype userDefinedHTTPHeaders74(Mutexdef reqCtx_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

