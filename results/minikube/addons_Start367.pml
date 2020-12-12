#define Start_toEnableList  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example394682930/pkg/addons/addons.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef awg;
	int i;
	int toEnableList = Start_toEnableList;
	bool state = false;
	run wgMonitor(awg);
		for(i : 0.. toEnableList-1) {
for40:		awg.Add!1;
		run Anonymous0(awg)
	};
	awg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef awg) {
	bool closed; 
	int i;
	bool state;
	awg.Add!-1;
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
