
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example611766508/modules/logger/parser/parser.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef waitForParsers;
	bool state = false;
	run wgMonitor(waitForParsers);
	waitForParsers.Add!2;
	run Anonymous0(waitForParsers);
	run Anonymous1(waitForParsers);
	waitForParsers.Wait?0
stop_process:}

proctype Anonymous0(Wgdef waitForParsers) {
	bool closed; 
	int i;
	bool state;
	waitForParsers.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef waitForParsers) {
	bool closed; 
	int i;
	bool state;
	waitForParsers.Add!-1;
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
	od;
stop_process:
}
