#define worker_payload_edges  60
#define worker_mut_dependentMutations  60
#define worker_mut_conflictKeys  60
#define worker_arr  60
#define lb_for157_4  -1
#define ub_for157_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example897304492/worker/executor.go
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
		for(i : 1.. payload_edges) {
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
		for(i : 1.. mut_dependentMutations) {
for20:
	};
		for(i : 1.. mut_conflictKeys) {
for30:				for(i : 1.. arr) {
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
	od;
stop_process:
}
