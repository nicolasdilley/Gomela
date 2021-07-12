// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/http/httputil/reverseproxy_test.go#L154
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
	chan child_TestReverseProxyStripHeadersPresentInConnection1540 = [1] of {int};
	run TestReverseProxyStripHeadersPresentInConnection154(child_TestReverseProxyStripHeadersPresentInConnection1540);
	run receiver(child_TestReverseProxyStripHeadersPresentInConnection1540)
stop_process:skip
}

proctype TestReverseProxyStripHeadersPresentInConnection154(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close460 = [1] of {int};
	chan child_Close461 = [1] of {int};
	Mutexdef frontend_mu;
	Wgdef frontend_wg;
	Mutexdef frontend_Config_mu;
	Mutexdef frontend_TLS_mutex;
	Mutexdef proxyHandler_ErrorLog_mu;
	Mutexdef backend_mu;
	Wgdef backend_wg;
	Mutexdef backend_Config_mu;
	Mutexdef backend_TLS_mutex;
	int var_strings_Split_f_","_strings_Split_f_","_ = -2; // opt var_strings_Split_f_","_strings_Split_f_","_
	int var_cc = -2; // opt var_cc
	run mutexMonitor(backend_TLS_mutex);
	run mutexMonitor(backend_Config_mu);
	run wgMonitor(backend_wg);
	run mutexMonitor(backend_mu);
	run mutexMonitor(proxyHandler_ErrorLog_mu);
	run mutexMonitor(frontend_TLS_mutex);
	run mutexMonitor(frontend_Config_mu);
	run wgMonitor(frontend_wg);
	run mutexMonitor(frontend_mu);
		defer2: skip;
	run Close46(frontend_wg,frontend_Config_mu,frontend_mu,frontend_TLS_mutex,child_Close461);
	child_Close461?0;
		defer1: skip;
	run Close46(backend_wg,backend_Config_mu,backend_mu,backend_TLS_mutex,child_Close460);
	child_Close460?0;
	stop_process: skip;
	child!0
}
proctype Close46(Wgdef c_wg;Mutexdef c_Config_mu;Mutexdef c_mu;Mutexdef c_TLS_mutex;chan child) {
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

proctype receiver(chan c) {
c?0
}

