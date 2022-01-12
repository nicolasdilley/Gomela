// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/threading/routinegroup_test.go#L27
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
	chan child_TestRoutingGroupRunSafe270 = [1] of {int};
	run TestRoutingGroupRunSafe27(child_TestRoutingGroupRunSafe270);
	run receiver(child_TestRoutingGroupRunSafe270)
stop_process:skip
}

proctype TestRoutingGroupRunSafe27(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Wait402 = [1] of {int};
	chan child_RunSafe301 = [1] of {int};
	chan child_RunSafe300 = [1] of {int};
	Mutexdef once_m;
	Wgdef group_waitGroup;
	run wgMonitor(group_waitGroup);
	run mutexMonitor(once_m);
	

	if
	:: 0 != -2 && 3-1 != -3 -> 
				for(i : 0.. 3-1) {
			for11: skip;
			run RunSafe30(group_waitGroup,child_RunSafe301);
			child_RunSafe301?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run RunSafe30(group_waitGroup,child_RunSafe300);
			child_RunSafe300?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run Wait40(group_waitGroup,child_Wait402);
	child_Wait402?0;
	stop_process: skip;
	child!0
}
proctype RunSafe30(Wgdef g_waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	g_waitGroup.update!1;
	stop_process: skip;
	child!0
}
proctype Wait40(Wgdef g_waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	g_waitGroup.wait?0;
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

