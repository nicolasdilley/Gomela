
// https://github.com/iawia002/annie/blob/master/extractors/xvideos/xvideos.go#L33
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_getSrc330 = [1] of {int};
	run getSrc33(child_getSrc330)
stop_process:skip
}

proctype getSrc33(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousgetSrc56343 = [1] of {int};
	chan child_AnonymousgetSrc50342 = [1] of {int};
	chan child_AnonymousgetSrc44341 = [1] of {int};
	chan child_AnonymousgetSrc38340 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!4;
	run AnonymousgetSrc3834(wg,child_AnonymousgetSrc38340);
	run AnonymousgetSrc4434(wg,child_AnonymousgetSrc44341);
	run AnonymousgetSrc5034(wg,child_AnonymousgetSrc50342);
	run AnonymousgetSrc5634(wg,child_AnonymousgetSrc56343);
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousgetSrc3834(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousgetSrc4434(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousgetSrc5034(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousgetSrc5634(Wgdef wg;chan child) {
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

