#define getAttributes_devices  3

// https://github.com/influxdata/telegraf/blob/6ed1431348c200760443c2a0422b0d54bea927ec/plugins/inputs/smart/smart.go#L501
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int devices = getAttributes_devices;
	run wgMonitor(wg);
	wg.Add!devices;
		for(i : 0.. devices-1) {
		for10: skip;
		run go_gatherDisk(wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0
stop_process:skip
}

proctype go_gatherDisk(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

