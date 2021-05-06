
// https://github.com/jaegertracing/jaeger/blob/master/cmd/collector/app/server/zipkin_test.go#L42
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
	chan child_TestSpanCollectorZipkin420 = [1] of {int};
	run TestSpanCollectorZipkin42(child_TestSpanCollectorZipkin420)
stop_process:skip
}

proctype TestSpanCollectorZipkin42(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close340 = [1] of {int};
	chan child_serveZipkin651 = [1] of {int};
	Mutexdef server_mu;
	Wgdef server_wg;
	Mutexdef server_Config_mu;
	Mutexdef server_Config_nextProtoOnce_m;
	Mutexdef server_Config_ErrorLog_mu;
	Mutexdef server_Config_TLSConfig_mutex;
	Mutexdef server_TLS_mutex;
	run mutexMonitor(server_TLS_mutex);
	run mutexMonitor(server_Config_TLSConfig_mutex);
	run mutexMonitor(server_Config_ErrorLog_mu);
	run mutexMonitor(server_Config_nextProtoOnce_m);
	run mutexMonitor(server_Config_mu);
	run wgMonitor(server_wg);
	run mutexMonitor(server_mu);
	run serveZipkin65(server_Config_TLSConfig_mutex,server_Config_ErrorLog_mu,server_Config_nextProtoOnce_m,server_Config_mu,child_serveZipkin651);
	child_serveZipkin651?0;
	stop_process: skip;
		run Close34(server_wg,server_TLS_mutex,server_Config_TLSConfig_mutex,server_Config_ErrorLog_mu,server_Config_nextProtoOnce_m,server_Config_mu,server_mu,child_Close340);
	child_Close340?0;
	child!0
}
proctype Close34(Wgdef p_wg;Mutexdef p_TLS_mutex;Mutexdef p_Config_TLSConfig_mutex;Mutexdef p_Config_ErrorLog_mu;Mutexdef p_Config_nextProtoOnce_m;Mutexdef p_Config_mu;Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype serveZipkin65(Mutexdef server_TLSConfig_mutex;Mutexdef server_ErrorLog_mu;Mutexdef server_nextProtoOnce_m;Mutexdef server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousserveZipkin81811 = [1] of {int};
	run AnonymousserveZipkin8181(server_TLSConfig_mutex,server_ErrorLog_mu,server_nextProtoOnce_m,server_mu,child_AnonymousserveZipkin81811);
	stop_process: skip;
	child!0
}
proctype AnonymousserveZipkin8181(Mutexdef server_TLSConfig_mutex;Mutexdef server_ErrorLog_mu;Mutexdef server_nextProtoOnce_m;Mutexdef server_mu;chan child) {
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

