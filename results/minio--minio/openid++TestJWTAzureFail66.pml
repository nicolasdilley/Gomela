
// https://github.com/minio/minio/blob/master/cmd/config/identity/openid/jwt_test.go#L66
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestJWTAzureFail660 = [1] of {int};
	run TestJWTAzureFail66(child_TestJWTAzureFail660)
stop_process:skip
}

proctype TestJWTAzureFail66(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewJWT3870 = [1] of {int};
	Mutexdef cfg_mutex;
	Mutexdef cfg_transport_nextProtoOnce_m;
	Mutexdef cfg_transport_TLSClientConfig_mutex;
	Mutexdef cfg_transport_connsPerHostMu;
	Mutexdef cfg_transport_altMu;
	Mutexdef cfg_transport_reqMu;
	Mutexdef cfg_transport_idleMu;
	run mutexMonitor(cfg_transport_idleMu);
	run mutexMonitor(cfg_transport_reqMu);
	run mutexMonitor(cfg_transport_altMu);
	run mutexMonitor(cfg_transport_connsPerHostMu);
	run mutexMonitor(cfg_transport_TLSClientConfig_mutex);
	run mutexMonitor(cfg_transport_nextProtoOnce_m);
	run mutexMonitor(cfg_mutex);
	run NewJWT387(cfg_transport_idleMu,cfg_transport_reqMu,cfg_transport_altMu,cfg_transport_connsPerHostMu,cfg_transport_TLSClientConfig_mutex,cfg_transport_nextProtoOnce_m,cfg_mutex,child_NewJWT3870);
	child_NewJWT3870?0;
	stop_process: skip;
	child!0
}
proctype NewJWT387(Mutexdef c_transport_idleMu;Mutexdef c_transport_reqMu;Mutexdef c_transport_altMu;Mutexdef c_transport_connsPerHostMu;Mutexdef c_transport_TLSClientConfig_mutex;Mutexdef c_transport_nextProtoOnce_m;Mutexdef c_mutex;chan child) {
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

