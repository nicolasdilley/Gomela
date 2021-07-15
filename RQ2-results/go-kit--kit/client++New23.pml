
// https://github.com/go-kit/kit/blob/master/examples/profilesvc/client/client.go#L23
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_New230 = [1] of {int};
	run New23(child_New230)
stop_process:skip
}

proctype New23(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewClient250 = [1] of {int};
	Mutexdef instancer_cache_mtx;
	Mutexdef apiclient_config_Transport_nextProtoOnce_m;
	Mutexdef apiclient_config_Transport_TLSClientConfig_mutex;
	Mutexdef apiclient_config_Transport_connsPerHostMu;
	Mutexdef apiclient_config_Transport_altMu;
	Mutexdef apiclient_config_Transport_reqMu;
	Mutexdef apiclient_config_Transport_idleMu;
	run mutexMonitor(apiclient_config_Transport_idleMu);
	run mutexMonitor(apiclient_config_Transport_reqMu);
	run mutexMonitor(apiclient_config_Transport_altMu);
	run mutexMonitor(apiclient_config_Transport_connsPerHostMu);
	run mutexMonitor(apiclient_config_Transport_TLSClientConfig_mutex);
	run mutexMonitor(apiclient_config_Transport_nextProtoOnce_m);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(instancer_cache_mtx);
	run NewClient25(apiclient_config_Transport_idleMu,apiclient_config_Transport_reqMu,apiclient_config_Transport_altMu,apiclient_config_Transport_connsPerHostMu,apiclient_config_Transport_TLSClientConfig_mutex,apiclient_config_Transport_nextProtoOnce_m,child_NewClient250);
	child_NewClient250?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewClient25(Mutexdef c_config_Transport_idleMu;Mutexdef c_config_Transport_reqMu;Mutexdef c_config_Transport_altMu;Mutexdef c_config_Transport_connsPerHostMu;Mutexdef c_config_Transport_TLSClientConfig_mutex;Mutexdef c_config_Transport_nextProtoOnce_m;chan child) {
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

