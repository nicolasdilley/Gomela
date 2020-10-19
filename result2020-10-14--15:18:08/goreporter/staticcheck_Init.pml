#define Init_prog_AllFunctions  60
#define Init_prog_Prog_AllPackages  60
#define Init_names  60
#define Init_n  60
#define Init_deprecated  60
#define Init_m  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example286720036/linters/staticcheck/lint.go
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
	bool state;
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
