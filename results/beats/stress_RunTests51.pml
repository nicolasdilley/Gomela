#define RunTests_config_Generate_Worker  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example938680676/libbeat/publisher/pipeline/stress/run.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int config_Generate_Worker = RunTests_config_Generate_Worker;
	Wgdef genWG;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(genWG);
		for(i : 0.. config_Generate_Worker-1) {
for10:		chan child_stresswithWG0 = [0] of {int};
		run stresswithWG(genWG,child_stresswithWG0);
		child_stresswithWG0?0
	};
for10_exit:	
	if
	:: true -> 
		run Anonymous1(genWG)
	:: true;
	fi;
	goto stop_process;
	genWG.Wait?0
stop_process:}

proctype stresswithWG(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	run Anonymous0();
stop_process:	child!0
}
proctype Anonymous1(Wgdef genWG) {
	bool closed; 
	int i;
	bool state;
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
