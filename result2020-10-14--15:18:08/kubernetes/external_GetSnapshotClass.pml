#define GetSnapshotClass_params  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example603064843/test/e2e/storage/external/external.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef f_logsSizeWaitGroup;
	int i;
	int params = GetSnapshotClass_params;
	bool state = false;
	run wgMonitor(f_logsSizeWaitGroup);
	

	if
	:: true;
	:: true -> 
		
		if
		:: true -> 
						for(i : 1.. params) {
for10:
			}
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
						for(i : 1.. params) {
for20:
			}
		:: true;
		fi
	fi;
	goto stop_process
stop_process:}

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
	od;
stop_process:
}
