
// https://github.com/traefik/traefik/blob/master/pkg/server/service/loadbalancer/mirror/mirror_test.go#L76
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
	chan child_TestInvalidPercent760 = [1] of {int};
	run TestInvalidPercent76(child_TestInvalidPercent760)
stop_process:skip
}

proctype TestInvalidPercent76(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AddMirror1293 = [1] of {int};
	chan child_AddMirror1292 = [1] of {int};
	chan child_AddMirror1291 = [1] of {int};
	chan child_AddMirror1290 = [1] of {int};
	Mutexdef mirror_lock;
	Wgdef mirror_routinePool_waitGroup;
	run wgMonitor(mirror_routinePool_waitGroup);
	run mutexMonitor(mirror_lock);
	run AddMirror129(mirror_routinePool_waitGroup,mirror_lock,child_AddMirror1290);
	child_AddMirror1290?0;
	run AddMirror129(mirror_routinePool_waitGroup,mirror_lock,child_AddMirror1291);
	child_AddMirror1291?0;
	run AddMirror129(mirror_routinePool_waitGroup,mirror_lock,child_AddMirror1292);
	child_AddMirror1292?0;
	run AddMirror129(mirror_routinePool_waitGroup,mirror_lock,child_AddMirror1293);
	child_AddMirror1293?0;
	stop_process: skip;
	child!0
}
proctype AddMirror129(Wgdef m_routinePool_waitGroup;Mutexdef m_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

