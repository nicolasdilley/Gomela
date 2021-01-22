#define sanitizeLVMDisk_osdLVMList  1
#define sanitizeLVMDisk_pvs  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example108432455/pkg/daemon/ceph/cleanup/disk.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg2;
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int pvs = sanitizeLVMDisk_pvs;
	int osdLVMList = sanitizeLVMDisk_osdLVMList;
	run wgMonitor(wg);
		for(i : 0.. osdLVMList-1) {
		for10: skip;
		wg.Add!1;
		run go_wipeLVM(wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	run wgMonitor(wg2);
		for(i : 0.. pvs-1) {
		for20: skip;
		wg2.Add!1;
		run go_executeSanitizeCommand(wg2);
		for20_end: skip
	};
	for20_exit: skip;
	wg2.Wait?0
stop_process:skip
}

proctype go_wipeLVM(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_executeSanitizeCommand(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
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

