// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/galley/pkg/config/processing/runtime_test.go#L211
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
	chan child_TestRuntime_Event_Before_Start2110 = [1] of {int};
	run TestRuntime_Event_Before_Start211(child_TestRuntime_Event_Before_Start2110);
	run receiver(child_TestRuntime_Event_Before_Start2110)
stop_process:skip
}

proctype TestRuntime_Event_Before_Start211(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef f_rt_wg;
	Mutexdef f_rt_mu;
	Wgdef f_mockSrc_startWG;
	Mutexdef f_mockSrc_mu;
	Mutexdef f_src_mu;
	Mutexdef f_meshsrc_mu;
	run mutexMonitor(f_meshsrc_mu);
	run mutexMonitor(f_src_mu);
	run mutexMonitor(f_mockSrc_mu);
	run wgMonitor(f_mockSrc_startWG);
	run mutexMonitor(f_rt_mu);
	run wgMonitor(f_rt_wg);
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

