// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grafana/loki/blob/aa544a9dffdb8e78f7d7ed8edafce466d333b0a8/clients/pkg/promtail/targets/gcplog/target_test.go#L97
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
	chan child_TestGcplogTarget_Ready970 = [1] of {int};
	run TestGcplogTarget_Ready97(child_TestGcplogTarget_Ready970);
	run receiver(child_TestGcplogTarget_Ready970)
stop_process:skip
}

proctype TestGcplogTarget_Ready97(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Ready1400 = [1] of {int};
	Wgdef __wg;
	Mutexdef __mtx;
	Mutexdef __once_m;
	Wgdef tt_wg;
	run wgMonitor(tt_wg);
	run mutexMonitor(__once_m);
	run mutexMonitor(__mtx);
	run wgMonitor(__wg);
	run Ready140(tt_wg,child_Ready1400);
	child_Ready1400?0;
	stop_process: skip;
	child!0
}
proctype Ready140(Wgdef t_wg;chan child) {
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

