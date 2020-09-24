
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example379071371/tools/remotecommand/v4.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_pcopyStderr1 = [0] of {int};
	Wgdef wg;
	bool state = false;
	chan child_pcopyStdout0 = [0] of {int};
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	run pcopyStdout(wg,child_pcopyStdout0);
	child_pcopyStdout0?0;
	run pcopyStderr(wg,child_pcopyStderr1);
	child_pcopyStderr1?0;
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype pcopyStdout(Wgdef wg;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
proctype pcopyStderr(Wgdef wg;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Add!1;
	run Anonymous3();
	child!0;
stop_process:
}
proctype Anonymous3() {
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
