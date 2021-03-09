#define getRoutes_drivers  3

// https://github.com/jaegertracing/jaeger/blob/1cd272535cc11895bbacf7c3fcb7b095ef0935f3/examples/hotrod/services/frontend/best_eta.go#L117
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int drivers = getRoutes_drivers;
	run wgMonitor(wg);
		for(i : 0.. drivers-1) {
		for10: skip;
		wg.Add!1;
		for10_end: skip
	};
	for10_exit: skip;
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

