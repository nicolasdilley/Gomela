
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example175635551/pkg/dep/depCheck.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int pkgs = 5;
	Wgdef wg;
	int i;
	int innerConflicts = 5;
	int conflicts = 5;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!2;
	run Anonymous0(wg);
	run Anonymous1(wg);
	wg.Wait?0;
	
	if
	:: true -> 
				for(i : 1.. innerConflicts) {
for10:						for(i : 1.. pkgs) {
for11:
			}
		}
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 1.. conflicts) {
for20:						for(i : 1.. pkgs) {
for21:
			}
		}
	:: true;
	fi;
		for(i : 1.. innerConflicts) {
for30:				for(i : 1.. pkgs) {
for31:
		}
	};
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
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
