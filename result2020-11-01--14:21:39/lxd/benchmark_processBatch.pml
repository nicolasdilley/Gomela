#define processBatch_batches 3
#define processBatch_batchSize 0
#define processBatch_remainder 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example608257071/lxd-benchmark/benchmark/batch.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int batchSize = processBatch_batchSize;
	Wgdef wg;
	int i;
	int batches = processBatch_batches;
	int remainder = processBatch_remainder;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: 0 != -1 && batches-1 != -1 -> 
				for(i : 0.. batches-1) {
for10:						for(i : 0.. batchSize-1) {
for11:				wg.Add!1
			};
for11_exit:			wg.Wait?0
		}
	:: else -> 
		do
		:: true -> 
for10:						for(i : 0.. batchSize-1) {
for11:				wg.Add!1
			};
for11_exit:			wg.Wait?0
		:: true -> 
			break
		od
	fi;
for10_exit:		for(i : 0.. remainder-1) {
for20:		wg.Add!1
	};
for20_exit:	wg.Wait?0;
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

