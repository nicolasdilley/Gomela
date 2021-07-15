
// https://github.com/go-gitea/gitea/blob/master/modules/log/conn_test.go#L155
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestConnLoggerClose1550 = [1] of {int};
	run TestConnLoggerClose155(child_TestConnLoggerClose1550)
stop_process:skip
}

proctype TestConnLoggerClose155(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestConnLoggerClose2221923 = [1] of {int};
	chan child_AnonymousTestConnLoggerClose2181922 = [1] of {int};
	chan child_AnonymousTestConnLoggerClose2001921 = [1] of {int};
	chan child_AnonymousTestConnLoggerClose1941920 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run AnonymousTestConnLoggerClose194192(wg,child_AnonymousTestConnLoggerClose1941920);
	run AnonymousTestConnLoggerClose200192(wg,child_AnonymousTestConnLoggerClose2001921);
	wg.wait?0;
	wg.update!2;
	run AnonymousTestConnLoggerClose218192(wg,child_AnonymousTestConnLoggerClose2181922);
	run AnonymousTestConnLoggerClose222192(wg,child_AnonymousTestConnLoggerClose2221923);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestConnLoggerClose194192(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype AnonymousTestConnLoggerClose200192(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype AnonymousTestConnLoggerClose218192(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype AnonymousTestConnLoggerClose222192(Wgdef wg;chan child) {
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

