
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example837123610/pkg/daemon/ceph/cleanup/disk.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg2;
	Wgdef wg;
	int pvs = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. osdLVMList) {
for10:		wg.Add!1;
		run go_swipeLVM(wg)
	};
	wg.Wait?0;
	run wgMonitor(wg2);
		for(i : 1.. pvs) {
for20:		wg2.Add!1;
		run go_sexecuteSanitizeCommand(wg2)
	};
	wg2.Wait?0
stop_process:}

proctype go_swipeLVM(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
}
proctype go_sexecuteSanitizeCommand(Wgdef wg) {
	bool closed; 
	int i;
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