#define MarkComplete_incompleteChunks  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example920909640/storage/piece_resource.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int incompleteChunks = MarkComplete_incompleteChunks;
	

	if
	:: true -> 
		run wgMonitor(wg);
				for(i : 0.. incompleteChunks-1) {
			for10: skip;
			wg.Add!1;
			run go_Anonymous0(wg);
			for10_end: skip
		};
		for10_exit: skip;
		wg.Wait?0
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
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

