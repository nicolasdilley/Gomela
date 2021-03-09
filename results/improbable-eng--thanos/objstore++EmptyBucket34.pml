#define ub_for38_0  0

// https://github.com/improbable-eng/thanos/blob/d587ac90f67da1894af8ef62547d8e0dfb3cc5f6/pkg/objstore/testing.go#L34
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(wg);
		for(i : 0.. ub_for38_0) {
		for10: skip;
		

		if
		:: true -> 
			wg.Wait?0;
			goto stop_process
		:: true;
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0
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

