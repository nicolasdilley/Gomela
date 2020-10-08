
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example927266388/flow/context_run.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int fc_Steps = 5;
	Wgdef wg;
	int step_Inputs = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. fc_Steps) {
for10:				for(i : 1.. step_Inputs) {
for11:			
			if
			:: true -> 
				wg.Add!1;
				run Anonymous0(wg)
			:: true;
			fi
		};
		wg.Add!1;
		run Anonymous1(wg);
		
		if
		:: true -> 
			
			if
			:: true -> 
				wg.Add!1;
				run Anonymous2(wg)
			:: true;
			fi
		:: true;
		fi
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
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
