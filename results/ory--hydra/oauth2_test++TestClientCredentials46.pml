// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ory/hydra/blob//oauth2/oauth2_client_credentials_test.go#L46
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
	chan child_TestClientCredentials460 = [1] of {int};
	run TestClientCredentials46(child_TestClientCredentials460);
	run receiver(child_TestClientCredentials460)
stop_process:skip
}

proctype TestClientCredentials46(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef admin_mu;
	Wgdef admin_wg;
	Mutexdef admin_Config_mu;
	Mutexdef admin_Config_nextProtoOnce_m;
	Mutexdef admin_Config_ErrorLog_mu;
	Mutexdef admin_Config_TLSConfig_mutex;
	Mutexdef admin_TLS_mutex;
	Mutexdef public_mu;
	Wgdef public_wg;
	Mutexdef public_Config_mu;
	Mutexdef public_Config_nextProtoOnce_m;
	Mutexdef public_Config_ErrorLog_mu;
	Mutexdef public_Config_TLSConfig_mutex;
	Mutexdef public_TLS_mutex;
	run mutexMonitor(public_TLS_mutex);
	run mutexMonitor(public_Config_TLSConfig_mutex);
	run mutexMonitor(public_Config_ErrorLog_mu);
	run mutexMonitor(public_Config_nextProtoOnce_m);
	run mutexMonitor(public_Config_mu);
	run wgMonitor(public_wg);
	run mutexMonitor(public_mu);
	run mutexMonitor(admin_TLS_mutex);
	run mutexMonitor(admin_Config_TLSConfig_mutex);
	run mutexMonitor(admin_Config_ErrorLog_mu);
	run mutexMonitor(admin_Config_nextProtoOnce_m);
	run mutexMonitor(admin_Config_mu);
	run wgMonitor(admin_wg);
	run mutexMonitor(admin_mu);
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

proctype receiver(chan c) {
c?0
}

