
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example063569793/internal/exec/exec.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int fields = 5;
	bool state = false;
	int i;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
		wg.Add!fields;
				for(i : 1.. fields) {
for10:			run Anonymous0(wg)
		};
		wg.Wait?0
	:: true -> 
				for(i : 1.. fields) {
for20:
		}
	:: true -> 
				for(i : 1.. fields) {
for20:
		}
	fi;
		for(i : 1.. fields) {
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	}
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
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
