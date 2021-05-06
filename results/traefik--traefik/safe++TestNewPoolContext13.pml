
// https://github.com/traefik/traefik/blob/master/pkg/safe/routine_test.go#L13
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestNewPoolContext130 = [1] of {int};
	run TestNewPoolContext13(child_TestNewPoolContext130)
stop_process:skip
}

proctype TestNewPoolContext13(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop411 = [1] of {int};
	chan child_GoCtx320 = [1] of {int};
	Wgdef p_waitGroup;
	run wgMonitor(p_waitGroup);
	run GoCtx32(p_waitGroup,child_GoCtx320);
	child_GoCtx320?0;
	run Stop41(p_waitGroup,child_Stop411);
	child_Stop411?0;
	stop_process: skip;
	child!0
}
proctype GoCtx32(Wgdef p_waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_waitGroup.update!1;
	stop_process: skip;
	child!0
}
proctype Stop41(Wgdef p_waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_waitGroup.wait?0;
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

