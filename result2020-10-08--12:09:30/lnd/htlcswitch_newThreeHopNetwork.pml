
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example975776158/htlcswitch/test_utils.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef carolServer_wg;
	Wgdef aliceServer_wg;
	int i;
	Wgdef bobServer_wg;
	int opts = 5;
	bool state = false;
	run wgMonitor(aliceServer_wg);
	run wgMonitor(bobServer_wg);
	run wgMonitor(carolServer_wg);
		for(i : 1.. opts) {
for10:
	};
	goto stop_process
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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
