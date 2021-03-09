#define healObjectDir_storageDisks  3

// https://github.com/minio/minio/blob/3163a660aa79b75b725a0c6f152557e6253b900f/cmd/erasure-healing.go#L486
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int storageDisks = healObjectDir_storageDisks;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run wgMonitor(wg);
						for(i : 0.. storageDisks-1) {
				for10: skip;
				

				if
				:: true -> 
					goto for10_end
				:: true;
				fi;
				wg.Add!1;
				run go_Anonymous0(wg);
				for10_end: skip
			};
			for10_exit: skip;
			wg.Wait?0
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
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

