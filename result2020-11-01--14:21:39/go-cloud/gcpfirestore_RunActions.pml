#define RunActions_calls 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example728768862/docstore/gcpfirestore/fs.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef t_wg;
	int i;
	int calls = RunActions_calls;
	bool state = false;
	run wgMonitor(t_wg);
		for(i : 0.. calls-1) {
for10:		run Anonymous0()
	};
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
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

