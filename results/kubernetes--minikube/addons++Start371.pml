#define Start_toEnableList  3

// https://github.com/kubernetes/minikube/blob/caf59caaea357eef1ac1811ec514d883297523b6/pkg/addons/addons.go#L371
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef awg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int toEnableList = Start_toEnableList;
	run wgMonitor(awg);
		for(i : 0.. toEnableList-1) {
		for40: skip;
		awg.Add!1;
		run go_Anonymous0(awg);
		for40_end: skip
	};
	for40_exit: skip;
	awg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef awg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	awg.Add!-1;
	stop_process: skip
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

