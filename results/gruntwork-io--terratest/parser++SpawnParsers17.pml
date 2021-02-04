
// https://github.com/gruntwork-io/terratest/blob/d2eada2d8542026fdde0224b0e6b26b3445591ee/modules/logger/parser/parser.go#L17
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef waitForParsers;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(waitForParsers);
	waitForParsers.Add!2;
	run go_Anonymous0(waitForParsers);
	run go_Anonymous1(waitForParsers);
	waitForParsers.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef waitForParsers) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	waitForParsers.Add!-1
}
proctype go_Anonymous1(Wgdef waitForParsers) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	waitForParsers.Add!-1
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

