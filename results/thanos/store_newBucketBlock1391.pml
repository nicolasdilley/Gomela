
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example601626616/pkg/store/bucket.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef b_pendingReaders;
	int i;
	int meta_Thanos_SegmentFiles = -2;
	bool state = false;
	run wgMonitor(b_pendingReaders);
	
	if
	:: true -> 
				for(i : 0.. meta_Thanos_SegmentFiles-1) {
for10:
		};
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
