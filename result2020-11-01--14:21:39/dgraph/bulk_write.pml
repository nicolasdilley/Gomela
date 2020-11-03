#define write_preds 3
#define write_s_types 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example411586957/dgraph/cmd/bulk/schema.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int preds = write_preds;
	Wgdef w_wg;
	int s_types = write_s_types;
	bool state = false;
	run wgMonitor(w_wg);
		for(i : 0.. preds-1) {
for10:
	};
		for(i : 0.. s_types-1) {
for20:
	}
stop_process:}

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

