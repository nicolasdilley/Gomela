#define updateLatency_cp_parent  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example273423399/parent_proxy.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int cp_parent = updateLatency_cp_parent;
	run wgMonitor(wg);
	wg.Add!cp_parent;
	wg.Wait?0
stop_process:skip
}

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

