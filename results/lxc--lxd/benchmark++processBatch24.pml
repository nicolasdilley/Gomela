#define processBatch_batches  0
#define processBatch_batchSize  3
#define processBatch_remainder  1

// https://github.com/lxc/lxd/blob/6c8d1ba8351d36ae4f0844a7009611b160ef4174/lxd-benchmark/benchmark/batch.go#L24
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int remainder = processBatch_remainder;
	int batchSize = processBatch_batchSize;
	int batches = processBatch_batches;
	run wgMonitor(wg);
		for(i : 0.. batches-1) {
		for10: skip;
				for(i : 0.. batchSize-1) {
			for11: skip;
			wg.Add!1;
			for11_end: skip
		};
		for11_exit: skip;
		wg.Wait?0;
		for10_end: skip
	};
	for10_exit: skip;
		for(i : 0.. remainder-1) {
		for20: skip;
		wg.Add!1;
		for20_end: skip
	};
	for20_exit: skip;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}


 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

