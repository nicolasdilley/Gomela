
// https://github.com/gorilla/websocket/blob/master/client_server_test.go#L527
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
	chan child_TestRespOnBadHandshake5270 = [1] of {int};
	run TestRespOnBadHandshake527(child_TestRespOnBadHandshake5270)
stop_process:skip
}

proctype TestRespOnBadHandshake527(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1050 = [1] of {int};
	chan child_Close3431 = [1] of {int};
	Mutexdef ws_writeErrMu;
	Mutexdef s_mu;
	Wgdef s_wg;
	Mutexdef s_Config_mu;
	Mutexdef s_Config_nextProtoOnce_m;
	Mutexdef s_Config_ErrorLog_mu;
	Mutexdef s_Config_TLSConfig_mutex;
	Mutexdef s_TLS_mutex;
	run mutexMonitor(s_TLS_mutex);
	run mutexMonitor(s_Config_TLSConfig_mutex);
	run mutexMonitor(s_Config_ErrorLog_mu);
	run mutexMonitor(s_Config_nextProtoOnce_m);
	run mutexMonitor(s_Config_mu);
	run wgMonitor(s_wg);
	run mutexMonitor(s_mu);
	run mutexMonitor(ws_writeErrMu);
	

	if
	:: true -> 
		run Close343(ws_writeErrMu,child_Close3431);
		child_Close3431?0
	:: true;
	fi;
	stop_process: skip;
		run Close105(s_wg,s_TLS_mutex,s_Config_TLSConfig_mutex,s_Config_ErrorLog_mu,s_Config_nextProtoOnce_m,s_Config_mu,s_mu,child_Close1050);
	child_Close1050?0;
	child!0
}
proctype Close105(Wgdef w_wg;Mutexdef w_TLS_mutex;Mutexdef w_Config_TLSConfig_mutex;Mutexdef w_Config_ErrorLog_mu;Mutexdef w_Config_nextProtoOnce_m;Mutexdef w_Config_mu;Mutexdef w_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Close343(Mutexdef c_writeErrMu;chan child) {
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

