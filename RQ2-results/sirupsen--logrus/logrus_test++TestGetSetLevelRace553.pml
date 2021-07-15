
// https://github.com/sirupsen/logrus/blob/master/logrus_test.go#L553
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestGetSetLevelRace5530 = [1] of {int};
	run TestGetSetLevelRace553(child_TestGetSetLevelRace5530)
stop_process:skip
}

proctype TestGetSetLevelRace553(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestGetSetLevelRace5575570 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 100-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestGetSetLevelRace557557(wg,child_AnonymousTestGetSetLevelRace5575570);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestGetSetLevelRace557557(Wgdef wg;chan child) {
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

