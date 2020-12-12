
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example672779410/src/source_controller/coreservice/core/operation/inner_chart.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!3;
	run Anonymous0(wg);
	run Anonymous1(wg);
	run Anonymous2(wg);
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_ModelInstCount0 = [0] of {int};
	run ModelInstCount(wg,child_ModelInstCount0);
	child_ModelInstCount0?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_ModelInstChange0 = [0] of {int};
	run ModelInstChange(wg,child_ModelInstChange0);
	child_ModelInstChange0?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:
}
proctype Anonymous2(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_BizHostCountChange0 = [0] of {int};
	run BizHostCountChange(wg,child_BizHostCountChange0);
	child_BizHostCountChange0?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
