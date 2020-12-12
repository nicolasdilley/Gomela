
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example109322714/internal/lsp/cache/snapshot.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int s_ids = -2;
	Wgdef newGen_wg;
	int i;
	int s_metadata = -2;
	int ids = -2;
	bool state = false;
	run wgMonitor(newGen_wg);
	
	if
	:: true -> 
				for(i : 0.. s_metadata-1) {
for80:
		}
	:: true;
	fi;
copyIDs:			for(i : 0.. s_ids-1) {
for140:				for(i : 0.. ids-1) {
for141:
		}
	};
	goto stop_process
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
