
// https://github.com/kataras/iris/blob/master/core/host/proxy.go#L162
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewRedirection1620 = [1] of {int};
	run NewRedirection162(child_NewRedirection1620)
stop_process:skip
}

proctype NewRedirection162(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_New850 = [1] of {int};
	Mutexdef redirectSrv_mu;
	Mutexdef redirectSrv_nextProtoOnce_m;
	Mutexdef redirectSrv_ErrorLog_mu;
	Mutexdef redirectSrv_TLSConfig_mutex;
	run mutexMonitor(redirectSrv_TLSConfig_mutex);
	run mutexMonitor(redirectSrv_ErrorLog_mu);
	run mutexMonitor(redirectSrv_nextProtoOnce_m);
	run mutexMonitor(redirectSrv_mu);
	run New85(redirectSrv_TLSConfig_mutex,redirectSrv_ErrorLog_mu,redirectSrv_nextProtoOnce_m,redirectSrv_mu,child_New850);
	child_New850?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype New85(Mutexdef srv_TLSConfig_mutex;Mutexdef srv_ErrorLog_mu;Mutexdef srv_nextProtoOnce_m;Mutexdef srv_mu;chan child) {
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

