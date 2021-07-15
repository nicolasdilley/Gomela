#define vSphereInstances62  -2
#define GenerateNodeMap_nodeList_Items  1

// https://github.com/kubernetes/kubernetes/blob/master/test/e2e/storage/vsphere/nodemapper.go#L62
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_GenerateNodeMap620 = [1] of {int};
	run GenerateNodeMap62(vSphereInstances62,child_GenerateNodeMap620)
stop_process:skip
}

proctype GenerateNodeMap62(int vSphereInstances;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGenerateNodeMap110680 = [1] of {int};
	Wgdef wg;
	int nodeList_Items = GenerateNodeMap_nodeList_Items;
	run wgMonitor(wg);
		for(i : 0.. nodeList_Items-1) {
		for20: skip;
		run AnonymousGenerateNodeMap11068(wg,child_AnonymousGenerateNodeMap110680);
		wg.update!1;
		for20_end: skip
	};
	for20_exit: skip;
	wg.wait?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGenerateNodeMap11068(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

