// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/traefik/traefik/blob/080cf98e512f6fcb93838de76a6aa34ff147dee4/pkg/server/service/service_test.go#L24
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestGetLoadBalancer240 = [1] of {int};
	run TestGetLoadBalancer24(child_TestGetLoadBalancer240);
	run receiver(child_TestGetLoadBalancer240)
stop_process:skip
}

proctype TestGetLoadBalancer24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef sm_routinePool_waitGroup;
	int testCases = -2; // opt testCases
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

proctype receiver(chan c) {
c?0
}

