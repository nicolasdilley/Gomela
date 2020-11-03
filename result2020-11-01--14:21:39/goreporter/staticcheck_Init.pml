#define Init_prog_AllFunctions  ??
#define Init_prog_Prog_AllPackages  ??
#define Init_names  ??
#define Init_n  ??
#define Init_deprecated  ??
#define Init_m  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example824889957/linters/staticcheck/lint.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int m = Init_m;
	int prog_Prog_AllPackages = Init_prog_Prog_AllPackages;
	Wgdef wg;
	int n = Init_n;
	bool state = false;
	int prog_AllFunctions = Init_prog_AllFunctions;
	int names = Init_names;
	int deprecated = Init_deprecated;
	int i;
		for(i : 0.. prog_AllFunctions-1) {
for10:
	};
	run wgMonitor(wg);
		for(i : 0.. prog_Prog_AllPackages-1) {
for20:		wg.Add!1;
		run Anonymous0()
	};
	wg.Wait?0;
		for(i : 0.. deprecated-1) {
for30:				for(i : 0.. m-1) {
for31:
		}
	}
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
		for(i : 0.. names-1) {
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
