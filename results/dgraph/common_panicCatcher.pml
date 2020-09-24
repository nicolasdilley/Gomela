
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example201344943/graphql/e2e/common/error.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef ts_wg;
	int i;
	int tests = 5;
	bool state = false;
	run wgMonitor(ts_wg);
	do
	:: true -> 
for10:
	:: true -> 
		break
	od
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od;
stop_process:
}
