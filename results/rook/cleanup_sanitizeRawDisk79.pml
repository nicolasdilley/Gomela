#define sanitizeRawDisk_osdRawList  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example792433737/pkg/daemon/ceph/cleanup/disk.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int osdRawList = sanitizeRawDisk_osdRawList;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. osdRawList-1) {
for10:		wg.Add!1;
		run go_executeSanitizeCommand(wg)
	};
	wg.Wait?0
stop_process:}

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
