
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example547312666/main.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int data_Services = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. data_Services) {
for10:		wg.Add!1;
		run go_serviceUpdate(wg)
	};
	wg.Wait?0
stop_process:}

proctype go_serviceUpdate(Wgdef wg) {
	bool closed; 
	int i;
		for(i : 1.. s_stacks) {
for11:
	};
	wg.Add!-1;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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