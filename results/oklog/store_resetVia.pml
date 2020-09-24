#define c_pending  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example419004507/pkg/store/consume.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int c_pending = 5;
	Wgdef wg;
	int ids = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. c_pending) {
for10:		wg.Add!ids;
		do
		:: true -> 
for11:			run Anonymous0(wg)
		:: true -> 
			break
		od
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
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
	wg.Add!-1;
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
