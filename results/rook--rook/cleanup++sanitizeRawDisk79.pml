#define sanitizeRawDisk_osdRawList  3

// https://github.com/rook/rook/blob/62ac1cd0017576c78598044d42d046e8a4a4c482/pkg/daemon/ceph/cleanup/disk.go#L79
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int osdRawList = sanitizeRawDisk_osdRawList;
	run wgMonitor(wg);
		for(i : 0.. osdRawList-1) {
		for10: skip;
		wg.Add!1;
		run go_executeSanitizeCommand(wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0
stop_process:skip
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

