#define refreshTabletsUsing_cells  3
#define refreshTabletsUsing_keyspaceShards  1

// https://github.com/vitessio/vitess/blob/d09dffef0c60d5d4841cac86bdf4ed777098b60a/go/vt/orchestrator/logic/tablet_discovery.go#L72
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int keyspaceShards = refreshTabletsUsing_keyspaceShards;
	int cells = refreshTabletsUsing_cells;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run wgMonitor(wg);
				for(i : 0.. cells-1) {
			for10: skip;
			wg.Add!1;
			run go_Anonymous0(wg);
			for10_end: skip
		};
		for10_exit: skip;
		wg.Wait?0
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. keyspaceShards-1) {
			for30: skip;
			wg.Add!1;
			run go_Anonymous1(wg,wg);
			for30_end: skip
		};
		for30_exit: skip;
		wg.Wait?0
	fi
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
proctype go_Anonymous1(Wgdef wg;Wgdef wg) {
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

