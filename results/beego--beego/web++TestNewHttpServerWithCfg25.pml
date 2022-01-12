// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/beego/beego/blob//server/web/server_test.go#L25
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewHttpServerWithCfg250 = [1] of {int};
	run TestNewHttpServerWithCfg25(child_TestNewHttpServerWithCfg250);
	run receiver(child_TestNewHttpServerWithCfg250)
stop_process:skip
}

proctype TestNewHttpServerWithCfg25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef svr_Server_mu;
	Mutexdef svr_Server_nextProtoOnce_m;
	Mutexdef svr_Server_ErrorLog_mu;
	Mutexdef svr_Server_TLSConfig_mutex;
	run mutexMonitor(svr_Server_TLSConfig_mutex);
	run mutexMonitor(svr_Server_ErrorLog_mu);
	run mutexMonitor(svr_Server_nextProtoOnce_m);
	run mutexMonitor(svr_Server_mu);
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

