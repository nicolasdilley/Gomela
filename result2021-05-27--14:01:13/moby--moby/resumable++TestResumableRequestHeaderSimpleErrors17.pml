// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/moby/moby/blob/5a82cee6d499e51bc903a743e4f0f205adb161a9/registry/resumable/resumablerequestreader_test.go#L17
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
	chan child_TestResumableRequestHeaderSimpleErrors170 = [1] of {int};
	run TestResumableRequestHeaderSimpleErrors17(child_TestResumableRequestHeaderSimpleErrors170);
	run receiver(child_TestResumableRequestHeaderSimpleErrors170)
stop_process:skip
}

proctype TestResumableRequestHeaderSimpleErrors17(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close840 = [1] of {int};
	Mutexdef ts_mu;
	Wgdef ts_wg;
	Mutexdef ts_Config_mu;
	Mutexdef ts_TLS_mutex;
	run mutexMonitor(ts_TLS_mutex);
	run mutexMonitor(ts_Config_mu);
	run wgMonitor(ts_wg);
	run mutexMonitor(ts_mu);
		defer1: skip;
	run Close84(ts_wg,ts_Config_mu,ts_mu,ts_TLS_mutex,child_Close840);
	child_Close840?0;
	stop_process: skip;
	child!0
}
proctype Close84(Wgdef r_wg;Mutexdef r_Config_mu;Mutexdef r_mu;Mutexdef r_TLS_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_cleanUpResponse910 = [1] of {int};
	run cleanUpResponse91(r_wg,r_Config_mu,r_mu,r_TLS_mutex,child_cleanUpResponse910);
	child_cleanUpResponse910?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype cleanUpResponse91(Wgdef r_wg;Mutexdef r_Config_mu;Mutexdef r_mu;Mutexdef r_TLS_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

