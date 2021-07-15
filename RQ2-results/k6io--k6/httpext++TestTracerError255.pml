
// https://github.com/k6io/k6/blob/master/lib/netext/httpext/tracer_test.go#L255
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
	chan child_TestTracerError2550 = [1] of {int};
	run TestTracerError255(child_TestTracerError2550)
stop_process:skip
}

proctype TestTracerError255(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1310 = [1] of {int};
	Mutexdef srv_mu;
	Wgdef srv_wg;
	Mutexdef srv_Config_mu;
	Mutexdef srv_Config_nextProtoOnce_m;
	Mutexdef srv_Config_ErrorLog_mu;
	Mutexdef srv_Config_TLSConfig_mutex;
	Mutexdef srv_TLS_mutex;
	run mutexMonitor(srv_TLS_mutex);
	run mutexMonitor(srv_Config_TLSConfig_mutex);
	run mutexMonitor(srv_Config_ErrorLog_mu);
	run mutexMonitor(srv_Config_nextProtoOnce_m);
	run mutexMonitor(srv_Config_mu);
	run wgMonitor(srv_wg);
	run mutexMonitor(srv_mu);
	stop_process: skip;
		run Close131(srv_wg,srv_TLS_mutex,srv_Config_TLSConfig_mutex,srv_Config_ErrorLog_mu,srv_Config_nextProtoOnce_m,srv_Config_mu,srv_mu,child_Close1310);
	child_Close1310?0;
	child!0
}
proctype Close131(Wgdef r_wg;Mutexdef r_TLS_mutex;Mutexdef r_Config_TLSConfig_mutex;Mutexdef r_Config_ErrorLog_mu;Mutexdef r_Config_nextProtoOnce_m;Mutexdef r_Config_mu;Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	:: true;
	fi;
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

