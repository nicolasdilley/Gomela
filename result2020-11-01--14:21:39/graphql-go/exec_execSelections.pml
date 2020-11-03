#define execSelections_fields 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example104869093/internal/exec/exec.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int fields = execSelections_fields;
	bool state = false;
	int i;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
		wg.Add!fields;
				for(i : 0.. fields-1) {
for10:			run Anonymous0(wg)
		};
		wg.Wait?0
	:: true -> 
				for(i : 0.. fields-1) {
for20:
		}
	:: true -> 
				for(i : 0.. fields-1) {
for20:
		}
	fi;
		for(i : 0.. fields-1) {
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

