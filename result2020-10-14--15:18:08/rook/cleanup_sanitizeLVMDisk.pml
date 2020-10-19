#define sanitizeLVMDisk_osdLVMList  60
#define sanitizeLVMDisk_pvs  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example175971189/pkg/daemon/ceph/cleanup/disk.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int osdLVMList = sanitizeLVMDisk_osdLVMList;
	Wgdef wg;
	int i;
	Wgdef wg2;
	int pvs = sanitizeLVMDisk_pvs;
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
	bool state;
	wg.Add!-1;
stop_process:
}
proctype go_sexecuteSanitizeCommand(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
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
