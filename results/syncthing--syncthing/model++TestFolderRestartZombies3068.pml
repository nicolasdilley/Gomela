
// https://github.com/syncthing/syncthing/blob/master/lib/model/model_test.go#L3068
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestFolderRestartZombies30680 = [1] of {int};
	run TestFolderRestartZombies3068(child_TestFolderRestartZombies30680)
stop_process:skip
}

proctype TestFolderRestartZombies3068(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestFolderRestartZombies309630930 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 25-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestFolderRestartZombies30963093(wg,child_AnonymousTestFolderRestartZombies309630930);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestFolderRestartZombies30963093(Wgdef wg;chan child) {
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

