
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example786039805/libbeat/publisher/pipeline/stress/run.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int config_Generate_Worker = 5;
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
		run Anonymous2(genWG)
	:: true;
	fi;
	goto stop_process;
	genWG.Wait?0
stop_process:}

proctype stresswithWG(Wgdef wg;chan child) {
	bool closed; 
	int i;
	wg.Add!1;
	run Anonymous1();
	child!0;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous2(Wgdef genWG) {
	bool closed; 
	int i;
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
