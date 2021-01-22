
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example000849088/udf/test/test_udf.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef u_Server_ioGroup;
	Wgdef u_Server_requestsGroup;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(u_Server_requestsGroup);
	run wgMonitor(u_Server_ioGroup);
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

