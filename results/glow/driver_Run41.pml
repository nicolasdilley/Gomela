#define Run_tr_Tasks  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example089788934/driver/task_runner.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int tr_Tasks = Run_tr_Tasks;
	Wgdef wg;
	bool state = false;
	chan child_connectInputsAndOutputs0 = [0] of {int};
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	run connectInputsAndOutputs(wg,child_connectInputsAndOutputs0);
	child_connectInputsAndOutputs0?0;
		for(i : 0.. tr_Tasks-1) {
for20:		wg.Add!1;
		run Anonymous1(wg)
	};
	wg.Wait?0
stop_process:}

proctype connectInputsAndOutputs(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int strings_Split8332 = -2;
	
	if
	:: true -> 
				for(i : 0.. strings_Split8332-1) {
for10:
		}
	:: true;
	fi;
stop_process:	child!0
}
proctype Anonymous1(Wgdef wg) {
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
