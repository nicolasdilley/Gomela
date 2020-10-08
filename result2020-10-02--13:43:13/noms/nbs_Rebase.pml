
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example068066955/go/nbs/table_set.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int tablesToOpen = 5;
	Wgdef wg;
	bool state = false;
	int ts_novel = 5;
	int i;
		for(i : 1.. ts_novel) {
for10:
	};
		for(i : 1.. specs) {
for20:
	};
	run wgMonitor(wg);
		for(i : 1.. tablesToOpen) {
for30:		wg.Add!1;
		run Anonymous0()
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
