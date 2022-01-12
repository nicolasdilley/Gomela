// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gin-gonic/gin/blob//context_test.go#L359
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextHandlerNames3590 = [1] of {int};
	run TestContextHandlerNames359(child_TestContextHandlerNames3590);
	run receiver(child_TestContextHandlerNames3590)
stop_process:skip
}

proctype TestContextHandlerNames359(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_HandlerNames1330 = [1] of {int};
	Mutexdef c_mu;
	int var_names = -2; // opt var_names
	run mutexMonitor(c_mu);
	run HandlerNames133(c_mu,child_HandlerNames1330);
	child_HandlerNames1330?0;
	stop_process: skip;
	child!0
}
proctype HandlerNames133(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_c_handlers = -2; // opt var_c_handlers
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

