// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//net/http/response_test.go#L975
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNeedsSniff9750 = [1] of {int};
	run TestNeedsSniff975(child_TestNeedsSniff9750);
	run receiver(child_TestNeedsSniff9750)
stop_process:skip
}

proctype TestNeedsSniff975(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_needsSniff5531 = [1] of {int};
	chan child_needsSniff5530 = [1] of {int};
	Mutexdef r_writeContinueMu;
	Mutexdef r_conn_mu;
	Mutexdef r_conn_r_mu;
	Mutexdef r_conn_server_mu;
	Mutexdef r_conn_server_nextProtoOnce_m;
	Mutexdef r_conn_server_ErrorLog_mu;
	Mutexdef r_conn_server_TLSConfig_mutex;
	run mutexMonitor(r_conn_server_TLSConfig_mutex);
	run mutexMonitor(r_conn_server_ErrorLog_mu);
	run mutexMonitor(r_conn_server_nextProtoOnce_m);
	run mutexMonitor(r_conn_server_mu);
	run mutexMonitor(r_conn_r_mu);
	run mutexMonitor(r_conn_mu);
	run mutexMonitor(r_writeContinueMu);
	run needsSniff553(r_conn_mu,r_conn_r_mu,r_conn_server_ErrorLog_mu,r_conn_server_mu,r_conn_server_nextProtoOnce_m,r_conn_server_TLSConfig_mutex,r_writeContinueMu,child_needsSniff5530);
	child_needsSniff5530?0;
	run needsSniff553(r_conn_mu,r_conn_r_mu,r_conn_server_ErrorLog_mu,r_conn_server_mu,r_conn_server_nextProtoOnce_m,r_conn_server_TLSConfig_mutex,r_writeContinueMu,child_needsSniff5531);
	child_needsSniff5531?0;
	stop_process: skip;
	child!0
}
proctype needsSniff553(Mutexdef w_conn_mu;Mutexdef w_conn_r_mu;Mutexdef w_conn_server_ErrorLog_mu;Mutexdef w_conn_server_mu;Mutexdef w_conn_server_nextProtoOnce_m;Mutexdef w_conn_server_TLSConfig_mutex;Mutexdef w_writeContinueMu;chan child) {
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

