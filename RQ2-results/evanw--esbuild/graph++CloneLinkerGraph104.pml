#define reachableFiles104  3

// https://github.com/evanw/esbuild/blob/master/internal/graph/graph.go#L104
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
	chan child_CloneLinkerGraph1040 = [1] of {int};
	run CloneLinkerGraph104(reachableFiles104,child_CloneLinkerGraph1040)
stop_process:skip
}

proctype CloneLinkerGraph104(int reachableFiles;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousCloneLinkerGraph1271270 = [1] of {int};
	Wgdef waitGroup;
	Mutexdef dynamicImportEntryPointsMutex;
	run mutexMonitor(dynamicImportEntryPointsMutex);
	run wgMonitor(waitGroup);
	waitGroup.update!reachableFiles;
		for(i : 0.. reachableFiles-1) {
		for20: skip;
		run AnonymousCloneLinkerGraph127127(waitGroup,dynamicImportEntryPointsMutex,child_AnonymousCloneLinkerGraph1271270);
		for20_end: skip
	};
	for20_exit: skip;
	waitGroup.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousCloneLinkerGraph127127(Wgdef waitGroup;Mutexdef dynamicImportEntryPointsMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	:: true;
	fi;
	waitGroup.update!-1;
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

