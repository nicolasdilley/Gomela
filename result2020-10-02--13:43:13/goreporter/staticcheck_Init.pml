
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example944348109/linters/staticcheck/lint.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int m = 5;
	int prog_Prog_AllPackages = 5;
	Wgdef wg;
	int n = 5;
	bool state = false;
	int prog_AllFunctions = 5;
	int names = 5;
	int deprecated = 5;
	int i;
		for(i : 1.. prog_AllFunctions) {
for10:
	};
	run wgMonitor(wg);
		for(i : 1.. prog_Prog_AllPackages) {
for20:		wg.Add!1;
		run Anonymous0()
	};
	wg.Wait?0;
		for(i : 1.. deprecated) {
for30:				for(i : 1.. m) {
for31:
		}
	}
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
		for(i : 1.. names) {
for21:		
		if
		:: true -> 
			
			if
			:: 0 != -1 && n-1 != -1 -> 
								for(i : 0.. n-1) {
for22:
				}
			:: else -> 
				do
				:: true -> 
for22:
				:: true -> 
					break
				od
			fi;
for22_exit:
		:: true;
		fi
	};
stop_process:
}
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