#define lb_for131_0  -1
#define ub_for131_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example704493025/pkg/cmd/controller/pipeline/pipelinerunner_controller.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	chan child_cstartWorkers0 = [0] of {int};
	bool state = false;
	run wgMonitor(wg);
	run cstartWorkers(wg,child_cstartWorkers0);
	child_cstartWorkers0?0;
	wg.Wait?0
stop_process:}

proctype cstartWorkers(Wgdef wg;chan child) {
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	run Anonymous1();
	do
	:: true -> 
for10:		do
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:stop_process:
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
