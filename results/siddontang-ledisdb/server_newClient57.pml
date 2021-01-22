
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example734730979/server/client.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef c_ldb_wg;
	Wgdef c_app_connWait;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(c_app_connWait);
	run wgMonitor(c_ldb_wg);
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

