#define lb_for360_0  -1
#define ub_for360_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example293733478/scan/scan.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int s_maxPort = 5;
	Wgdef wg;
	int s_minPort = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : s_minPort.. s_maxPort) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
for10_exit:	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		
		if
		:: true -> 
			wg.Add!-1;
			goto stop_process
		:: true;
		fi;
		break
	od;
for11_exit:	wg.Add!-1;
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
