
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example632096367/pkg/minikube/tests/ssh_mock.go
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
		for(i : 1.. chans) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 1.. requests) {
for11:			chan child_shandleRequest0 = [0] of {int};
			run shandleRequest(wg,child_shandleRequest0);
			child_shandleRequest0?0
		}
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
}
proctype shandleRequest(Wgdef wg;chan child) {
	bool closed; 
	int i;
	wg.Add!1;
	run Anonymous2();
	

	if
	:: true;
	:: true;
	fi;
	child!0;
stop_process:
}
proctype Anonymous2() {
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
