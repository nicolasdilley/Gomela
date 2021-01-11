
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example358165944/src/source_controller/coreservice/core/operation/inner_chart.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	run wgMonitor(wg);
	wg.Add!3;
	run go_Anonymous0(wg);
	run go_Anonymous2(wg);
	run go_Anonymous4(wg);
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
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
	stop_process: skip
}
proctype ModelInstCount(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	

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
	goto stop_process;
	stop_process: skip;
	wg.Add!-1;
	child!0
}
proctype go_Anonymous2(Wgdef wg) {
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
	stop_process: skip
}
proctype ModelInstChange(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	

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
	goto stop_process;
	stop_process: skip;
	wg.Add!-1;
	child!0
}
proctype go_Anonymous4(Wgdef wg) {
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
	stop_process: skip
}
proctype BizHostCountChange(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	

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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	wg.Add!-1;
	child!0
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

