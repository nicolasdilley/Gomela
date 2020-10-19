#define runWrites_writes  60
#define runWrites_ops  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example472267865/docstore/awsdynamodb/dynamo.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int ops = runWrites_ops;
	Wgdef t_wg;
	bool state = false;
	int writes = runWrites_writes;
	int i;
		for(i : 1.. writes) {
for10:
	};
	run wgMonitor(t_wg);
		for(i : 1.. ops) {
for20:		run Anonymous0()
	}
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
	od;
stop_process:
}
