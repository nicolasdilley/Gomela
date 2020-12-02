#define eachSliceP_s_Len10218  0

// /tmp/clone-example118622225/each.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef done;
	int i;
	int s_Len10218 = eachSliceP_s_Len10218;
	bool state = false;
	run wgMonitor(done);
		for(i : 0.. s_Len10218-1) {
for10:		done.Add!1;
		run Anonymous0(done)
	};
for10_exit:	done.Wait?0
stop_process:}

proctype Anonymous0(Wgdef done) {
	bool closed; 
	int i;
	bool state;
	done.Add!-1;
stop_process:
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
