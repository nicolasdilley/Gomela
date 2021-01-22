#define runGets_driver_GroupByFieldPath17724  1
#define runGets_n  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example089861707/docstore/awsdynamodb/dynamo.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef t_wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int n = runGets_n;
	int driver_GroupByFieldPath17724 = runGets_driver_GroupByFieldPath17724;
	run wgMonitor(t_wg);
	for10_exit: skip
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

