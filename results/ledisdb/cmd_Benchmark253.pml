
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example954423237/cmd/benchmark.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int round = -2;
	Wgdef client_wg;
	int ts = -2;
	bool state = false;
	run wgMonitor(client_wg);
for10_exit:	
	if
	:: 0 != -2 && round-1 != -3 -> 
				for(i : 0.. round-1) {
for20:						for(i : 0.. ts-1) {
for21:
			}
		}
	:: else -> 
		do
		:: true -> 
for20:						for(i : 0.. ts-1) {
for21:
			}
		:: true -> 
			break
		od
	fi;
for20_exit:
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
	od
}
