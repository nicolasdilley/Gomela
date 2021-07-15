
// https://github.com/jaegertracing/jaeger/blob/master/cmd/agent/app/httpserver/srv_test.go#L24
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHTTPServer240 = [1] of {int};
	run TestHTTPServer24(child_TestHTTPServer240)
stop_process:skip
}

proctype TestHTTPServer24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef s_mu;
	Mutexdef s_nextProtoOnce_m;
	Mutexdef s_ErrorLog_mu;
	Mutexdef s_TLSConfig_mutex;
	run mutexMonitor(s_TLSConfig_mutex);
	run mutexMonitor(s_ErrorLog_mu);
	run mutexMonitor(s_nextProtoOnce_m);
	run mutexMonitor(s_mu);
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

