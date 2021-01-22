
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example044314819/lntest/fee_service.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef f_wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(f_wg);
	f_wg.Add!1;
	run go_Anonymous0(f_wg);
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef f_wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	f_wg.Add!-1
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

