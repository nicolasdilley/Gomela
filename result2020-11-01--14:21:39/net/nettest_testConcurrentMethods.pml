
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example618374887/nettest/conntest.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. 100-1) {
for10:		wg.Add!7;
		run Anonymous0();
		run Anonymous1();
		run Anonymous2();
		run Anonymous3();
		run Anonymous4();
		run Anonymous5();
		run Anonymous6()
	};
for10_exit:	wg.Wait?0
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous2() {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous3() {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous4() {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous5() {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous6() {
	bool closed; 
	int i;
	bool state;
stop_process:
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
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
}
