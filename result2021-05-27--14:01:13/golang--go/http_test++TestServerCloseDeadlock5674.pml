// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/http/serve_test.go#L5674
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestServerCloseDeadlock56740 = [1] of {int};
	run TestServerCloseDeadlock5674(child_TestServerCloseDeadlock56740);
	run receiver(child_TestServerCloseDeadlock56740)
stop_process:skip
}

proctype TestServerCloseDeadlock5674(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close18371 = [1] of {int};
	chan child_Close18370 = [1] of {int};
	Mutexdef s_mu;
	Mutexdef s_nextProtoOnce_m;
	Mutexdef s_ErrorLog_mu;
	Mutexdef s_TLSConfig_mutex;
	run mutexMonitor(s_TLSConfig_mutex);
	run mutexMonitor(s_ErrorLog_mu);
	run mutexMonitor(s_nextProtoOnce_m);
	run mutexMonitor(s_mu);
	run Close1837(s_ErrorLog_mu,s_mu,s_nextProtoOnce_m,s_TLSConfig_mutex,child_Close18370);
	child_Close18370?0;
	run Close1837(s_ErrorLog_mu,s_mu,s_nextProtoOnce_m,s_TLSConfig_mutex,child_Close18371);
	child_Close18371?0;
	stop_process: skip;
	child!0
}
proctype Close1837(Mutexdef b_ErrorLog_mu;Mutexdef b_mu;Mutexdef b_nextProtoOnce_m;Mutexdef b_TLSConfig_mutex;chan child) {
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

