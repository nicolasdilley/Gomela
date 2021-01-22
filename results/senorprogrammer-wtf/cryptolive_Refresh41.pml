
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example543396162/modules/cryptoexchanges/cryptolive/widget.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Refresh1 = [0] of {int};
	chan child_Refresh0 = [0] of {int};
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(wg);
	wg.Add!2;
	run Refresh(wg,child_Refresh0);
	child_Refresh0?0;
	run Refresh(wg,child_Refresh1);
	child_Refresh1?0;
	wg.Wait?0
stop_process:skip
}

proctype Refresh(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Add!-1;
	stop_process: skip;
	child!0
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

