
// https://github.com/mattermost/mattermost-server/blob/master/services/cache/lru_test.go#L621
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestLRURace6210 = [1] of {int};
	run TestLRURace621(child_TestLRURace6210)
stop_process:skip
}

proctype TestLRURace621(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestLRURace6396271 = [1] of {int};
	chan child_AnonymousTestLRURace6326270 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run AnonymousTestLRURace632627(wg,child_AnonymousTestLRURace6326270);
	run AnonymousTestLRURace639627(wg,child_AnonymousTestLRURace6396271);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestLRURace632627(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype AnonymousTestLRURace639627(Wgdef wg;chan child) {
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

