#define runWrites_ops  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example266186811/docstore/awsdynamodb/dynamo.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef t_wg;
	bool state = false;
	int i;
	int ops = runWrites_ops;
	run wgMonitor(t_wg);
	for20_exit: skip
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

