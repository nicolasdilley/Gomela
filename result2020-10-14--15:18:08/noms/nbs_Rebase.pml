#define Rebase_ts_novel  60
#define Rebase_specs  60
#define Rebase_tablesToOpen  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example581771142/go/nbs/table_set.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int ts_novel = Rebase_ts_novel;
	bool state = false;
	int tablesToOpen = Rebase_tablesToOpen;
	Wgdef wg;
	int specs = Rebase_specs;
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
