#define ProxyMetrics_jsonMetricsByDestination  3

// https://github.com/stripe/veneur/blob/590f2c060515bd818c0e566047256590cf41b838/proxy.go#L587
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int jsonMetricsByDestination = ProxyMetrics_jsonMetricsByDestination;
	run wgMonitor(wg);
	wg.Add!jsonMetricsByDestination;
		for(i : 0.. jsonMetricsByDestination-1) {
		for30: skip;
		run go_doPost(wg);
		for30_end: skip
	};
	for30_exit: skip;
	wg.Wait?0
stop_process:skip
}

proctype go_doPost(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
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

