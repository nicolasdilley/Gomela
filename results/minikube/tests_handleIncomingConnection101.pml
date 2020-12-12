
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example394682930/pkg/minikube/tests/ssh_mock.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Add!1;
	run Anonymous0(wg);
		for(i : 0.. chans-1) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. requests-1) {
for11:			chan child_handleRequest0 = [0] of {int};
			run handleRequest(wg,child_handleRequest0);
			child_handleRequest0?0
		}
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
stop_process:
}
proctype handleRequest(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	run Anonymous1();
stop_process:	child!0
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
