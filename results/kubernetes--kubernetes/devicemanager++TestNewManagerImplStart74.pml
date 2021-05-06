
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/cm/devicemanager/manager_test.go#L74
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
	chan child_TestNewManagerImplStart740 = [1] of {int};
	run TestNewManagerImplStart74(child_TestNewManagerImplStart740)
stop_process:skip
}

proctype TestNewManagerImplStart74(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef p_server_serveWG;
	Mutexdef p_server_channelzRemoveOnce_m;
	Mutexdef p_server_done_o_m;
	Mutexdef p_server_quit_o_m;
	Mutexdef p_server_mu;
	Wgdef p_wg;
	run wgMonitor(p_wg);
	run mutexMonitor(p_server_mu);
	run mutexMonitor(p_server_quit_o_m);
	run mutexMonitor(p_server_done_o_m);
	run mutexMonitor(p_server_channelzRemoveOnce_m);
	run wgMonitor(p_server_serveWG);
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

