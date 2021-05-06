
// https://github.com/kubernetes/kubernetes/blob/master/pkg/proxy/userspace/proxysocket.go#L154
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_ProxyTCP1540 = [1] of {int};
	run ProxyTCP154(child_ProxyTCP1540)
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
	run copyBytes164(wg,child_copyBytes1641);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype copyBytes164(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		wg.update!-1;
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

