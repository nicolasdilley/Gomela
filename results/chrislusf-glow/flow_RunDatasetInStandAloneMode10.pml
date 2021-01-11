#define RunDatasetInStandAloneMode_d_Shards  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example955981196/flow/dataset_run.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_connectExternalInputChansToRead0 = [0] of {int};
	Wgdef wg;
	bool state = false;
	int i;
	int d_Shards = RunDatasetInStandAloneMode_d_Shards;
	run wgMonitor(wg);
	

	if
	:: true -> 
		run connectExternalInputChansToRead(wg,child_connectExternalInputChansToRead0);
		child_connectExternalInputChansToRead0?0
	:: true -> 
				for(i : 0.. d_Shards-1) {
			for30: skip;
			wg.Add!1;
			run go_Anonymous1(wg);
			for30_end: skip
		};
		for30_exit: skip
	:: true -> 
				for(i : 0.. d_Shards-1) {
			for30: skip;
			wg.Add!1;
			run go_Anonymous1(wg);
			for30_end: skip
		};
		for30_exit: skip
	fi;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype connectExternalInputChansToRead(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int d_ExternalInputChans = 1;
		for(i : 0.. d_ExternalInputChans-1) {
		for10: skip;
		wg.Add!1;
		for10_end: skip
	};
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype go_Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

