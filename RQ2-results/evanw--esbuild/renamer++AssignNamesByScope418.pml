#define nestedScopes418  3
#define not_found_424  0

// https://github.com/evanw/esbuild/blob/master/internal/renamer/renamer.go#L418
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_AssignNamesByScope4180 = [1] of {int};
	run AssignNamesByScope418(nestedScopes418,child_AssignNamesByScope4180)
stop_process:skip
}

proctype AssignNamesByScope418(int nestedScopes;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousAssignNamesByScope4244240 = [1] of {int};
	Wgdef waitGroup;
	run wgMonitor(waitGroup);
	waitGroup.update!nestedScopes;
		for(i : 0.. nestedScopes-1) {
		for10: skip;
		run AnonymousAssignNamesByScope424424(waitGroup,not_found_424,child_AnonymousAssignNamesByScope4244240);
		for10_end: skip
	};
	for10_exit: skip;
	waitGroup.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousAssignNamesByScope424424(Wgdef waitGroup;int scopes;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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


