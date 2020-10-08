
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example591037610/start.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int pf_Entries = 5;
	Wgdef f_wg;
	int i;
	int concurrency = 5;
	int numProcs = 5;
	bool state = false;
	run wgMonitor(f_wg);
		for(i : 1.. concurrency) {
for10:
	};
		for(i : 1.. pf_Entries) {
for20:		
		if
		:: 0 != -1 && numProcs-1 != -1 -> 
						for(i : 0.. numProcs-1) {
for21:
			}
		:: else -> 
			do
			:: true -> 
for21:
			:: true -> 
				break
			od
		fi;
for21_exit:
	};
	f_wg.Wait?0
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
