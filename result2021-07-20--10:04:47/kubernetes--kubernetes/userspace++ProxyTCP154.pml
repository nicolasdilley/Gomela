// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/proxy/userspace/proxysocket.go#L154
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_ProxyTCP1540 = [1] of {int};
	run ProxyTCP154(child_ProxyTCP1540);
	run receiver(child_ProxyTCP1540)
stop_process:skip
}

proctype ProxyTCP154(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_copyBytes1641 = [1] of {int};
	chan child_copyBytes1640 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run copyBytes164(wg,child_copyBytes1640);
	run receiver(child_copyBytes1640);
	run copyBytes164(wg,child_copyBytes1641);
	run receiver(child_copyBytes1641);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype copyBytes164(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
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

