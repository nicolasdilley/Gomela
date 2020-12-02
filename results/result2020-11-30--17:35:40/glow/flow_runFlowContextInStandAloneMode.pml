#define runFlowContextInStandAloneMode_fc_Steps  3
#define runFlowContextInStandAloneMode_step_Inputs  0

// /tmp/clone-example546184894/flow/context_run.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int fc_Steps = runFlowContextInStandAloneMode_fc_Steps;
	Wgdef wg;
	int step_Inputs = runFlowContextInStandAloneMode_step_Inputs;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. fc_Steps-1) {
for10:				for(i : 0.. step_Inputs-1) {
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
	bool state;
stop_process:	wg.Add!-1
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
}
proctype Anonymous2(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
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
