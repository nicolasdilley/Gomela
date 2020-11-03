#define worker_payload_edges 3
#define worker_mut_dependentMutations 1
#define worker_mut_conflictKeys 1
#define worker_arr 3
#define lb_for157_4  -1
#define ub_for157_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example411586957/worker/executor.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int payload_edges = worker_payload_edges;
	int i;
	int mut_conflictKeys = worker_mut_conflictKeys;
	Wgdef writer_wg;
	int mut_dependentMutations = worker_mut_dependentMutations;
	int arr = worker_arr;
	bool state = false;
	run wgMonitor(writer_wg);
		for(i : 0.. payload_edges-1) {
for10:		do
		:: true -> 
for11:			
			if
			:: true -> 
				break
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi
			fi
		od;
for11_exit:
	};
		for(i : 0.. mut_dependentMutations-1) {
for20:
	};
		for(i : 0.. mut_conflictKeys-1) {
for30:				for(i : 0.. arr-1) {
for31:
		}
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

