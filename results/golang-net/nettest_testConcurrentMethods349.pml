
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example343964328/nettest/conntest.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	run wgMonitor(wg);
		for(i : 0.. 100-1) {
		for10: skip;
		wg.Add!7;
		run go_Anonymous0(wg);
		run go_Anonymous1(wg);
		run go_Anonymous2(wg);
		run go_Anonymous3(wg);
		run go_Anonymous4(wg);
		run go_Anonymous5(wg);
		run go_Anonymous6(wg);
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
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous2(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous3(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous4(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous5(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous6(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
}
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

