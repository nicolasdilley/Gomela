
// https://github.com/jaegertracing/jaeger/blob/master/cmd/query/app/additional_headers_test.go#L25
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
	chan child_TestAdditionalHeadersHandler250 = [1] of {int};
	run TestAdditionalHeadersHandler25(child_TestAdditionalHeadersHandler250)
stop_process:skip
}

proctype TestAdditionalHeadersHandler25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close2750 = [1] of {int};
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
	stop_process: skip;
		run Close275(server_wg,server_TLS_mutex,server_Config_TLSConfig_mutex,server_Config_ErrorLog_mu,server_Config_nextProtoOnce_m,server_Config_mu,server_mu,child_Close2750);
	child_Close2750?0;
	child!0
}
proctype Close275(Wgdef s_wg;Mutexdef s_TLS_mutex;Mutexdef s_Config_TLSConfig_mutex;Mutexdef s_Config_ErrorLog_mu;Mutexdef s_Config_nextProtoOnce_m;Mutexdef s_Config_mu;Mutexdef s_mu;chan child) {
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

