#define StatBlobs_blobs 3
#define StatBlobs_sto_readReplicas 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example826291225/pkg/blobserver/replica/replica.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int sto_readReplicas = StatBlobs_sto_readReplicas;
	Wgdef group_wg;
	bool state = false;
	int blobs = StatBlobs_blobs;
	int i;
		for(i : 0.. blobs-1) {
for10:
	};
	run wgMonitor(group_wg);
		for(i : 0.. sto_readReplicas-1) {
for20:
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

