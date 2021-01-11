#define eachSliceP_s_Len10218  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example782440359/each.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef done;
	bool state = false;
	int i;
	int s_Len10218 = eachSliceP_s_Len10218;
	run wgMonitor(done);
		for(i : 0.. s_Len10218-1) {
		for10: skip;
		done.Add!1;
		run go_Anonymous0(done);
		for10_end: skip
	};
	for10_exit: skip;
	done.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef done) {
	bool closed; 
	int i;
	bool state;
	done.Add!-1;
	stop_process: skip
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

