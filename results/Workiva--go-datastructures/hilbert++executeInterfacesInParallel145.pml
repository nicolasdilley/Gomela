#define executeInterfacesInParallel_int1599  3
#define executeInterfacesInParallel_numCPU  0
#define executeInterfacesInParallel_uint6416111  3

// https://github.com/Workiva/go-datastructures/blob/0819bcaf26091e7c33585441f8961854c2400faa/rtree/hilbert/action.go#L145
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int uint6416111 = executeInterfacesInParallel_uint6416111;
	int numCPU = executeInterfacesInParallel_numCPU;
	int int1599 = executeInterfacesInParallel_int1599;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	wg.Add!numCPU;
		for(i : uint6416111.. numCPU-1) {
		for10: skip;
		run go_Anonymous0(wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

