// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/jaegertracing/jaeger/blob/12bba8c9b91cf4a29d314934bc08f4a80e43c042/cmd/collector/app/server/http_test.go#L50
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCreateTLSHTTPServerError500 = [1] of {int};
	run TestCreateTLSHTTPServerError50(child_TestCreateTLSHTTPServerError500);
	run receiver(child_TestCreateTLSHTTPServerError500)
stop_process:skip
}

proctype TestCreateTLSHTTPServerError50(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __mu;
	Mutexdef __nextProtoOnce_m;
	Mutexdef __ErrorLog_mu;
	Mutexdef __TLSConfig_mutex;
	Mutexdef tlsCfg_certWatcher_mu;
	run mutexMonitor(tlsCfg_certWatcher_mu);
	run mutexMonitor(__TLSConfig_mutex);
	run mutexMonitor(__ErrorLog_mu);
	run mutexMonitor(__nextProtoOnce_m);
	run mutexMonitor(__mu);
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

