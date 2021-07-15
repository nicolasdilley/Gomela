
// https://github.com/traefik/traefik/blob/master/pkg/server/service/service_test.go#L24
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestGetLoadBalancer240 = [1] of {int};
	run TestGetLoadBalancer24(child_TestGetLoadBalancer240)
stop_process:skip
}

proctype TestGetLoadBalancer24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef sm_routinePool_waitGroup;
	run wgMonitor(sm_routinePool_waitGroup);
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

