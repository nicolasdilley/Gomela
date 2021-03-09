#define notifyMigrate_cometNodeInfoMap  3

// https://github.com/Terry-Mao/gopush-cluster/blob/1c279b4d085fe66fc0cfca66bf2ddfeb0a5d3bc5/rpc/comet.go#L214
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int cometNodeInfoMap = notifyMigrate_cometNodeInfoMap;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	wg.Add!cometNodeInfoMap;
		for(i : 0.. cometNodeInfoMap-1) {
		for10: skip;
		run go_Anonymous0(wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
	

	if
	:: true -> 
		wg.Add!-1;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		wg.Add!-1;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		wg.Add!-1;
		goto stop_process
	:: true;
	fi;
	wg.Add!-1;
	stop_process: skip
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

