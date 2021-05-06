
// https://github.com/go-gitea/gitea/blob/master/modules/log/conn_test.go#L29
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestConnLogger290 = [1] of {int};
	run TestConnLogger29(child_TestConnLogger290)
stop_process:skip
}

proctype TestConnLogger29(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestConnLogger87673 = [1] of {int};
	chan child_AnonymousTestConnLogger83672 = [1] of {int};
	chan child_AnonymousTestConnLogger73671 = [1] of {int};
	chan child_AnonymousTestConnLogger69670 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run AnonymousTestConnLogger6967(wg,child_AnonymousTestConnLogger69670);
	run AnonymousTestConnLogger7367(wg,child_AnonymousTestConnLogger73671);
	wg.wait?0;
	wg.update!2;
	run AnonymousTestConnLogger8367(wg,child_AnonymousTestConnLogger83672);
	run AnonymousTestConnLogger8767(wg,child_AnonymousTestConnLogger87673);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestConnLogger6967(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype AnonymousTestConnLogger7367(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype AnonymousTestConnLogger8367(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype AnonymousTestConnLogger8767(Wgdef wg;chan child) {
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

