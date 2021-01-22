#define stdserve_listeners  1
#define stdserve_numLoops  1
#define stdserve_s_loops  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example260673746/evio_std.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef s_lnwg;
	Wgdef s_loopwg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int s_loops = stdserve_s_loops;
	int numLoops = stdserve_numLoops;
	int listeners = stdserve_listeners;
	run wgMonitor(s_loopwg);
	run wgMonitor(s_lnwg);
	s_loopwg.Add!numLoops;
	s_lnwg.Add!listeners;
	goto stop_process;
	s_loopwg.Wait?0;
	s_loopwg.Add!s_loops;
	s_lnwg.Wait?0;
	s_loopwg.Wait?0
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

