#define sanitizeLVMDisk_osdLVMList  ??
#define sanitizeLVMDisk_pvs  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example792433737/pkg/daemon/ceph/cleanup/disk.go
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
		for(i : 0.. osdLVMList-1) {
for10:		wg.Add!1;
		run go_wipeLVM(wg)
	};
	wg.Wait?0;
	run wgMonitor(wg2);
		for(i : 0.. pvs-1) {
for20:		wg2.Add!1;
		run go_executeSanitizeCommand(wg2)
	};
	wg2.Wait?0
stop_process:}

proctype go_wipeLVM(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
}
proctype go_executeSanitizeCommand(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
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
