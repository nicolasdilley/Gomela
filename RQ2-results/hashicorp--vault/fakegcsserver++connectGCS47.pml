
// https://github.com/hashicorp/vault/blob/master/helper/testhelpers/fakegcsserver/fake-gcs-server.go#L47
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_connectGCS470 = [1] of {int};
	run connectGCS47(child_connectGCS470)
stop_process:skip
}

proctype connectGCS47(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef transCfg_nextProtoOnce_m;
	Mutexdef transCfg_TLSClientConfig_mutex;
	Mutexdef transCfg_connsPerHostMu;
	Mutexdef transCfg_altMu;
	Mutexdef transCfg_reqMu;
	Mutexdef transCfg_idleMu;
	run mutexMonitor(transCfg_idleMu);
	run mutexMonitor(transCfg_reqMu);
	run mutexMonitor(transCfg_altMu);
	run mutexMonitor(transCfg_connsPerHostMu);
	run mutexMonitor(transCfg_TLSClientConfig_mutex);
	run mutexMonitor(transCfg_nextProtoOnce_m);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

