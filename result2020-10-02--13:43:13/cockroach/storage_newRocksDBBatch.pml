
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example672862733/pkg/storage/rocksdb.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef r_commitWG;
	int i;
	Wgdef r_distinct_rocksDBBatch_commitWG;
	bool state = false;
	run wgMonitor(r_commitWG);
	run wgMonitor(r_distinct_rocksDBBatch_commitWG);
	goto stop_process
stop_process:}

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
