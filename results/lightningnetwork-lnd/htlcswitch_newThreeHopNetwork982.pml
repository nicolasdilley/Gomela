
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example044314819/htlcswitch/test_utils.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef carolServer_wg;
	Wgdef bobServer_wg;
	Wgdef aliceServer_wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(aliceServer_wg);
	run wgMonitor(bobServer_wg);
	run wgMonitor(carolServer_wg);
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

