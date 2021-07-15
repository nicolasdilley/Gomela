
// https://github.com/helm/helm/blob/master/pkg/repo/repotest/server_test.go#L101
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
	chan child_TestNewTempServer1010 = [1] of {int};
	run TestNewTempServer101(child_TestNewTempServer1010)
stop_process:skip
}

proctype TestNewTempServer101(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop3740 = [1] of {int};
	chan child_URL3821 = [1] of {int};
	Mutexdef srv_srv_mu;
	Wgdef srv_srv_wg;
	Mutexdef srv_srv_Config_mu;
	Mutexdef srv_srv_Config_nextProtoOnce_m;
	Mutexdef srv_srv_Config_ErrorLog_mu;
	Mutexdef srv_srv_Config_TLSConfig_mutex;
	Mutexdef srv_srv_TLS_mutex;
	run mutexMonitor(srv_srv_TLS_mutex);
	run mutexMonitor(srv_srv_Config_TLSConfig_mutex);
	run mutexMonitor(srv_srv_Config_ErrorLog_mu);
	run mutexMonitor(srv_srv_Config_nextProtoOnce_m);
	run mutexMonitor(srv_srv_Config_mu);
	run wgMonitor(srv_srv_wg);
	run mutexMonitor(srv_srv_mu);
	run URL382(srv_srv_wg,srv_srv_TLS_mutex,srv_srv_Config_TLSConfig_mutex,srv_srv_Config_ErrorLog_mu,srv_srv_Config_nextProtoOnce_m,srv_srv_Config_mu,srv_srv_mu,child_URL3821);
	child_URL3821?0;
	stop_process: skip;
		run Stop374(srv_srv_wg,srv_srv_TLS_mutex,srv_srv_Config_TLSConfig_mutex,srv_srv_Config_ErrorLog_mu,srv_srv_Config_nextProtoOnce_m,srv_srv_Config_mu,srv_srv_mu,child_Stop3740);
	child_Stop3740?0;
	child!0
}
proctype Stop374(Wgdef s_srv_wg;Mutexdef s_srv_TLS_mutex;Mutexdef s_srv_Config_TLSConfig_mutex;Mutexdef s_srv_Config_ErrorLog_mu;Mutexdef s_srv_Config_nextProtoOnce_m;Mutexdef s_srv_Config_mu;Mutexdef s_srv_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype URL382(Wgdef s_srv_wg;Mutexdef s_srv_TLS_mutex;Mutexdef s_srv_Config_TLSConfig_mutex;Mutexdef s_srv_Config_ErrorLog_mu;Mutexdef s_srv_Config_nextProtoOnce_m;Mutexdef s_srv_Config_mu;Mutexdef s_srv_mu;chan child) {
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

