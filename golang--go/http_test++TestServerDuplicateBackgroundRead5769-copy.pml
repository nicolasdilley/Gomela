// num_comm_params=2
// num_mand_comm_params=1
// num_opt_comm_params=1

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/http/serve_test.go#L5769
#define TestServerDuplicateBackgroundRead_goroutines  3
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
	chan child_TestServerDuplicateBackgroundRead57690 = [1] of {int};
	run TestServerDuplicateBackgroundRead5769(child_TestServerDuplicateBackgroundRead57690);
	run receiver(child_TestServerDuplicateBackgroundRead57690)
stop_process:skip
}

proctype TestServerDuplicateBackgroundRead5769(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close18370 = [1] of {int};
	chan child_AnonymousTestServerDuplicateBackgroundRead579257841 = [1] of {int};
	Wgdef wg;
	Mutexdef hts_mu;
	Wgdef hts_wg;
	Mutexdef hts_Config_mu;
	Mutexdef hts_TLS_mutex;
	int var_goroutines = TestServerDuplicateBackgroundRead_goroutines; // mand var_goroutines
	run mutexMonitor(hts_TLS_mutex);
	run mutexMonitor(hts_Config_mu);
	run wgMonitor(hts_wg);
	run mutexMonitor(hts_mu);
	run wgMonitor(wg);
		for(i : 0.. var_goroutines-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestServerDuplicateBackgroundRead57925784(hts_wg,wg,hts_TLS_mutex,hts_Config_mu,hts_mu,child_AnonymousTestServerDuplicateBackgroundRead579257841);
		run receiver(child_AnonymousTestServerDuplicateBackgroundRead579257841);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
		defer1: skip;
	run Close1837(hts_wg,hts_Config_mu,hts_mu,hts_TLS_mutex,child_Close18370);
	child_Close18370?0;
	stop_process: skip;
	child!0
}
proctype Close1837(Wgdef b_wg;Mutexdef b_Config_mu;Mutexdef b_mu;Mutexdef b_TLS_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTestServerDuplicateBackgroundRead57925784(Wgdef hts_wg;Wgdef wg;Mutexdef hts_TLS_mutex;Mutexdef hts_Config_mu;Mutexdef hts_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousAnonymousTestServerDuplicateBackgroundRead5792580257841 = [1] of {int};
	int var_requestsrequests = -2; // opt var_requestsrequests
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	wg.update!1;
	run AnonymousAnonymousTestServerDuplicateBackgroundRead579258025784(hts_wg,wg,hts_TLS_mutex,hts_Config_mu,hts_mu,child_AnonymousAnonymousTestServerDuplicateBackgroundRead5792580257841);
	run receiver(child_AnonymousAnonymousTestServerDuplicateBackgroundRead5792580257841);
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousAnonymousTestServerDuplicateBackgroundRead579258025784(Wgdef hts_wg;Wgdef wg;Mutexdef hts_TLS_mutex;Mutexdef hts_Config_mu;Mutexdef hts_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
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

